---
title: Ground filter
icon: material/code-block-tags # kiegészítő tananyag
---

# Ground filter


<img src="https://raw.githubusercontent.com/url-kaist/patchwork-plusplus/master/pictures/demo_000000.png" width="80%" />

Elérhető:
- [url-kaist/patchwork-plusplus-ros/tree/ROS2](https://github.com/url-kaist/patchwork-plusplus-ros/tree/ROS2)
- [github.com/MohamedHussein736/patchwork-plusplus-ros/tree/ROS2](https://github.com/MohamedHussein736/patchwork-plusplus-ros/tree/ROS2)
- [github.com/jkk-research/patchwork-plusplus-ros](https://github.com/jkk-research/patchwork-plusplus-ros) az eredeti repo forkja, ami csak az ROS 2-es brenchet tartalmazza, az eredeti [Urban Robotics Lab](https://github.com/url-kaist/patchwork-plusplus-ros/tree/ROS2) repora a SZE-JKK pull request-jét mergelték.

``` bash
cd ~/ros2_ws/src
```

``` bash
git clone https://github.com/jkk-research/patchwork-plusplus-ros
``` 

``` bash
cd ~/ros2_ws/src
```

``` bash
colcon build --packages-select patchworkpp
```

``` bash
ros2 launch patchworkpp demo.launch
```

TODO

``` bash
ros2 bag play kitti_00_sample.db3
```