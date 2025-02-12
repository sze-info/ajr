
echo "First arg: $1"
if [ "$1" != "campus" ]
then
    echo "++++ home install settings ++++"
else
    echo "!!!! campus settings !!!!"
    sleep 2
fi

echo "++++ install script start ++++"
echo ""

locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

sudo apt install software-properties-common -y
sudo add-apt-repository universe -y

sudo apt update -y && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null


sudo apt update -y
sudo apt upgrade -y

echo ""y
echo "++++ install ros 2 humble ++++"
echo ""

sudo apt install ros-humble-desktop -y
sudo apt install ros-dev-tools -y
sudo apt install ros-humble-rqt-tf-tree -y
sudo apt install python3-colcon-common-extensions -y
sudo apt install git -y


echo "" >> ~/.bashrc
echo "#### ADDED BY INSTALL SCRIPT wget https://raw.githubusercontent.com/sze-info/arj/main/docs/telepites/install_humble.sh" >> ~/.bashrc
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
echo "export RCUTILS_COLORIZED_OUTPUT=1" >> ~/.bashrc
echo "export LIBGL_ALWAYS_SOFTWARE=1" >> ~/.bashrc
echo "export ROS_DOMAIN_ID="$(( $RANDOM % 100 + 1 )) >> ~/.bashrc
echo "export ROS_LOCALHOST_ONLY=1" >> ~/.bashrc
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
echo "export _colcon_cd_root=/opt/ros/humble/" >> ~/.bashrc
echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc

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
source ~/.bashrc
colcon build

echo ""
echo "++++ install gazebo ignition fortress ++++"
echo ""

sudo apt-get update -y
sudo apt-get install lsb-release wget gnupg -y

sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt-get update -y
sudo apt-get install ignition-fortress -y
sudo apt install ros-humble-foxglove-bridge -y
sudo apt install mc -y
sudo apt install ros-humble-rosbag2-storage-mcap ros-humble-rosbag2 -y
sudo apt install ros-humble-ros-gz -y

echo "First arg: $1"
if [ "$1" != "campus" ]
then
    echo ""
else
    echo "!!!! campus settings !!!!"
    sudo mkdir /mnt/kozos
    #sudo mount -t drvfs '\\fs-kab.eik.sze.hu\C100\kozos\GKNB_AUTM078_Autonóm_robotok_és_járművek_programozása' /mnt/kozos
    echo "\\\\\\\\fs-kab.eik.sze.hu\C100\kozos\GKNB_AUTM078_Autonóm_robotok_és_járművek_programozása    /mnt/kozos    drvfs defaults,uid=1000,gid=1000    0    0" | sudo tee -a /etc/fstab
fi

echo ""
echo "++++ install script end ++++"
echo ""