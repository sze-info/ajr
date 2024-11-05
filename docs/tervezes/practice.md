---
title: Gyakorlat - Tervezés
icon: material/code-braces-box # gyakorlati tananyag
---

 




# `1.` feladat

Ebben a feladatban az elméleti órán bemutatott polinom alapú lokális tervező megvalósítását fogjuk bemutatni.
Ehhez elsőként frissítsük az arj_packages repository-t!

## Clone és build

``` r
cd ~/ros2_ws/src/arj_packages/
``` 
``` r
git pull
```
Ezek után buildeljük az arj_local_planner nevű package-t!

``` r
cd ~/ros2_ws
``` 
``` r
colcon build --packages-select arj_local_planner
```
## Futtatás

Ezek után futtassuk a planner-t a launch fájl segítségével, source-olás után.

``` r
source ~/ros2_ws/install/setup.bash
``` 
``` r
ros2 launch arj_local_planner run_all.launch.py
```

Nézzük meg, milyen topicok jöttek létre (új terminálban)!

``` r
ros2 topic list
```

Létrejött a /goal_pose topic illetve a /planner/trajectory topic. A goal_pose az a célpozíció, amelyre a tervező tervez, a planner/trajectory pedig a waypoint list, maga a tervezett trajektória.
Indítsünk egy rviz-t!

``` r
ros2 run rviz2 rviz2
```

Válasszuk ki a map frame-t, illetve adjuk hozzá a /planner/trajectory topicot. Ezek után a fenti sávból a 2D Goal Pose opciót használva vegyünk fel egy goal pose-t a griden úgy, hogy az a pozitív koordináták irányában helyezkedjen el! Ekkor a tervező automatikusan ráilleszt egy polinomot a célpozícióra.

![](abrak/polinomial_traj.PNG)

Ezt az egyszerű tervezőt használhatjuk pl. mozgó célpontra (másik jármű, sáv közepe, globális trajektória egy pontja...stb) illetve statikus célpontra (pl. parkolóhely).



# `2.` feladat

Az akadály elkerülési algoritmus bemutatása szimuláció segítségével

Ellenőrizük, hogy megvannak-e a következő packagek, ha nincsenek klónozuk le őket:
 - lexus_bringup : 
``` r
git clone https://github.com/jkk-research/lexus_bringup.git
``` 
- patchworkpp
``` r
git clone https://github.com/url-kaist/patchwork-plusplus-ros.git -b ROS2
``` 


## waypointok betöltése

```r
ros2 run wayp_plan_tools waypoint_loader --ros-args -p file_name:=sim_waypoints3.csv -p file_dir:=$HOME/ros2_ws/src/sim_wayp_plan_tools/csv -r __ns:=/sim1
```

##  build

``` r
cd ~/ros2_ws/src
``` 
``` r
cd sim_wayp_plan_tools
``` 
``` r
git checkout gamma
``` 
``` r
cd ~/ros2_ws/
``` 
``` r
pip install setuptools==59.6.0
``` 

``` r
colcon build --symlink-install --packages-select gammasim_application gammasim_bringup gammasim_description gammasim_gazebo joint_attribute_publisher
``` 

## Szimuláció indiítása
``` r
source ~/ros2_ws/install/setup.bash
``` 
``` r
ros2 launch gammasim_bringup gamma.launch.py
``` 

A gazebo szimulátor bal alsó sarkában nyojunk rá a play gombra


## Filterek indítása
```r
ros2 launch arj_simple_perception filter_a.launch.py \
    cloud_topic:=/gamma/points  \
    cloud_frame:=gamma/ouster_link/ouster   \
    minZ:=-1.5 \
    minX:=0.5
```
## tf illetve lokalizáció indítása
```r
ros2 run tf2_ros static_transform_publisher 0 0 0 0 0 0 /map /map_gamma
```

```r
 ros2 run lexus_bringup current_pose_from_tf --ros-args -p output_topic:=/gamma/current_pose -p frame_id:=map -p child_frame_id:=base_link
```

## A klaszterező indítása

```r
ros2 launch lidar_cluster euclidean_grid.launch.py topic:=lidar_filter_output
```
## Az akadálykerülő algoritmus indítása
```r
ros2 launch wayp_plan_tools obstacle_avoidance_trapezoid.launch.py
```

```r
ros2 run rqt_reconfigure 
```


# Sources
- [navigation.ros.org/getting_started/index.html](https://navigation.ros.org/getting_started/index.html)
- [navigation.ros.org](https://navigation.ros.org)
- [github.com/ros-controls/gz_ros2_control](https://github.com/ros-controls/gz_ros2_control)
- [github.com/art-e-fact/navigation2_ignition_gazebo_example](https://github.com/art-e-fact/navigation2_ignition_gazebo_example)