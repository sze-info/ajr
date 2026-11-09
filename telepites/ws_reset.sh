echo "++++ ros2_ws will be deleted, cloned (again) and built ++++"
echo ""
cd ~

# delete ros2_ws
rm -r ~/ros2_ws/

# create ros2_ws
mkdir -p ~/ros2_ws/src

# clone arj_packages and some other packages
cd ~/ros2_ws/src
git clone https://github.com/sze-info/arj_packages
git clone https://github.com/jkk-research/wayp_plan_tools
git clone https://github.com/jkk-research/sim_wayp_plan_tools
git clone https://github.com/dottantgal/ros2_pid_library

# build ros2_ws
cd ~/ros2_ws
colcon build
source ~/.bashrc


