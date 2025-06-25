---
# icon: material/home
hide:
  - toc
  - navigation
---


- Tantárgy neve magyarul: **Autonóm járművek és robotok programozása**
- Tantárgy neve angolul: **Autonomous robots and vehicles software engineering**
- Neptun tárgykód: `GKNB_AUTM078`

A tantárgy több mérnöki szakon indul és meglévő minimális programozási tudásra épít.  **Járműmérnöki** (BSc) szakon `GKNB_INTM023` Programozás alapjai, **Programtervező informatikus** (BSc) `GKNB_MSTM032` Python programozás, **Mérnökinformatikus** (BSc) szakon `GKNB_INTM114` Programozás, **Mechatronikai mérnök** (BSc) szakon `GKNB_MSTM032` Python programozás, **Villamosmérnök** (BSc) szakon `GKNB_INTM023` Programozás alapjai előkövetleményekkel indul.


!!! abstract "A tantárgy célja"
    A tárgy sikeres teljesítése után a hallgatók átfogó képet kapnak az önvezető (autonóm) járművek szoftver moduljairól és további lényeges összetevőiről.

    C++ és python nyelven egyszerűbb ehhez kapcsolódó szoftvermodulokat tudnak fejleszteni. Ezen túlmenően a hallgatók képesek a megfelelő kód alkalmazására, valamint annak funkcióinak értelmezésére és továbbfejlesztésére ROS 2 keretrendszerben.

