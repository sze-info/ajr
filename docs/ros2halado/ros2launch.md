---
title: ROS 2 launch
icon: material/code-block-tags # kiegészítő tananyag
---

 





# `ROS 2` launch és `ROS 2` egyéb haladó koncepciók


## Bevezető

Az ROS 2 launch rendszere segíti a felhasználó által definiált rendszer konfigurációjának megadását, majd a konfiguráció szerinti végrehajtását. A konfigurációs lépés a következőket tartalmazza:

  - mely programok kerüljenek futtatásra,
  - milyen argumentumokat kapjanak a futtatott programok,
  - ROS-specifikus konvencióknak megfelelő összetevők, amelyek a komponensek könnyű újrahasznosíthatóságát teszik lehetővé.

  Fontos megemlíteni továbbá, hogy a megoldás felügyeli az elindított folyamatokat, és képes reagálni a folyamatok futási állapotában bekövetkező változásokra.

  Launch fájlok készítése történhet Python, XML, vagy YAML segítségével.


## Előkészületek
### Hozzuk létre a `example_launch_cpp` package-t

Ha esetleg már létezne a `example_launch_cpp` package akkor töröljük. (Gépteremben elképzelehető, hogy előző félévben valaki létrehozta.)

``` bash
cd ~ && test -d "ros2_ws/src/example_launch_cpp" && echo Letezik || echo Nem letezik
```

``` bash
rm -r  ~/ros2_ws/src/example_launch_cpp
```

Nyissunk egy új terminált, és source-oljuk a telepítést (ha nincs `bashrc`-ben), hogy a `ros2` parancsok működjenek.

Navigáljunk az már létrehozott `ros2_ws` könyvtárba.

Fontos, hogy a csomagokat az `src` könyvtárban kell létrehozni, nem a munkaterület gyökerében. Tehát navigáljunk a `ros2_ws/src` mappába, és futtassuk a package létrehozó parancsot:

``` bash
cd ~/ros2_ws/src
```

``` bash
ros2 pkg create --build-type ament_cmake example_launch_cpp
```

A terminál egy üzenetet küld vissza, amely megerősíti a `example_launch_cpp` csomag és az összes szükséges fájl és mappa létrehozását.

### Launch mappa

Hozzunk létre egy mappát a launch fájlok részére:

``` bash
cd ~/ros2_ws/src/example_launch_cpp
```

``` bash
mkdir launch
```

## Launch fájl létrehozása

``` bash
cd launch
```

``` bash
code turtlesim_mimic_launch.py
```

Állítsunk össze egy launch fájlt a ```turtlesim``` csomag elemeivel, Python nyelv alkalmazásával.
=== "Python"

    ``` py linenums="1"
    from launch import LaunchDescription
    from launch_ros.actions import Node

    def generate_launch_description():
        return LaunchDescription([
            Node(
                package='turtlesim',
                namespace='turtlesim1',
                executable='turtlesim_node',
            ),
            Node(
                package='turtlesim',
                namespace='turtlesim2',
                executable='turtlesim_node',
                name='turtle2_green',
                parameters=[{'background_b': 160, 'background_g': 230, 'background_r': 0}],
            ),
            Node(
                package='turtlesim',
                executable='mimic',
                name='mimic',
                remappings=[
                    ('/input/pose', '/turtlesim1/turtle1/pose'),
                    ('/output/cmd_vel', '/turtlesim2/turtle1/cmd_vel'),
                ]
            )
        ])
    ```
=== "XML"

    ``` xml linenums="1"
    <launch>
        <node
            pkg="turtlesim"
            ns="turtlesim1"
            exec="turtlesim_node"
            name="turtle1"/>
        
        <node
            pkg="turtlesim"
            ns="turtlesim2"
            exec="turtlesim_node"
            name="turtle2_green">
            <param name="background_b" value="160"/>
            <param name="background_g" value="230"/>
            <param name="background_r" value="0"/>
        </node>
        
        <node
            pkg="turtlesim"
            exec="mimic"
            name="mimic">
            <remap from="/input/pose" to="/turtlesim1/turtle1/pose"/>
            <remap from="/output/cmd_vel" to="/turtlesim2/turtle1/cmd_vel"/>
        </node>
    </launch>
    ```


