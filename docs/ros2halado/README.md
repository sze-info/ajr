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

Két lehetőségünk van launch fájlt írni, pythonban vagy xml-ben. Az xml fájlok egyszerűbbek, de a python fájlok sokkal rugalmasabbak és könnyebben kezelhetőek.

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


## Más package-ből származó node-ok, paraméterek

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

## További példa

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


## Videó

<iframe width="560" height="315" src="https://www.youtube.com/embed/PqNGvmE2Pv4?si=-pLNSZsHNDE5br5I" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Források
- [foxglove.dev/blog/how-to-use-ros2-launch-files](https://foxglove.dev/blog/how-to-use-ros2-launch-files)
- [youtube.com/watch?v=PqNGvmE2Pv4&t](https://www.youtube.com/watch?v=PqNGvmE2Pv4&t) 
- [docs.ros.org/en/humble/Tutorials/Intermediate/Launch/Creating-Launch-Files.html](https://docs.ros.org/en/humble/Tutorials/Intermediate/Launch/Creating-Launch-Files.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Cpp-Publisher-And-Subscriber.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Cpp-Publisher-And-Subscriber.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Py-Publisher-And-Subscriber.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Py-Publisher-And-Subscriber.html)