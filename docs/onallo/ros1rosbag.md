---
layout: default
title: ROS1 rosbag
parent: Önálló feladatok
---

 




# Rosbag gyakorlás

## Videó

A gyakorlat a jobb érthetőség és az otthoni feldolgozás miatt akár videóként is megtekinthető. A videó szöveges magyarázat nélküli, rövidített, cserébe mutatja a parancsok kiadásától elvárható működést: [youtu.be/Hu7YseOh3qk](https://www.youtube.com/watch?v=Hu7YseOh3qk)

<iframe width="560" height="315" src="https://www.youtube.com/embed/Hu7YseOh3qk?rel=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>


## Előkészületek

A következő példák egy Turtlebot3 robot és egy Nissan Leaf önvezető autó `.bag` fájlait használják majd. A `.bag` az ROS log fájtípusa, méréseket mentésére, visszajátszására, szerkeztésére stb. szolgál.

**Vigyázat**: ROS 1-es feladat.

[![Static Badge](https://img.shields.io/badge/ROS_1-Melodic-ef4638)](https://docs.ros.org/en/humble/)

![turtle-leaf](https://raw.githubusercontent.com/horverno/ros-gyakorlatok/master/1-rosbag-es-topicok/turtle-leaf.png)

Nyissunk egy terminált (`ctr`+`alt`+`t`), hozzunk létre egy `rosbag-gyak` mappát, majd lépjünk bele.

```
mkdir ~/rosbag-gyak
cd ~/rosbag-gyak
```

Töltsük le a 2 rosbag fájlt.

```
wget www.sze.hu/~herno/PublicDataAutonomous/turtlebot-2019-03-11-SLAM-no-camera.bag
wget www.sze.hu/~herno/PublicDataAutonomous/leaf-2019-03-13-a-no-lidar.bag
```

Vizsgáljuk meg, hogy tényleg ~46MB méretű-e Turtlebot és ~9MB méretű-e a Leaf `.bag` fájl.

```
ls --size 
ls --size --block-size=M
ls -l --block-size=M
```

Nézzük meg a következő videót, ez a Turtlebot `.bag` fájl rögzítésekor készült: [youtu.be/QwagQFvhbNU](https://www.youtube.com/watch?v=QwagQFvhbNU) 

<iframe width="560" height="315" src="https://www.youtube.com/embed/QwagQFvhbNU?rel=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

_Megjegyzés_: [jkk-research.github.io/](https://jkk-research.github.io/) illetve a [www.sze.hu/~herno/PublicDataAutonomous](http://www.sze.hu/~herno/PublicDataAutonomous) linken további `.bag` fájlok találhatóak.

A terminalban indítsunk egy `roscore`-t. *Később* leááítható `ctr` + `c` segítségével.

```
roscore
```

Nyissunk egy újabb tabot a terminálban (`ctr`+`shift`+`t`). Ha nem `rosbag-gyak`-ban lennénk, `cd`-zzünk. A `-l` kapcsoló loopolja a bag-et, a `play` mondja meg, hogy lejátszuk és nem például rögzítjük a bag-et.

```
cd ~/rosbag-gyak
rosbag play -l turtlebot-2019-03-11-SLAM-no-camera.bag 
```

Később ugyanígy játszhatjuk le a `leaf-2019-03-13-a-no-lidar.bag`-et is.

<a name="term"></a>

## Topicok terminalból

Nyissunk egy újabb tabot a terminálban (`ctr`+`shift`+`t`), majd vizsgáljuik meg a topicokat.

```
rostopic list 
```
Ezt kellene látnunk.

```
    /battery_state
    /clock
    /cmd_vel
    /cmd_vel_rc100
    /constraint_list
    /diagnostics
    /firmware_version
    /flat_imu
    /imu
    /joint_states
    /landmark_poses_list
    /magnetic_field
    /map
    /move_base/TebLocalPlannerROS/parameter_descriptions
    /move_base/TebLocalPlannerROS/parameter_updates
    /move_base/global_costmap/costmap
    /move_base/global_costmap/costmap_updates
    /move_base/global_costmap/footprint
    /move_base/global_costmap/inflation_layer/parameter_descriptions
    /move_base/global_costmap/inflation_layer/parameter_updates
    /move_base/global_costmap/obstacle_layer/parameter_descriptions
    /move_base/global_costmap/obstacle_layer/parameter_updates
    /move_base/global_costmap/parameter_descriptions
    /move_base/global_costmap/parameter_updates
    /move_base/global_costmap/static_layer/parameter_descriptions
    /move_base/global_costmap/static_layer/parameter_updates
    /move_base/local_costmap/costmap
    /move_base/local_costmap/costmap_updates
    /move_base/local_costmap/footprint
    /move_base/local_costmap/inflation_layer/parameter_descriptions
    /move_base/local_costmap/inflation_layer/parameter_updates
    /move_base/local_costmap/obstacle_layer/parameter_descriptions
    /move_base/local_costmap/obstacle_layer/parameter_updates
    /move_base/local_costmap/parameter_descriptions
    /move_base/local_costmap/parameter_updates
    /move_base/parameter_descriptions
    /move_base/parameter_updates
    /move_base/status
    /odom
    /rosout
    /rosout_agg
    /rpms
    /scan
    /scan_matched_points2
    /sensor_state
    /submap_list
    /tf
    /tf_static
    /trajectory_node_list
```

Vizsgáljunk meg minél több topicot `rostopic type` illetve `rosmsg show`-val.
A `rostopic type /odom` parancs hatására megtudhatjuk az `/odom` topic típusát, ami `nav_msgs/Odometry`. 
Ha ki akarjuk deríteni a `nav_msgs/Odometry` felépítését a `rosmsg show nav_msgs/Odometry`-re lesz szükségünk.
A két parancsot kényelmesebb egybe kiadni, az első parancs kimenete lesz a második eleje egy `|`- karakter segítségével, az egész egyben pedig így néz ki:

```
rostopic type /odom | rosmsg show
```

Erre megkapjuk, ugyanazt, mint a `rosmsg show nav_msgs/Odometry`-val, is kapunk, tehát az odometria üzenet felépítését.

``` c
    std_msgs/Header header
    uint32 seq
    time stamp
    string frame_id
    string child_frame_id
    geometry_msgs/PoseWithCovariance pose
    geometry_msgs/Pose pose
        geometry_msgs/Point position
        float64 x
        float64 y
        float64 z
        geometry_msgs/Quaternion orientation
        float64 x
        float64 y
        float64 z
        float64 w
    float64[36] covariance
    geometry_msgs/TwistWithCovariance twist
    geometry_msgs/Twist twist
        geometry_msgs/Vector3 linear
        float64 x
        float64 y
        float64 z
        geometry_msgs/Vector3 angular
        float64 x
        float64 y
        float64 z
    float64[36] covariance
```
Vizsgáljunk meg minél több topicot `rostopic echo`-val. Leállítás `ctr` + `c`

```
rostopic echo /odom
```

``` c
    header: 
    seq: 22203
    stamp: 
        secs: 1552323858
        nsecs: 875916038
    frame_id: "odom"
    child_frame_id: "base_footprint"
    pose: 
    pose: 
        position: 
        x: -0.379863917828
        y: 0.126037299633
        z: 0.0
        orientation: 
        x: 0.0
        y: 0.0
        z: -0.485380351543
        w: 0.874303102493
    covariance: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    twist: 
    twist: 
        linear: 
        x: 0.151097133756
        y: 0.0
        z: 0.0
        angular: 
        x: 0.0
        y: 0.0
        z: 0.0535195507109
    covariance: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
```

!!! tip

    A gyakorlat írásakor az `rqt_plot` volt talán az egyetlen megjelenítő az adatokra, manapság erre jobb alternatívának érezzük a [Foxglove Studio](https://foxglove.dev/)t. Ezt a szoftvert több helyen fogjuk használni a tananyagban.



## rqt_plot

Indítsuk az rqt_plot-ot terminalbol, adjuk hozzá például az `/imu/linear_acceleration` topciot. 
_Megjegyzés_: az rosbag visszajátszásánál nem állítottuk be, hogy időt generáljon (pedig lehetne), de így a mérés a ploton újrakezdődhet.

```
rosrun rqt_plot rqt_plot
```

![rqtp](https://raw.githubusercontent.com/horverno/ros-gyakorlatok/master/1-rosbag-es-topicok/rqtplot-small.png)

További információ: [wiki.ros.org/rqt_plot](http://wiki.ros.org/rqt_plot)

<a name="rviz"></a>

## rviz

Indítsuk az rviz-t.

```
rosrun rviz rviz
```

Adjunk hozzá különböző topicokat: `Add` >> `By topic` >> Kiválaszt >> `Ok`.
Például így nézzen ki:

![rviz](https://raw.githubusercontent.com/horverno/ros-gyakorlatok/master/1-rosbag-es-topicok/rviz-small.png)

További információ: [wiki.ros.org/rviz](http://wiki.ros.org/rviz)

<a name="python"></a>

## python

A következőkben a [listenerTurtle.py](listenerTurtle.py) segítségével feliratkozunk az `/odom` és az `/imu` topicokra és első körben kiíratjuk az odom x és y pozícióját, valamint az imu lineáris gyorsulásait. Anonymous módon feliratkozunk a két topcira, `listener` névvel (a név gyakolratilag mellékes). Két úgynevazett callback fügvényt használunk a feliratkzáshoz.

``` python
import rospy
import std_msgs.msg as rosmsg
import nav_msgs.msg as navmsg
import sensor_msgs.msg as senmsg

def odometryCallBack(msg):
    print("odom(x,y): %8.4f %8.4f " % (msg.pose.pose.position.x, msg.pose.pose.position.y))

def imuCallBack(msg):
    print("imu(xyz):  %8.4f %8.4f %8.4f" % (msg.linear_acceleration.x, msg.linear_acceleration.y, msg.linear_acceleration.z))

rospy.init_node("listener", anonymous=True)
rospy.Subscriber("/odom", navmsg.Odometry, odometryCallBack)
rospy.Subscriber("/imu", senmsg.Imu, imuCallBack)
rospy.spin()
```

Ha nem szeretnénk klónozni a teljes repository-t, akkor `wget`-tel is letölthetjük a [listenerTurtle.py](listenerTurtle.py)-t, a [plotterLeaf.py](plotterLeaf.py)-t és a [plotterTurtle.py](plotterTurtle.py)-t.

```
wget https://raw.githubusercontent.com/horverno/ros-gyakorlatok/master/1-rosbag-es-topicok/listenerTurtle.py
wget https://raw.githubusercontent.com/horverno/ros-gyakorlatok/master/1-rosbag-es-topicok/plotterTurtle.py
wget https://raw.githubusercontent.com/horverno/ros-gyakorlatok/master/1-rosbag-es-topicok/plotterLeaf.py
```

A [plotterTurtle.py](plotterTurtle.py) és a [plotterLeaf.py](plotterLeaf.py) hasonló az előzőhöz, de terminal helyett GUI-ba írja az adatokat. A `pyqt` és a `pyqtgraph` segítségével felhasználói felületeket készíthetünk, amiket nem csupán scripként, de futtatható állományként, vagy akár telepítőként is használhatunk. Első lépésként ellenőrizzük, hogy telepítve vannak-e a szükséges package-k, a következő importokkal:

``` python
import PyQt5
import pyqtgraph
```

Amennyiben `ModuleNotFoundError`-t kapunk telepítsük a két package-t:

```
sudo apt install python3-pip
pip3 install numpy rospkg pyqt5 pyqtgraph PyYaml
```
Vagy python 2:
```
sudo apt install python-pip
pip install pyqt5 pyqtgraph
```

A Nissan leaf helyzetét több fajta módon is számíthatjuk. Lehet a bicikli kinematikai modellel és lehet a GPS alapján. A gépjármű-szerű (négy kerékkel rendelkező, első tengelyen kormányozható) robot egyszerűsített kinematikai leírására használhatjuk a bicikli modellt, ami könnyen szmolható, azonban az idő függvényében egyre nagyobb pontatlansága lesz. Ez a `/leaf/odom` topicon érhető el a Leaf .bag fájl visszajátszásával. A GPS pozíció magától érthetődőbb, szerencsére a mérés során egy különlegesen pontos GPS-t használtunk, ez a `/gps/odom` topicon érhető el. 
Vizualizáljuk a két topicot a [plotterLeaf.py](plotterLeaf.py) segítségével.

```
python plotterLeaf.py
```

![plot](https://raw.githubusercontent.com/horverno/ros-gyakorlatok/master/1-rosbag-es-topicok/py-plotter-leaf.png)

Sokkal összetetteb dolgot is megvalósíthatunk a Turtlebot .bag fájl visszajátszásával. Itt nagyon sok topicot vizualizálhatunk. 

![plot](https://raw.githubusercontent.com/horverno/ros-gyakorlatok/master/1-rosbag-es-topicok/py-plotter-turtle.png)

Vizsgáljuk meg a fájokat `VS code` segítségével (`cd ~/rosbag-gyak`, ha nem ott lennénk)

```
code .
```
Ez egy VS code környezetet nyit meg, az aktuális mappával, majd visszaadja a terminal prompt-ot.

## Forrás

ROS-gyakorlatok GitHub Pages kezdőoldal: 
[horverno.github.io/ros-gyakorlatok](https://horverno.github.io/ros-gyakorlatok/)
