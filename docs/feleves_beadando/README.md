---
layout: default
title: Kis beadandó és nagy féléves
nav_order: 4
has_children: true
permalink: /feleves_beadando/
icon: material/home
hide:
  - toc
---

# Kis beadandó és nagy féléves

A kis beadandó célja, hogy a hallgatók az órán megszerzett kezdő szintű elméleti tudás mellé gyakorlati tapasztalatot szerezzenek ROS 2-ről és GitHub-ról. A kis beadandó viszonylag **kevés idő** alatt elvégezhető: egy oktató pár óra alatt, egy átlag hallgató pár délután alatt elkészülhet vele. Terjedelme lehet rövid, tehát 30-100 kódsor node-onként.

Ezzel szemben a nagy féléves egy kicsit több időt vesz igénybe, de sokkal érdekesebb feladatra is van lehetőség és idő. Ráadásul a jó és jeles érdemjegyet is csak így lehet megszerezni.

A jegyszerzés másik lehetősége a ZH-k, erre azonban csak szerény érdemjegy kapható.

```mermaid
flowchart TD

K([Kötelező</br>kis beadandó ]):::light ------> |sikertelen| X0
K --> A([Aláírás]):::green 
A -->|ZH irány| ZH1([1. ZH]):::light
A --> |féléves irány| N([Nagy féléves]):::light
PZH --> |sikertelen| X1
ZH2 --> |sikertelen| PZH([Pót ZH]):::light
ZH1 --> ZH2([2. ZH]):::light
ZH2 --> |siker| OK1
PZH --> |siker| OK1
N ----> |siker| OK2
X0([Aláírás megtagadás]):::red
X1([1, elégtelen]):::red
OK2([4/5 érdemjegy]):::green
OK1([2/3 érdemjegy]):::green

classDef light fill:#34aec5,stroke:#152742,stroke-width:2px,color:#152742  
classDef dark fill:#152742,stroke:#34aec5,stroke-width:2px,color:#34aec5
classDef white fill:#ffffff,stroke:#152742,stroke-width:2px,color:#152742
classDef red fill:#ef4638,stroke:#152742,stroke-width:2px,color:#fff
classDef green fill:#138b7b,stroke:#152742,stroke-width:2px,color:#fff

```

## Határidők, félév beosztása

Fontos, tudni, hogy a kis beadandó **aláírás feltétel**. A GitHub regisztráció, a beadandó link beküldés elmulasztása, már a szemeszter viszonlag korai szakszában sikeretelen félévet eredményezhet. Ezek kis feladatok, meglétüket mégis szigorúan ellenőrizzük.

```mermaid
flowchart LR

H2([2. alkalom]) --- H2A([Github<br>regisztráció])--- H2B([Copilot regisztráció<br>indítása])
H3([3. alkalom]) --- H3A([Beadandó Github<br>link elküldése]) --- H3B([Copilot<br>regisztráció kész])
H5([5. alkalom]) --- H5A([Kis beadandó<br>véglegestése])
H7([7. alkalom]) --- H7A([1. ZH]) --- H7B([Nagy féléves Github<br>link elküldése])
H10([10. alkalom]) --- H10A([2. ZH])
H13([13. alkalom]) --- H13A([PótZH])
V2([Vizsgaidőszak 2. hét]) --- V2A([Nagy féléves<br>véglegesítés])


classDef light fill:#34aec5,stroke:#152742,stroke-width:2px,color:#152742  
classDef dark fill:#152742,stroke:#34aec5,stroke-width:2px,color:#34aec5
classDef white fill:#ffffff,stroke:#152742,stroke-width:2px,color:#152742
classDef red fill:#ef4638,stroke:#152742,stroke-width:2px,color:#fff
classDef green fill:#138b7b,stroke:#152742,stroke-width:2px,color:#fff

class H2,H3,H5,H7,H10,H13,V2 white
class H2A,H2B,H3B,H7A,H7B,H10A,V2A light
class H3A,H5A,H13A, red
```
