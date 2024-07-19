---
layout: default
title: Kis beadandó
permalink: /kis_beadando/
icon: material/math-compass
---

# Kis beadandó 

A kis beadandó célja, hogy a hallgatók az órán megszerzett kezdő szintű elméleti tudás mellé **gyakorlati** tapasztalatot szerezzenek ROS 2-ről és GitHub-ról. A kis beadandó viszonylag **kevés idő** alatt elvégezhető: egy oktató pár óra alatt, egy átlag hallgató pár délután alatt elkészülhet vele. Fontos, hogy a beadandó **aláírás feltétel**.

Elvárt kvalitások:

- Egy package, 1 vagy 2 node
- Minimum 1 publisher vagy 1 subscriber (több lehet)
- Rövid dokumentáció, ami a build menetét, a node-topic kapcsolatokat tartalmazza, a [példák](#példák) szerinti részletességgel
- Helyes [névadás](#repo-neve) 
- Template [használata](#ajánlott-módszer-a-kis-beadandó-repo-létrhozására-template) vagy saját megoldás, de a [példák](#példák) szerinti kidolgozottsági szint
- Lehetőleg hiba nélkül forduljon, de a `build warning` sok esetben megengedhető, a lényeg a tanulás
- Minél több commit, hogy a munkafolyamatot is lássuk
- Terjedelem rövid: 30-100 kódsor node-onként + CMakeLists.txt, package.xml, README.md, launch fájlok (nem baj, ha hosszabb, de nem elvárt)
- Lehetőleg képpel illusztrálva (lásd [példák](#példák))
- Lehetőleg [mermaid](https://mermaid.js.org/intro/) diagram a node-ok, topic-ok viszonyáról (lásd [példák](#példák), [leírás](https://sze-info.github.io/arj/onallo/mermaid.html))

!!! danger
    A kis beadandó akkor lesz elfogadható, ha a node buildelhető és a feladatkiírásnak megfelelő kimenetet adja! Amennyiben ez nem teljesül a hallgatónak egy hete lesz a javításra az [issue](https://docs.github.com/en/issues) kiírásától számítva!

## Példák

Példa a kis beadandóra, amit az oktatók készítettek:

- [github.com/szepilot/sze_sw1_szinusz](https://github.com/szepilot/sze_sw1_szinusz): A package két node-ból áll. A `/gen_node` színusz jelet és véletlen számokat genertál, amiket két `std_msgs/float32` topicban hirdet. A `/sum_node` a összegzi az előállott topicokat és egy újabb `std_msgs/float32` topicban hirdeti. Megvalósítás `ROS 2 Humble` alatt.
- [github.com/horverno/hor_d20_batman_turtle](https://github.com/horverno/hor_d20_batman_turtle): A package egy node-ból áll, ez a turtlesim szimulátorban képes a trajektóra kirajzolásával egy "Batman logo" előállítására. A hirdetett topic `geometry_msgs/twist` típusú. Megvalósítás `ROS 2 Humble` alatt.
- A package egy node-ból áll. Ez az `/array_sorter` node feliratkozik egy `std_msgs/msg/float32_multi_array` típusú topicra, majd hirdeti a szintén ilyen típusú, de növekvő sorrendbe rendezett verzióját. Megvalósítás `ROS 2 Humble` alatt.
- A package két node-ból áll. A `/sensor_node` szimulált szenzordataokat generál: hőmérsékletet és páratartalmat, ezeket két külön `sensor_msgs/Temperature` és `sensor_msgs/RelativeHumidity` típusú topicban hirdeti. A `/monitor_node` ezen adatokat figyeli, és ha a hőmérséklet meghalad egy bizonyos küszöbértéket vagy a páratartalom meghalad egy másikat, egy riasztást küld egy `std_msgs/String` típusú topicban. Megvalósítás `ROS 2 Humble` alatt.
- A package egy node-ból áll. A `/minecraft_node` egy `visualization_msgs/Marker` típusú topicot hirdet. A topicra feliratkozva egy Minecraft karaktert jeleníthetünk meg RViz2-ben. Megvalósítás `ROS 2 Humble` alatt.
- [github.com/umiklos/ung_isl_ajr_point_and_orientation](https://github.com/umiklos/ung_isl_ajr_point_and_orientation): A package két node-ból áll. Az egyik node egy `geometry_msgs/Point` típust állít elő, a másik node pedig orientációval kiegészítve ebből egy `geometry_msgs/Pose` típusút hirdet. Megvalósítás `ROS 2 Humble` alatt.
- [github.com/umiklos/ung_isl_ajr_data_generation_and_control](https://github.com/umiklos/ung_isl_ajr_data_generation_and_control): A package két node-ból áll. Az `/sensor_data_generator` egy fiktív szenzorral szimulált adatokat generál, például távolságot és sebességet, ezeket két külön `sensor_msgs/Range` és `geometry_msgs/Twist` típusú topicban hirdeti. A másik node, a `/control_node` ezeket az adatokat figyeli és vezérlési döntéseket hoz a robot számára, amit kiír a terminalban. Megvalósítás `ROS 2 Humble` alatt.
- A package két node-ból áll. Az `/imu_data_publisher` gyorsulásmérő és giroszkóp szenzor adatokat szolgáltat, ezeket egy `sensor_msgs/Imu` típusú topicban hirdeti. A másik node, a `/imu_data_analyzer` ezeket az IMU adatokat elemzi és jelentéseket készít a robot állapotáról egy `diagnostic_msgs/DiagnosticArray` típusú topicban. Megvalósítás `ROS 2 Humble` alatt.


Érdemes, de nem kötelező a `diagnostic_msgs`, `geometry_msgs`, `nav_msgs`, `sensor_msgs`, `shape_msgs`, `std_msgs`, `trajectory_msgs`, `visualization_msgs` közül választani.

## Ajánlott módszer a kis beadandó repo létrhozására: `template`

C++ és Python nyelven is létrehoztunk egy úgynevezett template repo-t, amely megkönnyíti az első pacakage-t tartalmazó repository létrehozását:

- [github.com/sze-info/ros2_cpp_template](https://github.com/sze-info/ros2_cpp_template)
- [github.com/sze-info/ros2_py_template](https://github.com/sze-info/ros2_py_template)

!!! tip

    Erről [leírás itt](https://sze-info.github.io/arj/onallo/ros2git.html) olvasható.

<img src="https://raw.githubusercontent.com/sze-info/ros2_cpp_template/main/img/use_this_template01.png" width="60%" />


## Repo neve
- A repository neve a következő mintát kövesse: `VVV_NNN_opcionalis`, ahol
  - a `VVV` a vezetéknév első 3 karaktere
  - az `NNN` a neptunkód első 3 karaktere
  - az `opcionalis` pedig opcionális kiegészítés
  - a fentieket alulvonás `_` karakter válassza el és kisbetű legyen mindenhol
- Pl: Szabó István, F99AXW neptunkóddal egy véletlenszámmal foglakozó kis beadandójának url-je lehet pl: `github.com/szaboistvan/sza_f99_random`. 