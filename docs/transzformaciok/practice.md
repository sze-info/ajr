---
title: Gyakorlat - Transzformációk
icon: material/code-braces-box # gyakorlati tananyag
---

# Gyakorlat

A következő gyakorlat a transzformációk ROS2-ben történő kezelését szemlélteti, C++-ban.

!!! danger "Python megfelelője"
    A C++ kód python verziója szintén elérhető a [github.com/sze-info/arj_packages](https://github.com/sze-info/arj_packages/tree/main/arj_transforms_py) címen. Érdemes összehasonlítani a C++ és a python kódokat.

Frissítsük a legújabb verzióra az `arj_packages` repo-t. Ha frissül, vagy `Already up to date.` üzenetet kapunk, akkor nem kell klónoznunk. Ha a `cd ~/ros2_ws/src/arj_packages` parancs után a `~/ros2_ws/src/arj_packages: No such file or directory` üzenetetet kaptuk, akkor klónozzuk a repo-t.

``` bash
cd ~/ros2_ws/src/arj_packages
```
``` bash
git pull
```

Amennyiben a `No such file or directory` üzenetetet kaptuk, klónozzuk a következő parancsokkal:


!!! warning
    A következő két parancs csak nem létező `arj_packages` esetén kell:


``` bash
cd ~/ros2_ws/src
```
``` bash
git clone https://github.com/sze-info/arj_packages
```


Ha már létezik, akkor az előző lépés helyett, csak frissítsük.

``` bash
cd ~/ros2_ws/src/arj_packages/
```
``` bash
git status
```
A `git checkout -- .`: Minden nem staged (unstaged) változás elvetése lokálisan. VS code-ban kb ez a "discard all changes" parancs lenne.
``` bash
git checkout -- .
```
``` bash
git pull
```

Ezután már buildelhetünk is:

``` bash
cd ~/ros2_ws
```
``` bash
colcon build --packages-select arj_transforms_cpp
```

Célszerű új terminalban source-olni, majd futtatni:

``` bash
source ~/ros2_ws/install/setup.bash
```
``` bash
ros2 run arj_transforms_cpp pub_transforms
```

Vizsgáljuk meg, nyers adatként milyen kimenetet kapunk:


``` r
ros2 topic echo /tf
``` 

Erre a válasz hasonló lesz: 

``` r
transforms:
- header:
    stamp:
      sec: 1693475112
      nanosec: 95339579
    frame_id: orbit1
  child_frame_id: orbit2
  transform:
    translation:
      x: -2.487199068069458
      y: 0.25266680121421814
      z: 0.0
    rotation:
      x: 0.0
      y: 0.0
      z: 0.0
      w: 1.0
---
transforms:
- header:
    stamp:
      sec: 1693475112
      nanosec: 145005518
    frame_id: map
  child_frame_id: orbit1
  transform:
    translation:
      x: -4.109088897705078
      y: 2.8487515449523926
      z: 0.0
    rotation:
      x: 0.0
      y: 0.0
      z: -0.46381551598382736
      w: 0.8859318072699817

``` 
Ahogy láthatjuk a `map` frame `child_frame_id`-ja `orbit1`. Az `orbit1` frame `child_frame_id`-ja pedig az `orbit2`. Tehát, ha a `map`-et naygszülőnek tekintjük, akkor az `orbit2` az unoka. Szemléletesebb ezt az `rqt_tf_tree` segítségével megvizsgálni.

``` r
ros2 run rqt_tf_tree rqt_tf_tree
```

![frames01](frames01.svg)

Ha esetleg nem működne a fenti parancs, akkor telepíthető a `sudo apt install ros-humble-rqt-tf-tree` segítségével. Géptermi gépeken erre elvileg nincs szükség.


Nézzük meg RVIZ2 segítségével, így fog kinézni:

``` r
ros2 launch arj_transforms_cpp rviz1.launch.py
```

![transforms01](https://raw.githubusercontent.com/sze-info/arj_packages/main/arj_transforms_cpp/img/transforms01.gif)


Vizsgáljuk meg a `pub_transforms.cpp` fájlt. (Python esetén a `_py` package-ben a `transforms.py` fájlt.)

``` bash
cd ~/ros2_ws/src/arj_packages/arj_transforms_cpp
```

``` bash
code .
```

A legérdekesebb most talán a `loop` függvény. Pitagorasz tétele értelmében `tr1.transform.translation.x` és `y` a színusz és a koszinusz szögfüggvények miatt mindig egy körön fog elhelyezkedni. A `loop_count_` változó folyamatosan növekszik, így a kört az `x` és az `y` óramutató járásának megfelelően teszi meg. Ez a `speed1` értékének megfeleően gyorsítható `rqt_reconfigure` segítségével (ezt később megnézzük). A kör nagysága, az origo-tól való távolsága pedig a `distance1` segítségével növelhető. Hasonló a helyzet a `tr2.transform` esetében is, ami az `orbit1` -> `orbit2` transzfomot adja. A `tr1.transform` egy plusz forgatást is jelent, quaternion segítségével. A roll, pitch, yaw értékekből csak az utóbbinál forgatunk, tehát csak Z tengely szerint. 

``` cpp
void loop()
{
    // Publish transforms
    tr1.header.stamp = this->get_clock()->now();
    tr1.header.frame_id = "map";
    tr1.child_frame_id = "orbit1";
    tr1.transform.translation.x = sin(loop_count_ * speed1) * distance1;
    tr1.transform.translation.y = cos(loop_count_ * speed1) * distance1;
    tf2::Quaternion quaternion1;
    quaternion1.setRPY(0.0, 0.0, loop_count_ * speed1);
    quaternion1=quaternion1.normalize();
    tr1.transform.rotation.x = quaternion1.x();
    tr1.transform.rotation.y = quaternion1.y();
    tr1.transform.rotation.z = quaternion1.z();
    tr1.transform.rotation.w = quaternion1.w();
    tf_broadcaster_->sendTransform(tr1);
    tr2.header.stamp = this->get_clock()->now();
    tr2.header.frame_id = "orbit1";
    tr2.child_frame_id = "orbit2";
    tr2.transform.translation.x = sin(loop_count_ * speed2) * distance2;
    tr2.transform.translation.y = cos(loop_count_ * speed2) * distance2;
    tf_broadcaster_->sendTransform(tr2);
    loop_count_++;
}
```


Bővítsük `orbit3` statikus transformmal:

``` r
ros2 run tf2_ros static_transform_publisher --x 1.0 --y 0.2 --z 1.4 --qx 0.0 --qy 0.0 --qz 0.0 --qw 1.0 --frame-id orbit2 --child-frame-id orbit3
```

Állítsuk a sebességeket és a távolságokat:

``` r
ros2 run rqt_reconfigure rqt_reconfigure
```

![](rqt_reconf01.png)



Hirdessünk egy markert, majd adjuk hozzá RVIZ2-ben. Ez a parancs `orbit2`-re hirdet egy zöld kockát:

``` r
ros2 topic pub --rate 40 --print 40 /marker_topic2 visualization_msgs/msg/Marker '{header: {frame_id: "orbit2"}, ns: "markers2", id: 2, type: 1, action: 0, pose: {position: {x: 0.0, y: 0.0, z: 0.0}, orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}}, scale: {x: 1.0, y: 1.0, z: 1.0}, color: {r: 0.2, g: 0.4, b: 0.3, a: 1.0}}'
```

Ez a parancs `orbit1`-re hirdet egy piros nyilat:

``` r
ros2 topic pub --rate 40 --print 40 /marker_topic3 visualization_msgs/msg/Marker '{header: {frame_id: "orbit1"}, ns: "markers3", id: 3, type: 0, action: 0, pose: {position: {x: 0.0, y: 0.0, z: 0.0}, orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}}, scale: {x: 1.8, y: 0.4, z: 0.4}, color: {r: 0.8, g: 0.2, b: 0.2, a: 1.0}}'
```

A `Marker` üzenet `tpye` attribútuma adja meg, hogy a marker pl `ARROW=0` vagy `CUBE=1`:

``` r
ros2 interface show  visualization_msgs/msg/Marker

...
type:
int32 ARROW=0
int32 CUBE=1
int32 SPHERE=2
int32 CYLINDER=3
int32 LINE_STRIP=4
int32 LINE_LIST=5
int32 CUBE_LIST=6
int32 SPHERE_LIST=7
int32 POINTS=8
int32 TEXT_VIEW_FACING=9
int32 MESH_RESOURCE=10
int32 TRIANGLE_LIST=11

...

```

További színekre példa lejjebb, színekről pedig bővebben: [github.com/jkk-research/colors](https://github.com/jkk-research/colors).

| .  | . | . 
|---|---|---
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_red_500.svg"> 0.96 0.26 0.21 <br />  | <img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_pink_900.svg"> 0.53 0.05 0.31 <br /> |  <img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_deep_purple_900.svg"> 0.19 0.11 0.57 <br />
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_blue_100.svg"> 0.73 0.87 0.98 <br />|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_blue_500.svg"> 0.13 0.59 0.95  <br /> |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_teal_500.svg"> 0.00 0.59 0.53  <br /> 
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_green_100.svg"> 0.78 0.90 0.79 <br /> |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_green_500.svg"> 0.30 0.69 0.31  <br /> | <img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_lime_500.svg"> 0.80 0.86 0.22  <br />
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_amber_100.svg"> 1.00 0.93 0.70 <br /> |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_amber_500.svg"> 1.00 0.76 0.03  <br />  |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_amber_900.svg"> 1.00 0.44 0.00 <br /> 
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_brown_100.svg"> 0.84 0.80 0.78 <br /> |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_brown_500.svg"> 0.47 0.33 0.28  <br />  |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_brown_900.svg"> 0.24 0.15 0.14 <br /> 
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_grey_100.svg"> 0.96 0.96 0.96 <br /> |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_grey_500.svg"> 0.62 0.62 0.62  <br /> |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_grey_900.svg"> 0.13 0.13 0.13 <br /> 




# Önálló feladat

Önálló feladatként készítsünk egy `my_launch_pkg` nevű package-t, amiben egy `run_transforms_and_markers.launch.py` elindítja a:

- node-ot, ami a `map`, `orbit1` és `orbit2` frame-ket publikálja (`ros2 run arj_transforms_cpp pub_transforms`)
- az `rqt_reconfigure`-t (`ros2 run rqt_reconfigure rqt_reconfigure`)
- a statikus `orbit3` frame-et (`ros2 run tf2_ros static_transform_publisher --x 1.0 --y 0.2 --z 1.4 --qx 0.0 --qy 0.0 --qz 0.0 --qw 1.0 --frame-id orbit2 --child-frame-id orbit3`)
- és az Rviz2-t indító launch-t is (`ros2 launch arj_transforms_cpp rviz1.launch.py`)

Ellenőrizzük rviz2-ben a helyes működést.

Tehát indítható legyen az önálló feladat végén a következő paranccsal:

``` r
ros2 launch my_launch_pkg run_transforms_and_markers.launch.py
```

Megoldás: [elérhető az önálló feladatok között](https://sze-info.github.io/arj/onallo/ros2launchmarker.html)

## Segítség az önálló feladathoz

A `ros2 run tf2_ros static_transform_publisher --x 1.0 --y 0.2 --z 1.4 --qx 0.0 --qy 0.0 --qz 0.0 --qw 1.0 --frame-id orbit2 --child-frame-id orbit3` az előző órák alapján könnyen összeállítható:

``` py
Node(
    package='tf2_ros',
    executable='static_transform_publisher',
    arguments=['1.0', '0.2', '1.4','0', '0', '0', '1', 'orbit2','orbit3'],
),     
```
!!! warning
    Nehezebb dolgunk van az Rviz2-vel, ugyanis ott egy launch fájlt kell meghívni nem egy node-ot.

Első, __de kevésbé szép__ opció, hogy bemásoljuk az eredeti launch fájlt és azt egészítjük ki:


``` py
from launch import LaunchDescription
from launch_ros.actions import Node
import os
from ament_index_python.packages import get_package_share_directory


def generate_launch_description():

    pkg_name = 'arj_transforms_cpp'
    pkg_dir = get_package_share_directory(pkg_name)


    return LaunchDescription([
        Node(
            package='rviz2',
            namespace='',
            executable='rviz2',
            name='rviz2',
            arguments=['-d', [os.path.join(pkg_dir, 'rviz', 'rviz1.rviz')]]
        )
    ])
```

Második, __sokkal szebb__ opció, hogy a launch fájlt include-oljuk a launch fájlba:

``` py
from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch_ros.substitutions import FindPackageShare


def generate_launch_description():
    return LaunchDescription([
        # ros2 launch arj_transforms_cpp rviz1.launch.py
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource([
                FindPackageShare("arj_transforms_cpp"), '/launch/', 'rviz1.launch.py'])
        ),
    ])
```




# További 

[Python notebook transform](https://nbviewer.org/github/horverno/sze-academic-python/blob/master/eload/ealeshtranszformaciok.ipynb){: .md-button .md-button-blue .mr-4 }


[Python notebook quaternion](https://github.com/sze-info/arj/blob/main/docs/transzformaciok/gps_utm.ipynb){: .md-button .md-button-purple .mr-4 }


[gps_utm.ipynb](https://github.com/sze-info/arj/blob/main/docs/transzformaciok/quaternion.ipynb){: .md-button .md-button-purple .mr-4 } 

<iframe width="560" height="315" src="https://www.youtube.com/embed/kYB8IZa5AuE?rel=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

![rh](right_hand_rule01.svg)

![lexus 3d](https://raw.githubusercontent.com/jkk-research/lexus_base/main/img/lexus3d01.gif)



# Olvasnivaló
- [articulatedrobotics.xyz/ready-for-ros-6-tf](https://articulatedrobotics.xyz/ready-for-ros-6-tf/)