A fent leírt módon létrehozott launch fájl a korábbiakban megismert ```turtlesim``` csomag három node-ját indítja el. A cél két turtlesim ablak megnyitása, majd az egyik teknős mozgásának megismétlése a másik teknőssel. A két turtlesim node indításában mindössze a névtér (namespace) tér el. Az egyedi névterek alkalmazása lehetővé teszi két azonos node egyidejű elindítását névkonfliktus nélkül. Így mindkét teknős ugyanazon a topicon fogad utasításokat, és ugyanazon a topicon közli a helyzetét. Az egyéni névterek lehetővé teszik a két teknős üzeneteinek megkülönböztetését.

Az utolsó node szintén a ```turtlesim``` csomagból van, viszont a futtatható fájl eltér: ```mimic```. Ez a csomópont ki van egészítve névmegfeleltetésekkel. Például az egyszerű ```/input/pose``` megfelelője ezesetben ```/turtlesim1/turtle1/pose``` és a korábban megismert ```/output/cmd_vel``` most ```/turtlesim2/turtle1/cmd_vel```. Ez azt jelenti, hogy ```mimic``` feliratkozik a ```/turtlesim1/sim``` pose topic-ra, és újra publisholja úgy, hogy ```/turtlesim2/sim``` sebesség utasítása feliratkozzon rá. Tehát, ```turtlesim2``` utánozni fogja ```turtlesim1``` mozgását. 

### Kód részleteinek áttekintése

Ezek a kifejezések Python ```launch``` modulokat importálnak.

``` py
from launch import LaunchDescription
from launch_ros.actions import Node
```

Ezt követően kezdődik a launch leírása:

``` py
def generate_launch_description():
  return LaunchDescription([

  ])
```

A launch leírásban szereplő első két utasítás indítja a két turtlesim ablakot:

``` py
Node(
    package='turtlesim',
    namespace='turtle1',
    executable='turtlesim_node',
),
Node(
    package='turtlesim',
    namespace='turtle2',
    executable='turtlesim_node',
    name='turtle2_green',
    parameters=[{'background_b': 160, 'background_g': 230, 'background_r': 0}],
),
```

Végül megtörténik a mozgás utánzását megvalósító node indítása is:

``` py
Node(
    package='turtlesim',
    executable='mimic',
    name='mimic',
    remappings=[
      ('/input/pose', '/turtlesim1/turtle1/pose'),
      ('/output/cmd_vel', '/turtlesim2/turtle1/cmd_vel'),
    ]
)
```

## `ROS2` launch használata

A létrehozott launch fájl elindítása az alábbi módon történik:

``` bash
cd ~/ros2_ws/src/example_launch_cpp/launch # belépünk a launch fájlt tartalmazó mappába
```
``` bash
ros2 launch turtlesim_mimic_launch.py
```

Két turtlesim ablak fog megnyílni, és a következő ```[INFO]``` kimenet lesz látható, felsorolva az indított node-okat:
```bash
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [turtlesim_node-1]: process started with pid [11714]
[INFO] [turtlesim_node-2]: process started with pid [11715]
[INFO] [mimic-3]: process started with pid [11716]
```

Hogy kipróbáljuk az elindított rendszer működését, egy új terminálban hirdessünk olyan üzenetet, amellyel a ```turtle1``` mozgatható:

```bash
ros2 topic pub -r 1 /turtlesim1/turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: -1.8}}"
```

![Turtlesim](/ajr/docs/assets/images_common/turtlesim03.gif)


A fent bemutatott direkt módon kívül egy launch fájl futtatható csomag által is:

``` bash
ros2 launch <csomag_megnevezése> <launch_fájl_neve>
```

Olyan csomagok esetében, amelyek launch fájlt tartalmaznak, érdemes létrehozni egy ```exec_depend``` függőséget a ```ros2launch``` csomagra vonatkozóan a csomag ```package.xml``` fájljában:

``` xml
<exec_depend>ros2launch</exec_depend>
```

