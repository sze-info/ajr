---
layout: default
title: ROS 2 marker és launch
parent: Önálló feladatok
---

 




# Leírás

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

## Hozzuk létre a `my_launch_pkg` package-t

Előkövetelmény, hogy a `arj_transforms_cpp` package már buildelve és futtatható legyen.

Ha esetleg már létezne a `my_launch_pkg` package akkor töröljük. (Gépteremben elképzelehető, hogy előző félévben valaki létrehozta.)

``` bash
cd ~ && test -d "ros2_ws/src/my_launch_pkg" && echo Letezik || echo Nem letezik
```

``` bash
rm -r  ~/ros2_ws/src/my_launch_pkg
```

Nyissunk egy új terminált, és source-oljuk a telepítést (ha nincs `bashrc`-ben), hogy a `ros2` parancsok működjenek.

Navigáljunk az már létrehozott `ros2_ws` könyvtárba.

Fontos, hogy a csomagokat az `src` könyvtárban kell létrehozni, nem a munkaterület gyökerében. Tehát navigáljunk a `ros2_ws/src` mappába, és futtassuk a package létrehozó parancsot:

``` bash
cd ~/ros2_ws/src
```

``` bash
ros2 pkg create --build-type ament_cmake my_launch_pkg
```

A terminál egy üzenetet küld vissza, amely megerősíti a `my_launch_pkg` csomag és az összes szükséges fájl és mappa létrehozását.

## Launch mappa

Hozzunk létre egy mappát a launch fájlok részére:

``` bash
cd ~/ros2_ws/src/my_launch_pkg
```

``` bash
mkdir launch
```

## Launch fájl létrehozása

``` bash
cd launch
```

``` bash
code run_transforms_and_markers.launch.py
```

Állítsunk össze egy launch fájlt: 

``` py
from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch_ros.substitutions import FindPackageShare


def generate_launch_description():
    return LaunchDescription([
        # ros2 run arj_transforms_cpp pub_transforms
        Node(
            package='arj_transforms_cpp',
            executable='pub_transforms',
        ),
        # ros2 run rqt_reconfigure rqt_reconfigure
        Node(
            package='rqt_reconfigure',
            executable='rqt_reconfigure',
        ),
        # ros2 run tf2_ros static_transform_publisher --x 1.0 --y 0.2 --z 1.4 --qx 0.0 --qy 0.0 --qz 0.0 --qw 1.0 --frame-id orbit2 --child-frame-id orbit3
        Node(
            package='tf2_ros',
            executable='static_transform_publisher',
            arguments=['1.0', '0.2', '1.4','0', '0', '0', '1', 'orbit2','orbit3'],
        ),     
        # ros2 launch arj_transforms_cpp rviz1.launch.py
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource([
                FindPackageShare("arj_transforms_cpp"), '/launch/', 'rviz1.launch.py'])
        ),
    ])
```


## `ROS2` launch használata

A létrehozott launch fájl elindítása az alábbi módon történik:

``` bash
cd ~/ros2_ws/src/my_launch_pkg/launch # belépünk a launch fájlt tartalmazó mappába
```
``` bash
ros2 launch run_transforms_and_markers.launch.py
```

A fent bemutatott direkt módon kívül egy launch fájl futtatható csomag által is:

``` bash
ros2 launch <csomag_megnevezése> <launch_fájl_neve>
```

Olyan csomagok esetében, amelyek launch fájlt tartalmaznak, érdemes létrehozni egy ```exec_depend``` függőséget a ```ros2launch``` csomagra vonatkozóan a csomag ```package.xml``` fájljában:

``` xml
<exec_depend>ros2launch</exec_depend>
```

Ezzel biztosítható, hogy az ```ros2 launch``` parancs elérhető a csomag buildelése után.


## Adjuk hozzá a package-hez, hogy bárhonnan indíthassuk

``` bash
cd ~/ros2_ws/src/my_launch_pkg
```

``` bash
code .
```

A package.xml-hez a `<test_depend>` elé szúrjuk be következő sort:

``` xml
<exec_depend>ros2launch</exec_depend>
```

A CMakeLists.txt-hez a `ament_package()` elé szúrjuk be következő 2 sort:

``` cmake
install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME})
```

Buildeljük a szokáso módon:

``` bash
cd ~/ros2_ws
```

``` bash
colcon build --packages-select my_launch_pkg
```

``` bash
source ~/ros2_ws/install/setup.bash
```

Ez a parancs most már __bárhonnan__ kiadható:

``` bash
ros2 launch my_launch_pkg run_transforms_and_markers.launch.py
```



# Források
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Cpp-Publisher-And-Subscriber.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Cpp-Publisher-And-Subscriber.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Py-Publisher-And-Subscriber.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Py-Publisher-And-Subscriber.html)