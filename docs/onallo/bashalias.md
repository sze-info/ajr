---
layout: default
title: Bash aliases
---

 
# Bash aliases

A `.bash_aliases` egy konfigurációs fájl a Bash számára, amely lehetővé teszi aliasok (parancs átnevezések/alternatívák) létrehozását és egyéni parancsok definiálását. Az aliasok használatával rövidítheted a gyakran használt parancsokat, vagy megadhatsz olyan parancsokat, amelyeket gyakran szeretnél ugyanúgy futtatni, de hosszabb vagy bonyolultabb paraméterekkel. 

Arra jó, hogy pl. a gyakran használt `source ~/ros2_ws/install/setup.bash` parancsot az `r2` rövidítéssel futtathatod.

Nézzük meg mi található jelenleg a `.bash_aliases` fájlban:

``` bash
cat ~/.bash_aliases
```

Az előretelepített verzókban hasonló tartalom fogad:

``` r
# some more ls aliases for JKK, Szenergy and friends
alias r2='source ~/ros2_ws/install/setup.bash && echo "source ~/ros2_ws/install/setup.bash"'
alias aw='source ~/autoware/install/setup.bash && echo "source ~/autoware/install/setup.bash"'
alias r1='screen -mdS roscore1 bash -c 'roscore' && echo "screen roscore1"'
``` 

Ha nincs ilyen fájl, akkor hozzuk létre és töltsük le a fenti tartalmat:

``` r 
cd ~; wget https://raw.githubusercontent.com/jkk-research/jkk_utils/ros2/.bash_aliases
```

Ha van ilyen fájl, de szeretnéd frissíteni, akkor töröld és töltsd le újra:

``` r 
cd ~; rm .bash_aliases; wget https://raw.githubusercontent.com/jkk-research/jkk_utils/ros2/.bash_aliases
```
