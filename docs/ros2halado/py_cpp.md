---
title: Python és C++ összehasonlítása
---

=== "Python"

    ``` py linenums="1"
    #  ros2 topic type /lexus3/gps/duro/current_pose
    #  geometry_msgs/msg/PoseStamped
    #  ros2 interface show geometry_msgs/msg/PoseStamped

    import rclpy
    from rclpy.node import Node
    from geometry_msgs.msg import PoseStamped


    class SimplePoseSub(Node):

        def __init__(self):
            super().__init__('simple_pose_sub')
            self.sub1_ = self.create_subscription(PoseStamped, '/lexus3/gps/duro/current_pose', self.topic_callback, 10)



        def topic_callback(self, msg):

            self.get_logger().info('x: %.3f, y: %.3f', msg.pose.position.x, msg.pose.position.y)




    def main(args=None):

        rclpy.init(args=args)                   ## Initialize the ROS 2 client library
        simple_pose_sub = SimplePoseSub()
        rclpy.spin(simple_pose_sub)             ## Create a node and spin
        simple_pose_sub.destroy_node()
        rclpy.shutdown()                        ## Shutdown the ROS 2 client library

    if __name__ == '__main__':
        main()
    ```

=== "C++" 

    ``` c++ linenums="1"
    // ros2 topic type /lexus3/gps/duro/current_pose
    // geometry_msgs/msg/PoseStamped
    // ros2 interface show geometry_msgs/msg/PoseStamped

    #include "rclcpp/rclcpp.hpp"
    #include <memory>
    #include "geometry_msgs/msg/pose_stamped.hpp"
    using std::placeholders::_1;

    class SimplePoseSub : public rclcpp::Node{
    public:
        SimplePoseSub() : Node("simple_pose_sub")
        {
            sub1_ = this->create_subscription<geometry_msgs::msg::PoseStamped>("/lexus3/gps/duro/current_pose", 10, std::bind(&SimplePoseSub::topic_callback, this, _1));
        }

    private:
        void topic_callback(const geometry_msgs::msg::PoseStamped &msg) const
        {
            RCLCPP_INFO(this->get_logger(), "x: %.3f, y: %.3f", msg.pose.position.x, msg.pose.position.y);
        }
        rclcpp::Subscription<geometry_msgs::msg::PoseStamped>::SharedPtr sub1_;
        };

    int main(int argc, char *argv[])
    {
        rclcpp::init(argc, argv);               // Initialize the ROS 2 client library
        rclcpp::spin(
            std::make_shared<SimplePoseSub>()); // Create a node and spin

        rclcpp::shutdown();                     // Shutdown the ROS 2 client library
        return 0;

    }
    ```

