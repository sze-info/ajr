---
layout: default
title: ROS 2 humble telepítése
icon: material/code-block-tags # kiegészítő tananyag
---



# ROS 2 humble

!!! tip "Egyszerű telepítés"

    A telepítés lépésről-lépésre is végrehajtható, de készítettünk egy [egyszerű shell script alapú telepítést](#otthoni-geptermi-telepites) is.

Ahogy abevezetőben írtuk, alapvetően négy lehetőség adott `ROS 2 Humble` telepítésére:

1. Dual boot, Windows mellé telepített natív Linux (leginkább Ubuntu) ✅ [leírás](https://sze-info.github.io/arj/telepites/ubuntu.html)
2. Windows WSL2, könnyűsúlyú Linux virtuális gép ✅ [leírás](https://sze-info.github.io/arj/telepites/win10.html)
3. Virtuális gép Windowsra 🟠
4. Windows build 🟠

Ebből a 4 lehetőségből az első kettőt ajánljuk, de telmészetesen a többi sem tiltott. A dual boot betekintést nyújt a Linux világba, ami egy mérnöknél hasznos tudást jelent manapság. Telepítésnél körültekintően kell eljárni, hiszen egy rossz beállítás adatvesztést okoz, így a biztonsági mentés is ajánlott. A WSL (Windows Subsystem for Linux) egy könnyűsúlyú kompatibilitási réteg Linux-alapú elemek futtatásához Windows 10, vagy Windows 11 alapú rendszereken. Ahogy a következő ábrán is látszik, a Linux kernel ugyanolyan egyszerűen érheti el a hardverelemeket (CPU, memória, GPU stb), mint a Windows kernel. Ehhez képest a virtuális gép (3. lehetőség) egy jóval lassabb, több absztrakciós réteget használó megoldás, annak ajánlott, akinek vagy nagyon modern, gyors gépe van, vagy már eleve telepített ilyen rendszereket. A natív Windows build (4. lehetőség) elvileg adott, de mivel a dokumenátió túlnyomó része Linuxra érhető el, így nagyon sok extra munkát fog jelenteni.

Az első három opció szemléltetése:

![wsl áttekintés](wsl_overview01.svg)

## Telepítés

A következő leírás Ubuntu 22.04 Jammyre vonatkozik. *Megjegyzés*, hogy más verziók is támogatottak, ezekre vonatkozó telepítés és leírások elérhetőek itt: [docs.ros.org/en/humble/Installation/Alternatives.html](https://docs.ros.org/en/humble/Installation/Alternatives.html)

A következő leírás a [docs.ros.org/en/humble/Installation.html](https://docs.ros.org/en/humble/Installation.html) alapszik.


## Nyelv beállítása

!!! note 
    Ez a lépés általában kihagyható
 

Győződjön meg arról, hogy olyan területi beállítással rendelkezik, amely támogatja az UTF-8 szabványt. 

``` r
locale # UTF-8 ellenőrzése

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale # beállítások ellenőrzése
```

## Források beállítása
Hozzá kell adnia a ROS 2 apt tárolót a rendszeréhez.

Először győződjön meg arról, hogy az Ubuntu Universe adattár engedélyezve van.

``` r
sudo apt install software-properties-common
sudo add-apt-repository universe
```

ROS 2 GPG kulcs hozzáadása, `apt`-vel.

``` r
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
```

Ezután következik a tároló hozzáadása a forráslistához.

``` r
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```

## ROS 2 csomagok telepítése

Frissítés:

``` r 
sudo apt update
```

A ROS 2 csomagok gyakran frissített Ubuntu rendszerekre épülnek. Mindig ajánlott, hogy új csomagok telepítése előtt meggyőződni arról, hogy rendszere naprakész-e.
``` r 
sudo apt upgrade
```

Desktop telepítés: ROS, RViz, demók, oktatóanyagok telepítése:
``` r 
sudo apt install ros-humble-desktop
```

Fejlesztőeszközök, fordítók és egyéb eszközök ROS-csomagok készítéséhez: 
``` r 
sudo apt install ros-dev-tools
``` 

## Source

Állítsa be környezetét a következő fájl source-olásával:

``` r 
source /opt/ros/humble/setup.bash
```

Tipp: ezt meg lehet tenni a `.bashrc` fájlban is `echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc`.

# Telepítés ellenőrzése

Ellenőrizzük a telepítés helyességét, a `ros2 topic list` paranccsal. 

``` r
$ ros2 topic list

/parameter_events
/rosout 
```

Ha minden rendben, akkor a fenti két topicnak kell megjelennie. Ezután lehet megismerni az egyszerű példa node-ok használatát: [docs.ros.org/en/humble/Tutorials/Beginner-CLI-Tools.html](https://docs.ros.org/en/humble/Tutorials/Beginner-CLI-Tools.html)

# Telepítés utáni ajánlott beállítások

## Konzol színek

Alapértelmezés szerint a konzol kimenet nem színezett, de ezt célszerű beállítani az `RCUTILS_COLORIZED_OUTPUT` környezeti változóval (akár `bashrc`-be írva). Például:

``` r 
export RCUTILS_COLORIZED_OUTPUT=1 
``` 

![RCUTILS_COLORIZED_OUTPUT](https://github-production-user-asset-6210df.s3.amazonaws.com/11504709/248783932-a71a5d37-d49b-4508-93db-2e74a3c24365.gif)

Részletek: [docs.ros.org/en/humble/Tutorials/Demos/Logging-and-logger-configuration.html#id14](https://docs.ros.org/en/humble/Tutorials/Demos/Logging-and-logger-configuration.html#id14)

## `colcon_cd`

Szintén célszerű beállítani a `colcon_cd` paranccsot, így gyorsan válthatunk munkakönyvtárát egy csomag könyvtárára. Példaként a `colcon_cd some_ros_package` parancsra gyorsan a `~/ros2_ws/src/some_ros_package` könyvtárba ugorhatunk.

Részletek: [docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html#setup-colcon-cd](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html#setup-colcon-cd)

# Otthoni / géptermi telepítés

Gépteremben a [következő `install_humble.sh`](https://github.com/sze-info/arj/blob/main/docs/telepites/install_humble.sh) fájlt (shell scriptet) futtatuk minden gépen.

``` bash
wget https://raw.githubusercontent.com/sze-info/arj/main/docs/telepites/install_humble.sh
```
``` bash
sudo chmod +x install_humble.sh
```

Otthon:
``` bash
./install_humble.sh
```
Gépteremben:
``` bash
./install_humble.sh campus
```

# Workspace reset

Ha szeretnénk a teljes `ros2_ws`-t törölni, majd újra klónozni és buildelni (~5 percig eltart), akkor a következő egyetlen hoszú paranccsal megtehetjük:

``` bash
cd ~ ; rm ws_reset.sh; wget https://raw.githubusercontent.com/sze-info/arj/main/docs/telepites/ws_reset.sh; sudo chmod +x ws_reset.sh; ./ws_reset.sh
```

