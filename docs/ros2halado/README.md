---
title: ROS 2 haladó
icon: material/math-integral-box # elméleti tananyag
---

## ROS 2 haladó funkciók

## Ellenőrző kérdések

- Melyik ROS verziót használjuk a félévben? 
- Mi a node?
- Mi a topic?
- Milyen típusú adatokat küldhetünk a topicokon keresztül? (példák)

## ROS 2 launch fájlok

### `ROS 2` launch szemléltetés


```mermaid
flowchart LR
    %% Launch file
    A[LAUNCH<br>FILE]:::dark --o B1
    A ---o B2
    A ---o B3
    D --o C1
    
    %% SENSE THINK ACT PACKAGE
    subgraph sense_think_act_package["SENSE THINK ACT<br>PACKAGE"]
        direction TB
        B1([Sensor<br>Node]) 
        B2([Compute<br>Node])
        B3([Motor<br>Node])
    end

    %% PARAMS PACKAGE
    subgraph params_package["PARAMS PACKAGE"]
        direction TB
        C1([Robot<br>Node])
    end
    
    %% Configuration parameters
    A --o D[Configuration parameters]

    classDef light fill:#34aec5,stroke:#152742,stroke-width:2px,color:#152742  
    classDef dark fill:#152742,stroke:#34aec5,stroke-width:2px,color:#34aec5
    classDef white fill:#ffffff,stroke:#152742,stroke-width:2px,color:#152742
    classDef red fill:#ef4638,stroke:#152742,stroke-width:2px,color:#fff
```
*Forrás:* [foxglove.dev](https://foxglove.dev/blog/how-to-use-ros2-launch-files)

### `ROS 2` launch fájlok

Több ROS 2 node futtatása sok időt vesz igénybe és több terminálablakra van szükség. Még a kisebb projektek vagy robotok is egyszerre több node-ot futtathatnak.

Képzeljünk el egy robotot, amely a "érzékel-gondolkodik-cselekszik" (sense-think-act) modell alapján működik, és minden lépéshez külön node-ot futtat. Egy `sensor_node` felelős az érzékelő adatainak olvasásáért, egy `compute_node` fogadja ezeket az adatokat, és parancsot küld a kerekeknek, végül pedig egy `motor_node` fogadja a parancsot, és a szükséges feszültséget adja a motoroknak.

Ahelyett, hogy minden egyes node-ot külön terminálablakban futtatnánk minden alkalommal, amikor elindítjuk a robotot, használhatunk egy indítófájlt, hogy mindezeket egyszerre futtassuk – egyetlen parancs segítségével, egyetlen terminálablakban.

### Hogyan tehetjük ezt meg?

Három lehetőségünk van launch fájlt írni, pythonban, yaml-ben vagy xml-ben. Ebből kettőt bemutatunk: az xml fájlok egyszerűbbek, de a python fájlok sokkal rugalmasabbak és könnyebben kezelhetőek.

=== "Python"

    ``` py linenums="1"
    # This function is always needed
    def generate_launch_description():

    # Declare a variable Node for each node
    compute_node = Node(
        package="launch_pkg",
        executable="compute_node"
    )
    sensor_node = Node(
        package="launch_pkg",
        executable="sensor_node"
    )
    motor_node = Node(
        package="launch_pkg",
        executable="motor_node"
    )
    ```

=== "XML"
    
    ``` xml linenums="1"
    <launch>
        <node pkg="launch_pkg" type="sensor_node" name="sensor_node" output="screen"/>
        <node 
            pkg="launch_pkg" 
            type="compute_node" 
            name="compute_node" 
            output="screen"/>
        <node 
            pkg="launch_pkg" 
            type="motor_node" 
            name="motor_node" 
            output="screen"/>
    </launch>
    ```

```mermaid
flowchart LR
    A([sensor_node]):::red
    B[ /sensor_data]:::light
    C([compute_node]):::red
    D[ /cmd_vel]:::light
    E([motor_node]):::red


    A --> B --> C --> D --> E

    classDef light fill:#34aec5,stroke:#152742,stroke-width:2px,color:#152742  
    classDef dark fill:#152742,stroke:#34aec5,stroke-width:2px,color:#34aec5
    classDef white fill:#ffffff,stroke:#152742,stroke-width:2px,color:#152742
    classDef red fill:#ef4638,stroke:#152742,stroke-width:2px,color:#fff

```
## Namespace

Az launch fájlok csoportokba vagy névterekbe is csoportosíthatják a node-okat. Ez megkönnyíti a node-ok viselkedésének nyomon követését és figyelemmel kísérését.

Egy node-nak csak egy neve van, de a névterek több szintjéhez is tartozhat. Ezeket a névtereket perjellel (`/`) lehet összekapcsolni – minden névtér nélküli csomópontban mindig egyetlen `/` szerepel a neve előtt (pl. `/sensor_node`). A deklaráció során megadott névtér nélküli témakörök öröklik a csomópont névterét, ahogy az az előző ábrán is látható.

Adjuk hozzá három node-ot a `sense_think_act` névteréhez:

```py
sensor_node = Node(
  namespace="sense_think_act",
  package="launch_pkg",
  executable="sensor_node"
)

compute_node = Node(
  namespace="sense_think_act",
  package="launch_pkg",
  executable="compute_node"
)

motor_node = Node(
  namespace="sense_think_act",
  package="launch_pkg",
  executable="motor_node"
)
```

```mermaid
flowchart TD
    A([sense_think_act/sensor_node]):::red
    B[ sense_think_act/sensor_data]:::light
    C([sense_think_act/compute_node]):::red
    D[ sense_think_act/cmd_vel]:::light
    E([sense_think_act/motor_node]):::red


    A --> B --> C --> D --> E

    classDef light fill:#34aec5,stroke:#152742,stroke-width:2px,color:#152742  
    classDef dark fill:#152742,stroke:#34aec5,stroke-width:2px,color:#34aec5
    classDef white fill:#ffffff,stroke:#152742,stroke-width:2px,color:#152742
    classDef red fill:#ef4638,stroke:#152742,stroke-width:2px,color:#fff
```

*Megjegyzés:* A balról jobbra elrendezés helyett a helykihasználás miatt most a fentről lefelé elrendezést használtunk.


### Más package-ből származó node-ok, paraméterek

```py
robot_node = Node(
  namespace="core",
  package="params_pkg",
  executable="robot_node",
  parameters=[{
    "robot_name":"RobotA",
    "max_speed":4.2,
    "waypoints":["Home", "Room 1", "Corridor", "Home"]
  }]
)
foxglove_bridge = Node(
    package='foxglove_bridge',
    executable='foxglove_bridge',
    parameters=[{
        'port': 8765,
        },
    ]
)

ld = [compute_node,
    foxglove_bridge,
    sensor_node,
    motor_node,
    robot_node]
```

```mermaid
flowchart TD
    A([sense_think_act/sensor_node]):::red
    B[ sense_think_act/sensor_data]:::light
    C([sense_think_act/compute_node]):::red
    D[ sense_think_act/cmd_vel]:::light
    E([sense_think_act/motor_node]):::red
    F([foxglove_bridge]):::red
    G([core/robot_node]):::red

    A --> B --> C --> D --> E
    B --> F
    D --> F
    %% D --> G

    classDef light fill:#34aec5,stroke:#152742,stroke-width:2px,color:#152742  
    classDef dark fill:#152742,stroke:#34aec5,stroke-width:2px,color:#34aec5
    classDef white fill:#ffffff,stroke:#152742,stroke-width:2px,color:#152742
    classDef red fill:#ef4638,stroke:#152742,stroke-width:2px,color:#fff
```

### További példa

- `robot_a` namespace:
    - `sensor_node_a`: Érzékelő adatokat publikál a `/robot_a/sensor_data` topicra.
    - `control_node_a`: Feliratkozik a `/robot_a/sensor_data` topicra, és parancsokat küld a `/robot_a/cmd_vel` topicra.
    - `motor_node_a`: Feliratkozik a `/robot_a/cmd_vel` topicra, hogy fogadja a motor parancsokat.
- `robot_b` namespace:
    - `sensor_node_b`: Érzékelő adatokat publikál a `/robot_b/sensor_data` topicra.
    - `control_node_b`: Feliratkozik a `/robot_b/sensor_data` topicra, és parancsokat küld a /robot_b/cmd_vel topicra.
    - `motor_node_b`: Feliratkozik a `/robot_b/cmd_vel` topicra, hogy fogadja a motor parancsokat.
- Megosztott:
    - Mindkét robot megoszt egy topicot, a` /shared/environment_data`-t, ahol a `sensor_node_a` és a `sensor_node_b` is publikálhat vagy feliratkozhat.
    - Mindkét robot megoszt egy topicot, a `/shared/map_data`-t, ahol a `map_server` publikál és a `sensor_node_a` és a `sensor_node_b` feliratkozhat.

```mermaid
flowchart TB
    %% Robot A
    subgraph robot_a["Namespace: robot_a"]
        direction TB
        sensor_a([sensor_node_a]):::red
        control_a([control_node_a]):::red
        motor_a([motor_node_a]):::red

        sensor_a --> |/robot_a/sensor_data| control_a
        control_a --> |/robot_a/cmd_vel| motor_a
    end
    
    %% Robot B
    subgraph robot_b["Namespace: robot_b"]
        direction TB
        sensor_b([sensor_node_b]):::red
        control_b([control_node_b]):::red
        motor_b([motor_node_b]):::red
        
        sensor_b --> |/robot_b/sensor_data| control_b
        control_b --> |/robot_b/cmd_vel| motor_b
    end
    
    map_sever([map_sever]):::red
    /shared/map_data[ /shared/map_data]:::light

    %% Shared Topic between Robot A and Robot B
    sensor_a <--> |/shared/environment_data| sensor_b
    map_sever --> /shared/map_data
    /shared/map_data --> sensor_a
    /shared/map_data --> sensor_b


    classDef light fill:#34aec5,stroke:#152742,stroke-width:2px,color:#152742  
    classDef dark fill:#152742,stroke:#34aec5,stroke-width:2px,color:#34aec5
    classDef white fill:#ffffff,stroke:#152742,stroke-width:2px,color:#152742
    classDef red fill:#ef4638,stroke:#152742,stroke-width:2px,color:#fff

```


### Videó

<iframe width="560" height="315" src="https://www.youtube.com/embed/PqNGvmE2Pv4?si=-pLNSZsHNDE5br5I" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Vizualizáció és debug

### Foxglove Studio / Lichtblick Suite

A Foxglove Studio egy nyílt forráskódú, robotikai adatokat vizualizáló és hibakereső eszköz. Létezik `Windows`, `Linux` és `MacOS` rendszerekre. A `v1.87.0`-ig bezárólag nyílt forráskódu volt, a `v2.0.0`-tól pedig ingyenesen használható, de zárt forráskódú. Az open source fejlesztést több fork, például a **Lichtblick Suite** vette át. Elérhető számos módon:

- önálló asztali alkalmazásként futtatható
- böngészőben hozzáférhető
- saját domainen, önállóan hostolható

A natív robotikai eszközök (mint például az ROS ökoszisztéma részei) általában csak Linux rendszeren támogatottak, de a Studio asztali alkalmazás Linuxon, Windows-on és macOS-en is működik. Akár az ROS stack más operációs rendszeren fut, a Studio képes kommunikálni a robottal zökkenőmentesen.

![foxglove_a](../bevezetes/foxglove04.png#only-light)
![foxglove_a](../bevezetes/foxglove03.png#only-dark)

A Studio gazdag vizuális elemeket és hibakereső panelokat kínál - interaktív diagramoktól, 3D vizuális elemekig, kameraképektől, és diagnosztikai adatfolyamokig. Legyen szó valós idejű robotkövetésről, vagy `.bag` / `.mcap` fájlban történő hibakeresésről, ezek a panelok segítenek a különböző, általános robotikai feladatok megoldásában.

Ezek a panelok ezután egyedi elrendezésekben konfigurálhatók és összeállíthatók a projekt egyedi igényeinek és munkafolyamatainak megfelelően.

![foxglove_lichtblick_logo](../bevezetes/foxglove_lichtblick01.png)

<video width="100%" loop="" autoplay="" muted="" playsinline="" poster="https://cdn.prod.website-files.com/66a36245725199d12625c1d5/66dc638d81bf97e670aaf5fc_website-product-hero.webp">
  <source src="https://storage.googleapis.com/assets.foxglove.dev/website/website-product-hero.webm" type="video/mp4">
</video>


A Lichtblick Suite a Foxglove-hoz hasonló, egész pontosan a Foxglove `v1.87.0` verziójának folytatása, továbbra is nyílt forráskóddal. A Lichtblick a Foxglove-hoz hasonlóan asztali alkalmazásként futtatható, és a Studio-hoz hasonlóan támogatja a `.bag` / `.mcap` fájlokat, valamint a valós idejű adatvizualizációt.

### Foxglove Studio / Lichtblick Suite telepítése

[Foxglove 1.66.0 Win :material-download: 154 MB](https://drive.google.com/drive/folders/1TWLy6ZZb5ue9PcDmvdf5dDgKJOQUBzms?usp=drive_link){ .md-button .md-button}

[Foxglove 1.74.2 Linux :material-download: 71 MB](https://drive.google.com/drive/folders/1TWLy6ZZb5ue9PcDmvdf5dDgKJOQUBzms?usp=drive_link){ .md-button .md-button}

[Foxglove Latest All platform:material-download:](https://foxglove.dev/download){ .md-button .md-button}

[Lichtblick Latest All platform:material-download:](https://github.com/Lichtblick-Suite/lichtblick/releases){ .md-button .md-button}



### Rviz

Az `Rviz2` a `ROS 2` natív, nyílt forráskódú, robotikai adatokat vizualizáló és hibakereső eszköze. Ennek értelmében leginkább Linux rendszeren használható, de a Windows és macOS támogatás is folyamatosan fejlődik.


```bash
ros2 run rviz2 rviz2
```

![rviz](../erzekeles/rviz01.png)

```bash
ros2 run rviz2 rviz2 --help
```
Parancs segítségével megtudhatjuk, hogy pl. `-d` kapcsolóval betölthetünk egy `.rviz` konfigurációs fájlt, vagy `-f` fix frame-et adhatunk meg.


Bővebben: [docs.ros.org/en/humble/Tutorials/Intermediate/RViz/RViz-User-Guide/RViz-User-Guide.html](https://docs.ros.org/en/humble/Tutorials/Intermediate/RViz/RViz-User-Guide/RViz-User-Guide.html)

### rqt_graph

Az `rqt_graph` a node-ok és topic-ok vizualizációjára használható.

```bash
ros2 run rqt_graph rqt_graph
```

![rqt_reconfigure](../eszleles/rqt_graph02.svg)

### rqt_console

Az `rqt_console` log (info, debug, warn, error, fatal) üzenetek megjelenítésre, szűrésére és elemzésére használható.

```bash
ros2 run rqt_console rqt_console
```

![](https://docs.ros.org/en/humble/_images/warn.png)


### rqt_tf_tree

Az `rqt_tf_tree` a transzformációk vizualizációjára használható.

```bash
ros2 run rqt_tf_tree rqt_tf_tree
```

![rqt_](../transzformaciok/tf_examples03.svg)

### rqt_reconfigure

Az `rqt_reconfigure` a node-ok paramétereinek módosítására használható.

```bash
ros2 run rqt_reconfigure rqt_reconfigure
```

![rqt_reconfigure](../transzformaciok/rqt_reconf01.png)


## Publish, Subscribe, Timer

Három alapvető műveletet célszerű ismerni, amelyeket a ROS 2-ben a node-ok használnak a kommunikációhoz:

- **Timer**: Időzített eseményeket hoz létre a következő példánál ez a `timer_callback()` függvény. Ezen a függvényen belül például publikálhatunk egy üzenetet vagy elvégezhetünk egy számítást.
- **Subscribe**: Feliratkozik egy topic-ra, és fogadja az adatokat. Ezt úgy éri el, hogy a példánál maradva a `callback1()` függvény minden új üzenet érkezéskor meghívódik.
- **Publish**: Adatokat küld a topic-on keresztül. Ezt általában ismétlődően tessszük, jó lehet erre a  subscriber callback függvénye, vagy a timer callback függvénye.

### Példa C++

```cpp linenums="1" hl_lines="14-16 21 26 30-32"
#include <chrono>
#include <functional>
#include <memory>
#include <string>
#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/float32.hpp"
using namespace std::chrono_literals;

class CoolNode : public rclcpp::Node
{
public:
  CoolNode() : Node("my_cool_node")
  {
    pub1_ = this->create_publisher<std_msgs::msg::Float32>("topic1", 10);
    sub1_ = this->create_subscription<std_msgs::msg::Float32>("topic2", 10, std::bind(&CoolNode::callback1, this, std::placeholders::_1));
    timer_ = this->create_wall_timer(50ms, std::bind(&CoolNode::timer_callback, this)); // 20 hz = 50 ms
    RCLCPP_INFO_STREAM(get_logger(), this->get_name() << " has been started.");
  }

private:
  void timer_callback()
  {
    // create message and publish e.g. pub1_->publish(my_msg);
  }

  void callback1(const std_msgs::msg::Float32::SharedPtr msg)
  {
    // do something with the message
  }
  rclcpp::Publisher<std_msgs::msg::Float32>::SharedPtr pub1_;
  rclcpp::Subscription<std_msgs::msg::Float32>::SharedPtr sub1_;
  rclcpp::TimerBase::SharedPtr timer_;
};

int main(int argc, char *argv[])
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<CoolNode>());
  rclcpp::shutdown();
  return 0;
}
```

### Példa python

```python linenums="1" hl_lines="8-10 13 17"
import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32

class CoolNode(Node):
    def __init__(self):
        super().__init__('my_cool_node')
        self.pub1_ = self.create_publisher(Float32, 'topic1', 10)
        self.sub1_ = self.create_subscription(Float32, 'topic2', 10, self.callback1)
        self.timer_ = self.create_timer(0.05, self.timer_callback)  # 20 Hz = 50 ms
        self.get_logger().info(f'{self.get_name()} has been started.')

    def timer_callback(self):
        # create message and publish e.g. self.pub1_.publish(my_msg)
        pass

    def callback1(self, msg):
        # do something with the message
        pass

def main(args=None):
    rclpy.init(args=args)
    node = CoolNode()
    rclpy.spin(node)
    rclpy.shutdown()

if __name__ == '__main__':
    main()
```


## Források
- [foxglove.dev/blog/how-to-use-ros2-launch-files](https://foxglove.dev/blog/how-to-use-ros2-launch-files)
- [youtube.com/watch?v=PqNGvmE2Pv4&t](https://www.youtube.com/watch?v=PqNGvmE2Pv4&t) 
- [docs.ros.org/en/humble/Tutorials/Intermediate/Launch/Creating-Launch-Files.html](https://docs.ros.org/en/humble/Tutorials/Intermediate/Launch/Creating-Launch-Files.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Cpp-Publisher-And-Subscriber.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Cpp-Publisher-And-Subscriber.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Py-Publisher-And-Subscriber.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Py-Publisher-And-Subscriber.html)
- [docs.ros.org/en/humble/Tutorials/Intermediate/RViz/RViz-User-Guide/RViz-User-Guide.html](https://docs.ros.org/en/humble/Tutorials/Intermediate/RViz/RViz-User-Guide/RViz-User-Guide.html)