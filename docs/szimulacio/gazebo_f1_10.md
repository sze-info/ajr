---
layout: default
title: Gazebo F1/10
parent: Szimuláció
---

# Gazebo F1/10

A szükésges csomagok (mint a TEB local planner, gazebo szimulátor bizonyos csomagjai) így telepíthetőek:
```
sudo apt-get -y install ros-melodic-ros-control ros-melodic-gazebo-ros-control ros-melodic-ros-controllers ros-melodic-navigation qt4-default ros-melodic-ackermann-msgs ros-melodic-serial ros-melodic-teb-local-planner*
```

Készítsünk egy külön workspace-t, hogy később könnyen törölhessük, ha már nem kell. A `git clone` parancs utáni `.` direkt van, így plusz könyvtár nélül klónoz. A többi parancs ismerős az előző gyakorlatokról.

```
mkdir sim_ws
cd sim_ws/
git clone https://github.com/linklab-uva/f1tenth_gtc_tutorial .
catkin init
catkin build
```

Hogy ne kelljen minden terminalban megadnunk a workspace-t, tegyük a bashrc-be. Ha ezt nem szerenénk, elég mindig kiadni a `source ~/sim_ws/devel/setup.bash` parancsot.

```
echo "source ~/sim_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
```
Később a `bashrc`-ből törölhető ez a sor, nyissuk meg vs code-ból: `code ~/.bashrc`.

## Egy egyszerűbb példa

Külön terminalban `roscore` után nyissuk meg a szimulátort (az első indítás gyakran *lassú*, de aztán relatív gyors lesz):

```
roslaunch racecar_gazebo racecar.launch
```
Szintén külön terminalban nyissunk meg egy egyszerű alkalmazást, amely alapértelmezetten a `/cmd_vel` parancsot publikálja, így irányítva az autót.

```
rosrun rqt_robot_steering rqt_robot_steering
```

Szintén külön terminalban néézük meg `rqt_graph` segítségével, hogyan kommunkiálnak egymással az ROS node-ok.

```
rosrun rqt_graph rqt_graph
```

Több nézet is beállítható, de valami hasonlót fogunk látni:

![](others/rosgraph01.svg)

## Egy összetettebb példa

Nyissuk meg a szimulátort:

```
roslaunch racecar_gazebo racecar.launch
```

A következő a navigation stack indítása. Ez a következő részeket tartalmazza:

- AMCL (Adaptive Monte Carlo Localization)
- global planner based on global costmap
- TEB local planner based on local costmap
- robot controller

```
roslaunch platform navigation.launch
```

A következő parancs indítja az rviz-t is. Itt a 2D nav goal-ra kattintva a térkép bármely részére elnavigál a robot (TEB local planner-t használva).

```
roslaunch console navigation.launch
```

