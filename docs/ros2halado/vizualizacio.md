---
layout: default
title: ROS2 vizualizáció
parent: ROS 2 haladó 
---

 





# `ROS 2` vizualizáció


## `visualization_msgs/msg/Marker` típus

[`visualization_msgs/msg/Marker` dokumentáció](https://docs.ros2.org/foxy/api/visualization_msgs/msg/Marker.html)


## `visualization_msgs/msg/MarkerArray` típus
[`visualization_msgs/msg/MarkerArray` dokumentáció](https://docs.ros2.org/foxy/api/visualization_msgs/msg/MarkerArray.html)


## Mesh

``` r
git clone https://github.com/szenergy/rviz_markers
git checkout ros2-humble
cd ~/ros2_ws 
colcon build --packages-select rviz_markers
source ~/ros2_ws/install/setup.bash
```

![](https://raw.githubusercontent.com/wiki/szenergy/szenergy-public-resources/img/rviz02.gif)

## Színek

A Google Material Design színrendszer egy átfogó tervezési rendszer, amely pl. ROS-ban és Rviz-ben is használható. A kényelem kedvéért a következőkben felsoroljuk a hexadecimális értékeket (pl. `#F44336`) és az rgb-vé alakított értékeket (pl. `0,96 0,26 0,21`), ami a ROS 2-ben általánosan elfogadott.

Bővebben: 
- [github.com/jkk-research/colors](https://github.com/jkk-research/colors)

| `100`  | `500` | `900` 
|---|---|---
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_red_100.svg"> 1.00 0.80 0.82 <br />`md_red_100` | <img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_red_500.svg"> 0.96 0.26 0.21 <br />`md_red_500` | <img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_red_900.svg"> 0.72 0.11 0.11 <br />`md_red_900`
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_pink_100.svg"> 0.97 0.73 0.82 <br />`md_pink_100`|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_pink_500.svg"> 0.91 0.12 0.39  <br />`md_pink_500`| <img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_pink_900.svg"> 0.53 0.05 0.31 <br />`md_pink_900`
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_deep_purple_100.svg"> 0.82 0.77 0.91 <br />`md_deep_purple_100`| <img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_deep_purple_500.svg"> 0.40 0.23 0.72  <br />`md_deep_purple_500` |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_deep_purple_900.svg"> 0.19 0.11 0.57 <br />`md_deep_purple_900`
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_blue_100.svg"> 0.73 0.87 0.98 <br />`md_blue_100` |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_blue_500.svg"> 0.13 0.59 0.95  <br />`md_blue_500`|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_blue_900.svg"> 0.05 0.28 0.63 <br />`md_blue_900`
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_teal_100.svg"> 0.70 0.87 0.86 <br />`md_teal_100`|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_teal_500.svg"> 0.00 0.59 0.53  <br />`md_teal_500` |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_teal_900.svg"> 0.00 0.30 0.25 <br />`md_teal_900`
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_green_100.svg"> 0.78 0.90 0.79 <br />`md_green_100`|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_green_500.svg"> 0.30 0.69 0.31  <br />`md_green_500` |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_green_900.svg"> 0.11 0.37 0.13 <br />`md_green_900`
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_lime_100.svg"> 0.94 0.96 0.76 <br />`md_lime_100`|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_lime_500.svg"> 0.80 0.86 0.22  <br />`md_lime_500` |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_lime_900.svg"> 0.51 0.47 0.09 <br />`md_lime_900`
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_amber_100.svg"> 1.00 0.93 0.70 <br />`md_amber_100`|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_amber_500.svg"> 1.00 0.76 0.03  <br />`md_amber_500` |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_amber_900.svg"> 1.00 0.44 0.00 <br />`md_amber_900`
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_orange_100.svg"> 1.00 0.88 0.70 <br />`md_orange_100`|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_orange_500.svg"> 1.00 0.60 0.00  <br />`md_orange_500` |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_orange_900.svg"> 0.90 0.32 0.00 <br />`md_orange_900`
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_brown_100.svg"> 0.84 0.80 0.78 <br />`md_brown_100`|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_brown_500.svg"> 0.47 0.33 0.28  <br />`md_brown_500` |<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_brown_900.svg"> 0.24 0.15 0.14 <br />`md_brown_900`
|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_grey_100.svg"> 0.96 0.96 0.96 <br />`md_grey_100`|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_grey_500.svg"> 0.62 0.62 0.62  <br />`md_grey_500`|<img src="https://raw.githubusercontent.com/jkk-research/colors/main/source/md_grey_900.svg"> 0.13 0.13 0.13 <br />`md_grey_900`



# Források

- [docs.ros.org/en/humble/How-To-Guides/Visualizing-ROS-2-Data-With-Foxglove-Studio.html](https://docs.ros.org/en/humble/How-To-Guides/Visualizing-ROS-2-Data-With-Foxglove-Studio.html)
- [docs.ros.org/en/humble/Tutorials/Intermediate/Launch/Creating-Launch-Files.html](https://docs.ros.org/en/humble/Tutorials/Intermediate/Launch/Creating-Launch-Files.html)
- [docs.ros.org/en/humble/Tutorials/Intermediate/Tf2/Writing-A-Tf2-Broadcaster-Cpp.html](https://docs.ros.org/en/humble/Tutorials/Intermediate/Tf2/Writing-A-Tf2-Broadcaster-Cpp.html)
- [github.com/jkk-research/colors](https://github.com/jkk-research/colors)