A tárgy összeállítása során olyan nemzetközileg is elismert egyetemek tananyagát vettük alapul, mint az MIT, ETH Zürich, TU München, Univerisity of Virginia vagy a Stanford University. A megfelelő licenc betarása mellett bizonyos tanangyag részeket át is vettünk, másokat inspirációként használtunk, [erről részletesen itt](https://github.com/sze-info/ajr#acknowledgement) lehet olvasni. 2023-ban a tantárgy az ROS 2 Humble verzióját használja, ez a disztribúció 2027 májusáig támogatott.

A tantárgy teljesítése például következő autóipari / autonóm járműves cégeknél előnyt jelenthet (ABC sorrendben):

- [AiMotive Kft.](https://aimotive.com/) **(Budapest)**
- [AVL Hungary Kft.](https://www.avl.com/en-hu/locations/avl-hungary-kft) **(Budapest, Érd, Kecskemét)**
- [Bosch: Robert Bosch Kft.](https://www.bosch.hu/karrier/) **(Budapest, Győr, Zalaegerszeg)**
- [Continental Autonomous Mobility Hungary Kft.](https://www.continental.com/hu-hu/vallalat/continental-vallalatok-magyarorszagon/am-hungary/) **(Budapest, Győr, Debrecen)**
- [Járműipari Kutatóközpont, SZE](https://jkk-web.sze.hu/szakmai-kompetenciak/autonom-kozlekedesi-rendszerek-kozpont/) **(Győr)**

További karrierrel kapcsolatos érdekességek például a [statista](https://www.statista.com/outlook/tmo/robotics/worldwide)-n, a [glassdoor](https://www.glassdoor.com/Sueldos/robotics-developer-sueldo-SRCH_KO0,18.htm)-on, [linkedin](https://www.linkedin.com/posts/the-construct_robotics-developer-ros-activity-7208725277965787136-A_UQ/)-en olvashatók.


!!! note 
    A tárgyban bemutatott ismeretekre alapozva diplomamunka, szakdolgozat, projektmunka, TDK dolgozat is készíthető, illetve van lehetőség a kötelező szakmai gyakorlat teljesítésére is.

<center> 


Oktatók | | | .
-----|-----|-----|-----
<img src="https://raw.githubusercontent.com/sze-info/arj/main/docs/_images/okt_he01.png" width="80px"/> | Dr. Horváth Ernő <br/> <i>Tárgyfelelős</i> <br/>[github.com/horverno](http://github.com/horverno) | <img src="https://raw.githubusercontent.com/sze-info/arj/main/docs/_images/okt_ba01.png" width="80px"/>| Dr. Ballagi Áron <br/> <i>Tematika, nem oktat</i><br/> [github.com/aronball](http://github.com/aronball)
<img src="https://raw.githubusercontent.com/sze-info/arj/main/docs/_images/okt_kr01.png" width="80px"/> | Krecht Rudolf <br/> <i>Szimuláció, robotika</i> <br/> [github.com/rudolfkrecht](http://github.com/rudolfkrecht) | <img src="https://raw.githubusercontent.com/sze-info/arj/main/docs/_images/okt_um01.png" width="80px"/> | Unger Miklós <br/> <i>Környezetérzékelés</i> <br/> [github.com/umiklos](http://github.com/umiklos)
<img src="https://raw.githubusercontent.com/sze-info/arj/main/docs/_images/okt_ig01.png" width="80px"/>| Ignéczi Gergő <br/> <i>Szabályozástechnika</i> <br/> [github.com/gfigneczi1](http://github.com/gfigneczi1)|<img src="https://raw.githubusercontent.com/sze-info/arj/main/docs/_images/okt_mn01.png" width="80px"/> | Markó Norbert <br/> <i>AI, neurális hálók</i>  <br/> [github.com/norbertmarko](http://github.com/norbertmarko)


</center>

2024/25 tavaszi félévében az `B2`-es teremben, illetve a `C100`-as gépteremben tartunk órákat.

Előzetesen a következő időtervet követjük, de a pontos dátumokat mindig előre, neptun üzenetben közöljük.

<center> 

Óra | Dátum Ő | Dátum T | Tananyag | Megj.
-----:|---:|---:|:-----|:-----
1 | szept. 9-10. | feb. 6. | Bevezetés | 
2 | szept. 16-17. | feb. 13. | ROS 2 alap, telepítés | 
3 | szept. 23-24. | feb. 20. | Érzékelés |  Beadandó 🔴 Aláírás megtagadás mulasztás esetén!
4 | szept. 30-okt. 1. | feb. 27. | ROS 2 haladó | 
5 | okt. 7-8. | márc. 6. | Transzformációk | Beadandó 🔴 Kis beadandó véglegestése
6 | okt. 14-15. | márc. 13. | Észlelés | Féléves feladat választás
7 | okt. 21. | márc. 20. | Szimuláció | 
8 | okt. 28-29. | márc. 27. | Tervezés | ZH 1?
9 | nov. 4-5. | ápr. 3. | Szabályozás | 
10 | nov. 11-12. | ápr. 10. | AI | 
+1 | nov. 19.? | ápr. 17. | | ZH 2?
+2 | - | - | | Pót ZH?

</center>

## Elmélet

Óra | Tananyag
-----|-----
1 | [Bevezetés](https://sze-info.github.io/ajr/bevezetes/): A tantárgy felépítése. Robotikai és önvezető járműves ismeretek. Érzékelés, észlelés, tervezés, szabályozás, aktuálás.
2 | [ROS2 koncepciók](https://sze-info.github.io/ajr/bevezetes/ros2/): Egyetemi robotok és járművek ismertetése. `ROS 2` alapismeretek.
3 | [Érzékelés](https://sze-info.github.io/ajr/erzekeles/): Kamera, LIDAR, GNSS (GPS), IMU, CAN szenzorok működése, jelfeldolgozása, főbb `ROS 2` topicok, `ROS 2` időkezelés.
4 | [Féléves beadandó](https://sze-info.github.io/ajr/feleves_beadando/): féléves beadandó ismertetése, osztályzási szempontok, ötletek, kérdések-válaszok
5 | [Transzformációk](https://sze-info.github.io/ajr/transzformaciok/): Merev test mozgása, mátrix szorzás ismétlése, homogén koordináták szemléltetése rövid progamkódokkal, quaternion (kvaterniók) fogalma.
6 | [Észlelés](https://sze-info.github.io/ajr/eszleles/): objektumfelismerés, objektumklasszifikáció, objektum követés és predikció, SLAM és LOAM.
7 | [Szimuláció](https://sze-info.github.io/ajr/szimulacio/): ROS 2 kompatibilis szimulátorok áttekintése (pl [Gazebo](http://gazebosim.org/), [Carla](https://carla.org/), [SVL](https://www.lgsvlsimulator.com/), [OSSDC SIM](https://github.com/OSSDC/OSSDC-SIM), [AirSim](https://microsoft.github.io/AirSim), [AWSIM](https://tier4.github.io/AWSIM), [CoppeliaSim](https://www.coppeliarobotics.com/coppeliaSim), [MVSim](https://mvsimulator.readthedocs.io/))
8 | [Tervezés](https://sze-info.github.io/ajr/tervezes/): Globális tervezés, lokális tervezés. Lokális tervezés: keresztirányú és hosszirányú tervezés.
9 | [Szabályozás](https://sze-info.github.io/ajr/szabalyozas/): Járműirányítási megoldások (inverz-modellek, prediktív modellek, zárhurkú modellek).
10 | [Mesterséges intelligencia](https://sze-info.github.io/ajr/mesterseges_intelligencia/): Neurális hálózatok járműves és robotikai fókusszal.


## Gyakorlat

Óra | Tananyag
-----|-----
1| [Bevezetés](https://sze-info.github.io/ajr/bevezetes/practice/) + [Linux](https://sze-info.github.io/ajr/bevezetes/linux/) + [Géptermi ismeretek](https://sze-info.github.io/ajr/bevezetes/gepterem/): WSL2 használata Windows operációs rendszeren. Géptermi alapismeretek. Linux parancsok, amelyek szükségesek lehetnek a későbbiekben.
2| [Telepítés](https://sze-info.github.io/ajr/telepites/ros_humble/)+ [Fejlesztőkörnyezet beállítása](https://sze-info.github.io/ajr/bevezetes/vscodegit/) + [ROS2 kommunikáció](https://sze-info.github.io/ajr/bevezetes/ros2gyak/): Első `ROS 2` node-ok, ROS parancsok használata, build és source.
3| [Érzékelés gyakorlat](https://sze-info.github.io/ajr/erzekeles/practice/): Szenzor adatok jellemzőbb formátumai: `sensor_msgs/PointCloud2`, `sensor_msgs/Image`, `geometry_msgs/Pose`, stb. Bag `.mcap` fájlok kezelése, lejátszása. Egyszerű pacakge készítése, amely pozíció adatokra iratkozik fel. 
4| [Verziókezelés, Git](https://sze-info.github.io/ajr/onallo/ros2git/), [Copilot](https://sze-info.github.io/ajr/bevezetes/copilot/), [vs code](https://sze-info.github.io/ajr/bevezetes/vscodegit/), [ROS 2 launch](https://sze-info.github.io/ajr/ros2halado/ros2launch/): Copilot használata ROS 2 fejlesztéshez, Template repo ismertetése, használata, launch fájlok írása python nyelven
5| [Transzformációk gyakorlat](https://sze-info.github.io/ajr/transzformaciok/practice/): Node létrehozása, amely transzformációkat hirdet. Markerek megjelenítése, launch önálló feladat.
6| [Észlelés gyakorlat](https://sze-info.github.io/ajr/eszleles/practice/): egyszerű LIDAR szűrés, X, Y és Z koordináták szerint.
7| [Szimuláció bevezetés](https://sze-info.github.io/ajr/szimulacio/gazebo_fortress/): Gazebo Fortress és ROS 2, [szimuláció gyakorlat](https://sze-info.github.io/ajr/szimulacio/gyakorlat/): saját robotszimuláció létrehozása.
8| [Tervezés gyakorlat](https://sze-info.github.io/ajr/tervezes/practice/): Polinom alapú lokális tervező megvalósításás. [Nav2](https://navigation.ros.org/) használata szimulátorral.
9| [Szabályozás gyakorlat](https://sze-info.github.io/ajr/szabalyozas/ros2practice/): PID hangolás. Trajektóriakövetés Gazebo szimulátorral. Saját fejlesztésű szabályzó és jármű modell.
10| [Mesterséges intelligencia gyakorlat](https://sze-info.github.io/ajr/mesterseges_intelligencia/practice/): Neurális hálózatok gyakorlat.



## Érdemjegy

- **Aláírás**: Kis beadandó teljesítése (egyszerű otthoni programozási feladat)
- **1 (elégtelen)**: $0\% \leq ZH_{átlag} < 60\%$
- **2 (elégséges)**: $60\% \leq ZH_{átlag} < 90\%$
- **3 (közepes)**: $90\% \leq  ZH_{átlag} \leq 100\%$  
- **4 (jó)**: Nagy féléves beadandó a [megadott irányelvek](https://sze-info.github.io/ajr/feleves_beadando/) mentén, nagyobb hibákkal teljesítve
- **5 (jeles)**: Nagy féléves beadandó a [megadott irányelvek](https://sze-info.github.io/ajr/feleves_beadando/) mentén, csak néhány kisebb hibával teljesítve


## Konvenciók

- :material-code-braces-box:  gyakorlati tananyag
- :material-math-integral-box:  elméleti tananyag
- :material-code-block-tags:  kiegészítő tananyag, a teljes kép megértéséhez szükséges lehet
- :material-presentation:  prezentációs tananyag

## Érintett témakörök (nem a feldolgozás szerinti sorrendben)

- Bevezetés: Önvezető / autonóm járművek bevezetése: az aktuális helyzet, múlt és jövő. Szenzorok, aktuátorok kommunikációs technológiák. (LIDAR, radar, aktív és passzív kamera, GPS, odometria, IMU, CAN) Foxglove studio és saját mérések szemlétetésképp				
- Szoftverrendszer: Önvezető / autonóm járművek szoftverei: érzékelés, észlelés, tervezés, követés. Szimulációs technológiák, felhasználói felületek. Keretrendszerek: ROS/ROS2/MATLAB/LabVIEW szererepe, valós idejű rendszerek (FPGA, real-time operációs rendszerek).				
- Érzékelés: SLAM, objektumdetekció, objektumkövetés és előrejelzés. Padkadetekció, sávdetekció, úthibadetekció, jármű és gyalogosdetekció/követés stb. Mesterséges intelligencia (különösen neurális hálózatok) és hagyományos (pl C++ nyelven készült) algoritmusok előnyei hátrányai, fúziója.				
- Technológiai ismeretek: Linux, Git: Linux ismeretek: Terminal kezelése, Git kezelése, VS code, ROS telepítése				
- Technológiai ismeretek: ROS 2 alapok: topicok és üzenetek, MCAP (Rosbag) visszajátszása, Topicok kezelése, Topic tartalmának elérése pythonból, rviz, rqt_plot, MCAP (Rosbag) készítés. 
ROS 2 ökoszisztéma és fejlesztés ROS 2 node-ok készítése pythonban és C++-ban: ROS 2 node-ok, rqt_graph, Publisher / Subscriber node pythonban, Publisher / Subscriber node C++-ban. 
Első egyeztetés az egyéni projektfeladatról.
- ROS 2 programozás:ROS szenzoradatok feldolgozása C++ node-al: ROS node-ok írása, `visualization_msgs`, LIDAR szenzoradatok: `sensor_msgs/PointCloud2`, `sensor_msgs/LaserScan`, stb.				
- Szimuláció és szabályzás:	Szimuláció: ROS node-ok használata szimulációhoz (gazebo) F1/10, rviz, egyéni projektfeladatok véglegesítése. Tervezés blokk: trajektória tervezők típusai, kinematikai kihívások, Szabályzás blokk: járműmodellezés, szabályzók bemutatása, jármű- és aktuátorszintű szabályzás, a mozgás megvalósítása (fékrendszerek, kormányrendszerek…stb) 				
- Kitekintés, doktori kutatások, egyetemi hallgatói csapatok: Nissan Leaf, Lexus és Szenergy önvezető projektek, bemutatása, kiragadott kódrészletekkel
Érzékelés: pontfelhő kezelés vagy objektum detektálás kamera alapon
Észlelés / tervezés: útvonalmeghatározás, szabad terület meghatározás, trajektória tervezés
Szabályzás: zárthurkú modellezett jármű, szabályzó építése (pl PID vagy pure pursuit)				
- Mesterséges intelligencia: Önvezető / autonóm járművek szoftverei, összefoglalás, kitekintés neurális hálózatok (mesterséges intelligencia, AI)				
- Technológiai ismeretek: ROS 2	használata, újdonságai ROS-hez képest				
- Projektmunka:	Egyéni projektfeladat bemutatása				

![](https://raw.githubusercontent.com/sze-info/arj/main/docs/_images/technology01.svg)

<br><br><br>
<center>
<h1><a href="https://sze-info.github.io/ajr/">sze-info.github.io/ajr</a></h1>
</center>

<br><br><br>
<center>
<h1><a href="https://go.sze.hu/ajr">go.sze.hu/ajr</a></h1>
</center>



<br><br><br>