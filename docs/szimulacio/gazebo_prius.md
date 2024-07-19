---
layout: default
title: Gazebo Prius
parent: Szimuláció
---

# Gazebo Prius


```
cd ~/sim_ws/src/
git clone https://github.com/osrf/car_demo
catkin build car_demo
source ~/.bashrc
```


## Egy egyszerűbb példa Prius

Mivel gyakran nincs joystick (game_pad) a közelben írjuk át a `joy` node helyett hasonlóan az előzőhöz `rqt_robot_steering` működésűre a Prius demo-t-

Nyissuk meg VS code-ban a package-t.
```
roscd car_demo
code .
```
`Joy` node helyett a `demo.launch`-ba a következők kerüljenek. 

``` xml
<node pkg="car_demo" type="robot_steering_translator.py" name="robot_steering_translator1" output="screen"/>
<node pkg="rqt_robot_steering" type="rqt_robot_steering" name="rqt_robot_st0" />
```

Készítsük el a `robot_steering_translator.py` node-ot, ami `/cmd_vel`-ből a `/prius` topicba küld üzeneteket.

``` python 
#!/usr/bin/env python
import rospy
from prius_msgs.msg import Control
from geometry_msgs.msg import Twist

class Translator:
    def __init__(self):
        self.sub = rospy.Subscriber("cmd_vel", Twist, self.callback)
        self.pub = rospy.Publisher("prius", Control, queue_size=1)
        self.last_published_time = rospy.get_rostime()
        self.last_published = None
        self.timer = rospy.Timer(rospy.Duration(1./20.), self.timer_callback)
        
    def timer_callback(self, event):
        if self.last_published and self.last_published_time < rospy.get_rostime() + rospy.Duration(1.0/20.):
            self.callback(self.last_published)

    def callback(self, message):
        command = Control()
        command.header.stamp = rospy.Time.now()
        if message.linear.x > 0.2:
            command.throttle = message.linear.x
            command.brake = 0.0
        elif message.linear.x < -0.1:
            command.throttle = 0.0
            command.brake = -1 * message.linear.x
        else:
            command.throttle = 0.0
            command.brake = 0.0            
        command.steer = message.angular.z
        #rospy.loginfo("throttle and brake: %.1f %.1f" %(command.throttle, command.brake))
        self.last_published = message
        self.pub.publish(command)

if __name__ == '__main__':
    rospy.init_node('robot_steering_translator')
    rospy.loginfo("robot_steering_translator started")
    t = Translator()
    rospy.spin()
```
Ne felejtsük a `sudo chmod +x nodes/robot_steering_translator.py` parancsot se.

Külön terminalban `roscore` után nyissuk meg a szimulátort (az első indítás gyakran *lassú*, de aztán relatív gyors lesz):

```
roslaunch car_demo demo.launch 
```

Vizsgáljuk meg a topicokat [plotjuggler](https://github.com/facontidavide/PlotJuggler) segítségével. 
