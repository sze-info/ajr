---
title: Hibák
parent: Észlelés
icon: material/code-braces-box # gyakorlati tananyag
---

# `GPG error`hiba megoldása

A hiba régen telepített ROS 2 Humble rendszereken jelentkezhet, amikor a csomaglistát próbáljuk frissíteni az alábbi parancs futtatásakor:

``` bash
sudo apt update
```

A hibaüzenet valami ilyesmi lesz:

``` bash
An error occurred during the signature verification. 
The repository is not updated and the previous index files will be used. GPG error: http://packages.ros.org/ros2/ubuntu jammy InRelease: 
The following signatures were invalid: EXPKEYSIG F42ED6FBAB17C654 Open Robotics
```

Először is, töröljük a régi kulcsot:

``` bash
sudo rm /usr/share/keyrings/ros-archive-keyring.gpg
```
Töltsük le az új kulcsot:

``` bash
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
```

Add hozzá az új forrást az apt-hez:

``` bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```
Most már frissíthetjük a csomaglistát anélkül, hogy a GPG hibát kapnánk:

``` bash
sudo apt update
```

Tanteremben ugyanez egyetlen parancsban:

``` bash
/mnt/kozos/script/update_ros2_key.sh
```


# Teljesítmény-problémák megoldása

If the simulation is slow, try the following:

Add `--cmake-args -DCMAKE_BUILD_TYPE=Release` to the build command. And or adjust `--parallel-workers N` to the number of CPU cores. Example: 

``` bash
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release --parallel-workers 4 --packages-select robotverseny_application robotverseny_description robotverseny_bringup robotverseny_gazebo megoldas_sim24
```

As suggested by [DDS settings for ROS 2 and Autoware](https://autowarefoundation.github.io/autoware-documentation/main/installation/additional-settings-for-developers/network-configuration/dds-settings/): set the config file path and enlarge the Linux kernel maximum buffer size.

``` bash
# Increase the maximum receive buffer size for network packets
sudo sysctl -w net.core.rmem_max=2147483647  # 2 GiB, default is 208 KiB

# IP fragmentation settings
sudo sysctl -w net.ipv4.ipfrag_time=3  # in seconds, default is 30 s
sudo sysctl -w net.ipv4.ipfrag_high_thresh=134217728  # 128 MiB
```

To make it permanent,

``` bash
sudo nano /etc/sysctl.d/10-cyclone-max.conf
```

Paste the following into the file:
``` bash
# Increase the maximum receive buffer size for network packets
net.core.rmem_max=2147483647  # 2 GiB, default is 208 KiB

# IP fragmentation settings
net.ipv4.ipfrag_time=3  # in seconds, default is 30 s
net.ipv4.ipfrag_high_thresh=134217728  # 128 MiB, default is 256 KiB
```
Save and exit (`CTRL+O`, `ENTER`, `CTRL+X`).

Also have a look at [Network settings for ROS 2 and Autoware](https://autowarefoundation.github.io/autoware-documentation/main/installation/additional-settings-for-developers/network-configuration/) and [Performance Troubleshooting](https://autowarefoundation.github.io/autoware-documentation/main/support/troubleshooting/performance-troubleshooting/)
