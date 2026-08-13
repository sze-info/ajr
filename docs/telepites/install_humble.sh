#!/bin/bash
# ROS 2 Humble telepito script - SZE, GKNB_AUTM078
# Hasznalat:
#   ./install_humble.sh            -> otthoni telepites
#   ./install_humble.sh campus     -> tantermi telepites (halozati megosztas csatolasa)
set -e

echo "First arg: $1"
if [ "$1" != "campus" ]; then
    echo "++++ home install settings ++++"
else
    echo "!!!! campus settings !!!!"
    sleep 2
fi

echo "++++ install script start ++++"
echo ""

locale  # check for UTF-8

sudo apt update && sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

sudo apt install software-properties-common -y
sudo add-apt-repository universe -y

# ------------------------------------------------- ROS 2 apt source (uj mod)
# A regi ros.key + ros2.list modszer helyett a ros2-apt-source csomag,
# ez a kulcsrotaciot automatikusan koveti.
echo ""
echo "++++ ROS 2 apt source ++++"
echo ""

sudo apt update -y && sudo apt install -y curl wget

ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F '"tag_name"' | awk -F'"' '{print $4}')
if [ -z "$ROS_APT_SOURCE_VERSION" ]; then
    echo "GitHub API nem elerheto, fix verzio hasznalata"
    ROS_APT_SOURCE_VERSION="1.1.0"
fi

CODENAME=$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})
curl -fL -o /tmp/ros2-apt-source.deb \
  "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.${CODENAME}_all.deb"
file /tmp/ros2-apt-source.deb | grep -q "Debian binary package" || { echo "HIBA: nem .deb toltodott le"; exit 1; }
sudo dpkg -i /tmp/ros2-apt-source.deb

# regi konfig eltavolitasa, kulonben kulcsutkozes lesz
sudo rm -f /etc/apt/sources.list.d/ros2.list
sudo rm -f /usr/share/keyrings/ros-archive-keyring.gpg

sudo apt update -y
sudo apt upgrade -y

echo ""
echo "++++ install ros 2 humble ++++"
echo ""

sudo apt install -y ros-humble-desktop
sudo apt install -y ros-dev-tools
sudo apt install -y ros-humble-rqt-tf-tree
sudo apt install -y python3-colcon-common-extensions
sudo apt install -y git

# ------------------------------------------------------------------ bashrc
echo ""
echo "++++ bashrc ++++"
echo ""

if ! grep -qF "ADDED BY INSTALL SCRIPT" ~/.bashrc; then
cat >> ~/.bashrc << EOF

#### ADDED BY INSTALL SCRIPT https://raw.githubusercontent.com/sze-info/arj/main/docs/telepites/install_humble.sh
source /opt/ros/humble/setup.bash
export RCUTILS_COLORIZED_OUTPUT=1
export LIBGL_ALWAYS_SOFTWARE=1
export ROS_DOMAIN_ID=$(( RANDOM % 100 + 1 ))
export ROS_LOCALHOST_ONLY=1
source /usr/share/colcon_cd/function/colcon_cd.sh
export _colcon_cd_root=/opt/ros/humble/
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
source ~/roscd.sh
EOF
else
    echo "a .bashrc mar tartalmazza a beallitasokat, kihagyva"
fi

# ---------------------------------------------------------------- wsl.conf
# interop nelkul a 'code .' Exec format error-ral elszall
echo ""
echo "++++ wsl.conf ++++"
echo ""

sudo tee /etc/wsl.conf > /dev/null << 'EOF'
[boot]
systemd=true

[interop]
enabled=true
appendWindowsPath=true
EOF

# ------------------------------------------------------------- workspace
echo ""
echo "++++ create workspace ++++"
echo ""

mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/sze-info/arj_packages
git clone https://github.com/jkk-research/wayp_plan_tools
git clone https://github.com/jkk-research/sim_wayp_plan_tools
git clone https://github.com/dottantgal/ros2_pid_library

cd ~/ros2_ws
source /opt/ros/humble/setup.bash
colcon build

# ------------------------------------------------- Gazebo Ignition Fortress
echo ""
echo "++++ install gazebo ignition fortress ++++"
echo ""

sudo apt-get update -y
sudo apt-get install -y lsb-release wget gnupg

sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y ignition-fortress

sudo apt install -y ros-humble-foxglove-bridge
sudo apt install -y mc
sudo apt install -y ros-humble-rosbag2-storage-mcap ros-humble-rosbag2
sudo apt install -y ros-humble-ros-gz
sudo apt install -y ros-humble-pcl-ros

# ---------------------------------------------------------- jkk_utils fajlok
echo ""
echo "++++ jkk_utils fajlok ++++"
echo ""

cd ~
wget -O ~/.bash_aliases https://raw.githubusercontent.com/jkk-research/jkk_utils/ros2/.bash_aliases
wget -O ~/qos_tf.yaml   https://raw.githubusercontent.com/jkk-research/jkk_utils/ros2/qos_tf.yaml
wget -O ~/roscd.sh      https://raw.githubusercontent.com/Martin-Oehler/ros2cd/main/roscd.sh

# -------------------------------------------------------------- campus mount
if [ "$1" = "campus" ]; then
    echo ""
    echo "!!!! campus settings !!!!"
    echo ""
    sudo mkdir -p /mnt/kozos
    if ! grep -q "/mnt/kozos" /etc/fstab; then
        echo '\\fs-kab.eik.sze.hu\C100\kozos\GKNB_AUTM078_Autonóm_robotok_és_járművek_programozása    /mnt/kozos    drvfs    defaults,uid=1000,gid=1000    0    0' | sudo tee -a /etc/fstab
    fi
    sudo mount -a || echo "FIGYELEM: a mount nem sikerult, ellenorizd az /etc/fstab sort"
fi

# ---------------------------------------------------------------- takaritas
echo ""
echo "++++ takaritas ++++"
echo ""

sudo apt autoremove -y
sudo apt clean
rm -f /tmp/ros2-apt-source.deb

echo ""
echo "++++ install script end ++++"
echo "++++ inditsd ujra: wsl --shutdown, majd wsl -d <distro> ++++"
echo ""

exec bash