---
title: Windows WSL2
icon: material/code-block-tags # kiegészítő tananyag
---

# Windows WSL2

A **Windows Subsystem for Linux** egy kompatibilitási réteg Linux-alapú elemek natív futtatásához Windows 10, vagy Windows 11 alapú rendszereken. Akkor érdemes választani a WSL használatát, ha nem szeretnétek natív Ubuntu-t (pl 18.04 / 22.04) telepíteni a számítógépeitekre.

A WSL telepítését bemutató Windows 11-es videó (Windows 10 lejjebb, de nagyrészt ugyanez):

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