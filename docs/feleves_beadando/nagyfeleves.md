---
title: Nagy féléves
permalink: /nagy_feleves/
icon: material/school
---

 

# Nagy féléves

A nagy féléves projekt elkészítése több időt igényel, azonban lehetőség van sokkal érdekesebb feladatokat kidolgozni, ráadásul jóval több hét alatt. A félévesre alapozva, a tárgy *teljesítése után* akár diplomamunka, szakdolgozat, projektmunka, TDK dolgozat is készíthető, illetve van lehetőség a kötelező szakmai gyakorlat teljesítésére is. Féléves választása esetén **nem kötelező** a ZH, de ha valaki úgy dönt, hogy ír, akkor a jobb eredmény számít.


## Példák

Példa a nagy félévesre, amit az oktatók készítettek:

- [github.com/horverno/simple_random_trees](https://github.com/horverno/simple_random_trees): A package egy egyszerű útvonaltervezésre használható véletlenszerű fa algoritmus. Ez a megvalósítása a vizualizációra összpontosít, nem pedig egy átfogó véletlenszerű fa-alapú útvonal tervező rendszer. A `/display_tree
node` egy `/path_marker_topic`-ot hirdet, ami `visualization_msgs/marker_array` típusú. A faadatstrukúrát megvalósító függvények külön header fájlban kaptak helyet. Megvalósítás `ROS 2 Humble` alatt.

Az alábbi példák nem feltétlenül féléves munkának készültek, de annak elfogadhatóak lennének:

- [github.com/jkk-research/wayp_plan_tools](https://github.com/jkk-research/wayp_plan_tools)
- [github.com/jkk-research/sim_wayp_plan_tools](https://github.com/jkk-research/sim_wayp_plan_tools)
- [github.com/jkk-research/pointcloud_to_grid](https://github.com/jkk-research/pointcloud_to_grid)
- [github.com/jkk-research/urban_road_filter](https://github.com/jkk-research/urban_road_filter)
- [github.com/dobaybalazs/curb_detection](https://github.com/dobaybalazs/curb_detection)
- [github.com/kkira07/Szakdolgozat](https://github.com/kkira07/Szakdolgozat)
- [github.com/szenergy/rviz_markers](https://github.com/szenergy/rviz_markers)
- [github.com/linklab-uva/f1tenth_gtc_tutorial](https://github.com/linklab-uva/f1tenth_gtc_tutorial)
- [github.com/Farraj007/Jkk-task](https://github.com/Farraj007/Jkk-task)
- [github.com/leander-dsouza/breakout_gazebo](https://github.com/leander-dsouza/breakout_gazebo)
- [github.com/fjp/ros-turtle-pong](https://github.com/fjp/ros-turtle-pong)

*Megjegyzés*: a tárgyban az ROS 2 Humble verziót használjuk, de a féléves beadandót (indoklással) más verzióban is elfogadjuk.

## A *féléves* feladatnál pozitív hatást kelt:
- 👍 Jól követhető magyar és/vagy angol nyelvű dokumentáció is, képekkel illusztrálva. [Markdown](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) használata.
- 👍 Alap információk a `README.md`-ben, (opcionális) dokumentáció a `/wiki`-ben.
- 👍 Issue-k.
- 👍 Branch-ek.
- 👍 Gitignore.
- 👍 Licensz.
- 👍 Repository topic-ok, köztük a tárgykód és a SZE. A topic-ok alapján aztán pl itt is listázódik a repository: [github.com/topics/sze](https://github.com/topics/sze).
- 👍 Plusz jegy adható, amennyiben a jelen tananyag kiegészítésre / hibajavításra kerül (temészetesen pull request által).

## *Komoly hibák*, ami miatt a *féléves* akár több érdemjeggyel is rosszabb  lehet:
- 😡 Tömörített állomány a GitHub repositoryban (pl. `zip` és még rosszabb, ha `rar`). Kivétel lehet, ha direkt tömörített állománykezelés a cél, de forráskód, kép, stb. soha ne kerüljön így fel. 
- 😡 [Nem eredeti munka](#meme), vagy az átvett kód nincs hivatkozva. 
- 😡 Csapatban csak egy hallgató commitol. (Ez nyilván nem vonatkozis egyfős feladatokra).
- 😡 Kevés commit. Azért lenne fontos a megfelelő számú commit, mert ebből tudjuk, megítélni, hogyan haladt előre a munkafolyamat, ki, mit és mikor dolgozott.
- 😡 Nincs `README.md`, hiányzik a rövid dokumentáció vagy a képek.
- 😡 A dokumentáció pdf / docx-ként feltöltve a `/wiki` helyett.
- 😡 File upload commit helyett.
- 😡 Forráskód kiképmetszőzve markdown szintaxis kiemelés helyett. (Mivel képként nem másolható, kereshető, stb a kód.)

## Ötletek témaválasztáshoz

- Inspriráció lehet a korábbi vagy jelenlegi szakdolgozatok / diplomamunkák témái: [horverno.github.io/temaajanlatok](https://horverno.github.io/temaajanlatok/)
- Olyan témát célszerű választani, amin szívesen dolgoznál heteken/hónapokon keresztül is. Ha pl. a vizualizáció, az algoritmusok gyakorlata, a 3D vagy épp a mesterséges intelligencia vonzó, akkor ennek megfelelő témát célszerű választani.
- Korábbi szakdolgozatok, félévesek elérhetőek, ezeket igényelni [itt lehet](https://docs.google.com/forms/d/e/1FAIpQLSdtMK--IQl4v5pHiATDP4MJwuU-M0Ycd2keMndQfuuhvlr1rA/viewform?usp=sf_link). Fontos, hogy ezeket **tilos** továbbosztani, csak oktatási céllal állnak rendelkezésre.
- Számos ROS 2 projekt itt: [github.com/fkromer/awesome-ros2](https://github.com/fkromer/awesome-ros2)

!!! tip
    Erősen ajánlott a [GitHub Student Developer Pack](https://education.github.com/pack) beszerzése, többek között [Copilot](https://github.com/features/copilot) is jár hozzá.
    Erről itt lehet részletesen olvasni: [sze-info.github.io/ajr/bevezetes/copilot/#github-copilot-beszerzese-sze-hallgatoknak](https://sze-info.github.io/ajr/bevezetes/copilot/#github-copilot-beszerzese-sze-hallgatoknak)

![](https://github.blog/wp-content/uploads/2019/08/FBLinkedIn_ALL-PARTNERS.png)

## Értékelési szempontok

A szempontok kialakításánaál az [Óbudai Egyetem](https://abc-irobotics.github.io/ros_course_materials_hu/#evkozi-jegy_1) hasonló kurzusának értékelési szempontjait vettük alapul.

- Saját munka és fehasznált kódbázis aránya (megfelelő hivatkozások megléte)
- Értékelhető eredményeket produkáló munka
- A bemutató minősége (ppt, videók, élő demo, bármilyen plusz felhasznált eszköz)
- A megoldás teljessége
- Megfelelő `ROS 2` kommunikáció / best practice alkalmazása
- A program szerkezete
- Az implementáció minősége
- A kód dokumentálása
- Konzultáció
- A választott feladat nehézsége

## Ajánlott módszer a féléves repo létrhozására: `template`

C++ és Python nyelven is létrehoztunk egy úgynevezett template repo-t, amely megkönnyíti az első pacakage-t tartalmazó repository létrehozását:

- [github.com/sze-info/ros2_cpp_template](https://github.com/sze-info/ros2_cpp_template)
- [github.com/sze-info/ros2_py_template](https://github.com/sze-info/ros2_py_template)

!!! info
    Erről [leírás itt](https://sze-info.github.io/arj/onallo/ros2git.html) olvasható.

<img src="https://raw.githubusercontent.com/sze-info/ros2_cpp_template/main/img/use_this_template01.png" width="60%" />

### Meme

<center><img src="https://raw.githubusercontent.com/sze-info/arj/main/docs/feleves_beadando/meme01.jpg" width="60%" /></center>

Credit: [pycoders](https://www.instagram.com/pycoders/)

<center><img src="https://raw.githubusercontent.com/sze-info/arj/main/docs/feleves_beadando/meme02.jpg" width="60%" /></center>

Credit: [knowyourmeme](https://knowyourmeme.com/memes/but-its-honest-work)