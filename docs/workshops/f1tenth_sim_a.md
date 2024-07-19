---
icon: material/code-block-tags # kiegészítő tananyag
---

# `ROS 2` F1/10 Wheeltec Gazebo simulation workshop

The workshop is ROS 2 compatible [![Static Badge](https://img.shields.io/badge/ROS_2-Humble-34aec5)](https://docs.ros.org/en/humble/)

## Video

<iframe width="560" height="315" src="https://www.youtube.com/embed/90cVRC2Hd7Y?si=GUiIyuXk71Bu1uGd" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Requirements (high-level)
1. ROS 2 Humble: 🟠 see previous workshops or [docs.ros.org/en/humble/Installation.html](https://docs.ros.org/en/humble/Installation.html) 
2. Gazebo Fortress: ✅ current workshop [gazebosim.org/docs/fortress/install_ubuntu](https://gazebosim.org/docs/fortress/install_ubuntu)
3. `ROS gz bridge`:  ✅ current workshop, ROS integration. Install with a single command: `sudo apt install ros-humble-ros-gz-bridge`, [gazebosim.org/docs/fortress/ros2_integration](https://gazebosim.org/docs/fortress/ros2_integration)
4. Build and run custom worlds and models  ✅ current workshop (e.g. `F1/10` / `Wheeltec, Roboworks`) 

<figure markdown="span">
  ![Image title](https://raw.githubusercontent.com/robotverseny/robotverseny.github.io/main/img/f1tenth_wheeltec_roboworks01.png){ width="80%" }
  <figcaption>Official F1/10 vehicle vs Wheeltec Roboworks Ackermann Rosbot mini vehicle</figcaption>
</figure>

## Binary Installation on Ubuntu

Fortress binaries are provided for Ubuntu Bionic, Focal and Jammy. All of the Fortress
binaries are hosted in the osrfoundation repository. To install all of them,
the metapackage `ignition-fortress` can be installed. The following is based on [gazebosim.org/docs/fortress/install_ubuntu](https://gazebosim.org/docs/fortress/install_ubuntu).

First install some necessary tools:

```bash
sudo apt-get update
```
```bash
sudo apt-get install lsb-release wget gnupg
```

Then install Ignition Fortress:


```bash
sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
```
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
```
```bash
sudo apt-get update
```
```bash
sudo apt-get install ignition-fortress
```

All libraries should be ready to use and the `ign gazebo` app ready to be executed.

## Gazebo Fortress ROS 2 integration

Issue the following command:

```bash
sudo apt install ros-humble-ros-gz-bridge
```

## Additional settings to WSL2

!!! danger "Warning - WSL2"

    There is an [issue](https://github.com/gazebosim/gz-sim/issues/1841), which can be set even in `~/.bashrc`:

```bash
export LIBGL_ALWAYS_SOFTWARE=1
```

Set it in `~/.bashrc`:
```bash
echo "export LIBGL_ALWAYS_SOFTWARE=1" >> ~/.bashrc
```

<details>
<summary> Don't forget to source bashrc.</summary>

``` bash
source ~/.bashrc
```
</details>

After new terminal or `source`:

```bash
echo $LIBGL_ALWAYS_SOFTWARE
```

should  print `1`. Alternatively 


```bash
cat ~/.bashrc | grep LIBGL
```
should print the line.

## Check the installation


!!! success 

    Now the `ign gazebo` should work and the `ros2` commands should be available.


![](https://sze-info.github.io/arj/szimulacio/ign_gazebo_02.png)

Try at least one of the following commands:

```bash
ign gazebo
```

```bash
ign gazebo -v 4 -r ackermann_steering.sdf
```

```bash
ign gazebo shapes.sdf
```


![](https://api.gazebosim.org/1.0/images/fortress/img/snap.gif)

```bash
ign param --versions
```



## Packages and build

Detailed description of the packages and build process.

It is assumed that the workspace is `~/ros2_ws/`.


``` bash
cd ~/ros2_ws/src
```

``` bash
git clone https://github.com/rudolfkrecht/robotverseny
```

## Build

``` bash
cd ~/ros2_ws
```

``` bash
colcon build --symlink-install --packages-select robotverseny_application robotverseny_description robotverseny_bringup robotverseny_gazebo 
```


## Run

<details>
<summary> Don't forget to source before ROS commands.</summary>

``` bash
source ~/ros2_ws/install/setup.bash
```
</details>

``` bash
ros2 launch robotverseny_bringup roboworks.launch.py
```

![](https://raw.githubusercontent.com/rudolfkrecht/robotverseny/main/img/gazebo_and_rviz01.png)

## Useful commands

Publish command topic:
``` bash
ros2 topic pub --once /roboworks/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.5, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: -0.01}}"
```

Teleop twist keyboard:
``` bash
ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args -r /cmd_vel:=/roboworks/cmd_vel
```
    
Ignition info topic:
``` bash
ign topic -i --topic /model/roboworks/cmd_vel
```
Ignition echo topic:

``` bash
ign topic -et /model/roboworks/cmd_vel
```

Topics:

``` bash
ros2 topic list
```
<details>
<summary> Here are the topics.</summary>

``` bash
/clicked_point
/clock
/goal_pose
/initialpose
/joint_states
/parameter_events
/robot_description
/roboworks/cmd_vel
/roboworks/odometry
/roboworks/scan
/rosout
/tf
/tf_static
```
</details>