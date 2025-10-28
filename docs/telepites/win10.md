---
title: Windows WSL2
icon: material/code-block-tags # kiegészítő tananyag
---

# Windows WSL2

![wsl](/ajr/assets/images_common/wsl01.svg){ align=right width="200" }

A **Windows Subsystem for Linux** egy kompatibilitási réteg Linux-alapú elemek natív futtatásához Windows 10, vagy Windows 11 alapú rendszereken. Akkor érdemes választani a WSL használatát, ha nem szeretnétek natív Ubuntu-t (pl 18.04 / 22.04) telepíteni a számítógépeitekre. A tantárgyban használható rendszer többféle módon is létrehozható:

- WSL telepítése és Snapshot importálása [link](#wsl-telepitese-es-snapshot-importalasa)
- WSL telepítése és ROS installálása Script segítségével [link](#wsl-telepitese-es-ros-installalasa-script-segitsegevel) 

## WSL telepítése és Snapshot importálása

A telepítést bemutató videó: 

<iframe width="560" height="315" src="https://www.youtube.com/embed/yBLtg2c4yA4?si=PO7NefOrQJQV0tG8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

A videó lépései szövegesen:

1. WSL snapshot (backup fájl) letöltése: [WSL snapshot letöltése :material-download: ~2.5 GB](https://laesze-my.sharepoint.com/:u:/g/personal/herno_o365_sze_hu/EYxEY_oJa7ZEursLIBMZeZ4BWUvT_LbkHbOIsPToBgRxbg?download=1){ .md-button}
2. Snapshot kicsomagolása `.zip` >> `.tar`
3. Powershell (Admin) WSL feature bekapcsolása, majd WSL telepítése: 
``` powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```
``` powershell
wsl --install --no-distribution
```
4. Powershell, WSL Snapshot fájl (tar) importálás: 
``` powershell
wsl --import ajr1 .\ajr1\ .\ajr24a.tar
```
5. VS code és WSL kiegészítő telepítése: 

![wsl03](/ajr/assets/images_common/wsl03.png)

!!! danger
    A `wsl -l -v` parancs listázza a telepített WSL verziókat. A `VERSION` oszlopnak 2-nek kell lennie, különben a WSL elavult verzióját telepítettük. Példa helyes kimenetre:
    ``` bash
    NAME            STATE           VERSION
    Ubuntu          Stopped         2
    Ubuntu-22.04    Stopped         2
    Ubuntu-24.04    Running         2
    ajr1            Stopped         2
    ```
    Amennyiben a `VERSION` oszlopban `1`-es szerepel `wsl --update` paranccsal lehet a verziót frissíteni.

## Megjegyzés a kollégiumi hálózatról

A Windows Subsystem for Linux (WSL) használatához a kollégiumban végezd el az alábbi beállításokat annak érdekében, hogy ne tiltódj le-

- Nyisd meg a WSL Settings programot (start menü, nem a WSL terminál)
- Válaszd a Hálózatkezelés menüt (networking)
- Az első, hálózati mód networking mode) beállításnál válaszd a **Mirrored** opciót (**nem Nat**)

![wsl06](/ajr/assets/images_common/wsl06.png)


### További ajánlott beállítások

A Windows Terminal programban ajánlott beállítani a `Deafault Profile`-t az `ajr1`-re, hogy mindig ezzel induljon a program. Továbbá az `Open windows from previous session` beállítás is hasznos lehet, hogy a legutóbbi állapotban induljon a program (pl. több panellel).s

![wsl04](/ajr/assets/images_common/wsl04.png)

A paneleket ezután a `Alt`+`Shift`+`minus` vagy `Alt`+`Shift`+`plus` billentyűkombinációval lehet létrehozni. Ez szétosztja a terminál ablakot (`Split pane`) több részre vertikálisan vagy horizontálisan.

![wsl05](/ajr/assets/images_common/wsl05.png)

## WSL telepítése és ROS installálása Script segítségével

A WSL telepítését bemutató Windows 11-es videó (Windows 10 verzió lejjebb, de nagyrészt megegyező tartalommal):

<iframe width="560" height="315" src="https://www.youtube.com/embed/DIYktkx3XLM?si=-cjaTd6PbhuFkXfY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

A videó lépései szövegesen:

- Rendszergazdaként futtatva nyissatok egy PowerShell ablakot.
- Másoljátok be az alábbi parancsot. Ezzel engedélyezitek a WSL használatát.
``` bash
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```
- Indítsátok újra a számítógépet az ```Y``` betű beírásával. *(opcionális)*
- Nyissátok meg a Microsoft Store-t, és keressetek rá a Windows Subsystem for Linux Preview-ra. Telepítsétek.
- Szintén a Microsoft Store-ban keressetek rá az Ubuntu 22.04-re, és telepítsétek, **vagy** PowerShell (Admin):
``` bash
wsl --install -d Ubuntu-22.04
```
- A könnyebb kezelhetőség érdekében érdemes telepíteni a Windows Terminal programot is. Szintén a Microsoft Store-ban keressetek rá a Windows Terminal-ra, és telepítsétek.
- Indítsátok el a Windows Terminal programot, és a Ctrl+, (Control és vessző) billentyűkombinációval nyissátok meg a beállításokat. A Default Profile beállítási sor legördülő listájából válasszátok az Ubuntu 22.04-et. 
- Indítsátok újra a Windows Terminal-t. Az első induláskor adjatok meg tetszőleges felhasználónevet és jelszót. 
- A megoldás kidolgozásához a VS Code szerkesztőt javasoljuk. Telepítsétek innen: [code.visualstudio.com/download](https://code.visualstudio.com/download)
- Végül telepítsétek a VS Code Remote Development kiegészítőjét, hogy WSL használatával is elérhető legyen: [marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

A WSL telepítését bemutató Windows 10-es videó [itt](https://youtu.be/S1U-f5pzO7s) érhető el: 

<iframe width="560" height="315" src="https://www.youtube.com/embed/S1U-f5pzO7s?rel=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

A VS Code telepítéséhez [itt](https://youtu.be/fAkpQ4Q3S2g) találtok útmutatót: 


<iframe width="560" height="315" src="https://www.youtube.com/embed/fAkpQ4Q3S2g?rel=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

