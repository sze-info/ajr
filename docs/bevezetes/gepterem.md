---
layout: default
title: Gépterem
parent: Bevezetés
# icon: material/plus-outline
icon: material/code-block-tags # kiegészítő tananyag
---

# Gépterem (`C100` és `B2`)

## Géptermi telepítés (`C100`)

!!! warning "Fontos"
    Amennyiben a géptermi telepítést korábban elvégezték, ez a lépés kihagyható.
    Mindig használjuk a lehető legfrissebb telepítést a verziók (pl `sze24a.tar`, `sze26a.tar`) közül.

### Tantermi WSL backup fájl letöltése

=== "Parancssor"

    ``` bash
    cd /d C:\
    if not exist temp mkdir temp
    cd temp
    robocopy "\\fs-kab.eik.sze.hu\C100\kozos\GKNB_AUTM078_Autonóm_robotok_és_járművek_programozása\wsl_backup" C:\temp sze26a.tar /Z /R:3 /W:5
    ```

=== "Linux"

    ``` bash
    cd /mnt/c & mkdir temp & cd temp
    rsync -avzh --progress /mnt/kozos/wsl_backup/sze26a.tar
    ```

=== "PowerShell"

    ``` powershell
    cd C:\ & mkdir temp & cd temp
    Copy-Item "\\fs-kab.eik.sze.hu\C100\kozos\GKNB_AUTM078_Autonóm_robotok_és_járművek_programozása\wsl_backup\sze26a.tar" -Destination "C:\temp\" -Recurse -Force
    ```

### WSL snapshot importálása

**Megjegyzés:** A WSL alrendszer engedélyezéséről a [WSL telepítés](/ajr/telepites/win10/) oldalon található információ.

A WSL import parancs szintaxisa a következő:
```cpp
wsl --import  <disztró neve>  <hova kerüljön a vhdx>  <melyik tar-ból>
              ajr2            C:\temp\sze26a_folder   C:\temp\sze26a.tar
```

=== "Parancssor"

    ```powershell
    wsl --import ajr2 C:\temp\sze26a_folder C:\temp\sze26a.tar --version 2
    ```
=== "PowerShell"

    ``` powershell
    wsl --import ajr2 C:\temp\sze26a_folder C:\temp\sze26a.tar --version 2
    ```

## Közös meghajtó (`K:\`)

A közös meghajtó a `K:\` meghajtóként található meg Winodws Fájlkezelőben (File Explorer). Ha esetleg nem látszana, akkor szintén a Fájlkezelőben elérhető:

```powershell
\\fs-kab.eik.sze.hu\C100\kozos
```


## Géptermi ismeretek (`C100`)

### Közös meghajtó (`K:\`)

A közös meghajtó a `K:\` meghajtóként található meg Winodws Fájlkezelőben (File Explorer). Ha esetleg nem látszana, akkor szintén a Fájlkezelőben elérhető:

```powershell
\\fs-kab.eik.sze.hu\C100\kozos
```

![gepterem01](/ajr/assets/images_common/gepterem01.png)

A tantárgyhoz kapcsolódó fájlok pontosan a [`\\fs-kab.eik.sze.hu\C100\kozos\GKNB_AUTM078_Autonóm_robotok_és_járművek_programozása`](file://fs-kab.eik.sze.hu/C100/kozos/GKNB_AUTM078_Auton%C3%B3m_robotok_%C3%A9s_j%C3%A1rm%C5%B1vek_programoz%C3%A1sa/) címen érhetőek el.

### WSL és közös meghajtó

WSL alól szintén el kellene tudni érni a közös meghajtót mégpedig az `/mnt/kozos` mount ponton. Teszteljük az elérést a `cd /mnt/kozos` paranccsal. Ha a `-bash: cd: /mnt/kozos: No such file or directory` üzenetet kaptuk, akkor hozzuk létre `mkdir` segítségével. Ha az `ls /mnt/kozos` nem listáz fájlokat, akkor pedig nincs felmountolva.

Ha esetleg nem működne a közös meghajtó, akkor ezek a parancsok segíthetnek:

``` r
sudo mkdir /mnt/kozos
echo "\\\\\\\\fs-kab.eik.sze.hu\C100\kozos\GKNB_AUTM078_Autonóm_robotok_és_járművek_programozása    /mnt/kozos    drvfs defaults,uid=1000,gid=1000    0    0" | sudo tee -a /etc/fstab
```
Majd `wsl --shutdown` windows cmd-ből.


## WSL a Fájlkezelőben

Az Ubuntu 22.04 fájljai szintén elérhetőek a Windows Fájlkezelőből. Bal oldlalt lászik egy WSL vagy Linux felirat. A `~` a `/home/<gépnév>` mappán belül érhető el, így a `ros2_ws` is. 

![gepterem01](/ajr/assets/images_common/gepterem01.png)


## VS code

## VS code WSL elérés

![vs code WSL](/ajr/assets/images_common/vscodebasics03.png)

## VS code hasznos extension-ök

![vs code extensions](/ajr/assets/images_common/vscodebasics04.png)

## Windows terminal

A közös meghajtón található egy portable verzió. Ezt a `C:\temp`-be másolva használható a program.

![win terminal](/ajr/assets/images_common/windows_terminal01.png)

A következő ábra egy **célszerű** (nem kötelező) géptermi elrendezést mutat, bal oldalt a terminal, jobb oldalt a böngésző:

![win layout](/ajr/assets/images_common/gepterem02.png)

![](/ajr/assets/images_common/windows_terminal02.png)

![](/ajr/docs/assets/images_common/wsl_overview01.svg)

## Foxglove / Lichtblick

Telepítve van, az asztalon található ikonnal indítható. Ha mégse lenne telepítve, a közös meghajtón lévő portable verziót kell a `C:\temp`-be másolni. 

![foxglove_lichtblick_logo](/ajr/assets/images_common/foxglove_lichtblick01.png)

![foxglove](/ajr/assets/images_common/foxglove01.png)



## Géptermi beállítások gyors ellenőrzése

!!! success "Ellenőrzés"
    A következő parancsokat futtasd le a géptermi terminálban:
    ``` r
    cd /mnt/kozos/script/
    ./check_all.sh
    ```