Ezzel biztosítható, hogy az ```ros2 launch``` parancs elérhető a csomag buildelése után.

## Tanulmányozzuk az elindított rendszert

Úgy, hogy minden eddig elindított node fut, egy újabb terminálban futtassuk az `rqt_graph` eszközt, amely grafikusan szemlélteti a launch fájl segítségével kialakított rendszert:

```bash
rqt_graph
```

vagy a `ros2 run` paranccsal:

```bash
ros2 run rqt_graph rqt_graph
```

```mermaid
graph TD
    T1([turtlesim1/turtlesim]):::red --> P1[ /turtlesim1/turtle1/pose]:::light --> M1([mimic]):::red
    M1 --> C2[ /turtlesim2/turtle1/cmd_vel]:::light 
    C2 --> T2([turtlesim2/turtle2_green]):::red 

    n1([ /node]):::white -- publishes --> t[ /topic]:::white
    t -- subscribes --> n2([ /node]):::white


    classDef light fill:#34aec5,stroke:#152742,stroke-width:2px,color:#152742  
    classDef dark fill:#152742,stroke:#34aec5,stroke-width:2px,color:#34aec5
    classDef white fill:#ffffff,stroke:#152742,stroke-width:2px,color:#152742
    classDef red fill:#ef4638,stroke:#152742,stroke-width:2px,color:#fff

```

## Adjuk hozzá a package-hez, hogy bárhonnan indíthassuk

``` bash
cd ~/ros2_ws/src/example_launch_cpp
```

``` bash
code .
```
<figure markdown="span">
  ![Image title](/ajr/docs/assets/images_common/vscode06.png){ width="90%" }
  <figcaption>VS code fájlok</figcaption>
</figure>


A package.xml-hez a `<test_depend>` elé szúrjuk be következő sort:

``` xml
<exec_depend>ros2launch</exec_depend>
```

A CMakeLists.txt-hez a `ament_package()` elé szúrjuk be következő 2 sort:

``` cmake
install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME})
```

Buildeljük a szokáso módon:

``` bash
cd ~/ros2_ws
```

``` bash
colcon build --packages-select example_launch_cpp --symlink-install
```

``` bash
```

``` bash
source ~/ros2_ws/install/setup.bash
```

Ez a parancs most már __bárhonnan__ kiadható:

``` bash
ros2 launch example_launch_cpp turtlesim_mimic_launch.py
```

## Házi feladat

!!! warning "Házi feladat"
    Készíts egy launch fájlt, amely a `turtlesim` csomagból elindít egy turtlesim ablakot, és egy `teleop_turtle` csomagból egy `teleop_turtle_keyboard` node-ot. A `teleop_turtle_keyboard` node segítségével a turtlesim ablakban mozgatható a teknős a billentyűzetről. A turtlesim háttere legyen piros. Készítsünk hozzá egy `example_launch_py` python csomagot, és indítsuk el a launch fájlt a csomagból.

## Megjegyzés python csomagok esetén

Amennyiben `SetuptoolsDeprecationWarning: setup.py install is deprecated` hibaüzenetet kapunk, akkor a `setuptools` csomag downgrade-elése szükséges. Ellenőrizzük a `setuptools` csomag verzióját:

```bash
pip3 list | grep setuptools
```

Ha az eredmény **újabb**, mint `58.2.0`, akkor downgrade-elni kell a `setuptools` csomagot:

```bash
pip install setuptools==58.2.0
```


# Források
- [foxglove.dev/blog/how-to-use-ros2-launch-files](https://foxglove.dev/blog/how-to-use-ros2-launch-files)
- [youtube.com/watch?v=PqNGvmE2Pv4&t](https://www.youtube.com/watch?v=PqNGvmE2Pv4&t) 
- [docs.ros.org/en/humble/Tutorials/Intermediate/Launch/Creating-Launch-Files.html](https://docs.ros.org/en/humble/Tutorials/Intermediate/Launch/Creating-Launch-Files.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Cpp-Publisher-And-Subscriber.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Cpp-Publisher-And-Subscriber.html)
- [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Py-Publisher-And-Subscriber.html](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Py-Publisher-And-Subscriber.html)
