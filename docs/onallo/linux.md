---
layout: default
title: Linux
parent: Önálló feladatok
---

 




# Linux gyakorlás

## Mapparendszer létrehozása - terminal

A feladathoz telepítsük a `tree` parancsot: 
```
sudo apt install tree
```

A feladathoz megoldásához `touch`, `chmod`, `mkdir` parancsok kellenek. 

Hozzuk létre a következő mapparendszert, ami a `cd ~ && tree tmp_dir/` parancsra a következőképp néz ki:

```
~/tmp_dir/
├── animals
│   ├── cat
│   └── dog
│       ├── komondor
│       ├── puli
│       └── vizsla
├── colors
│   ├── blue
│   ├── green
│   └── red
├── py_exec.py
├── simple_text.txt
└── top
    └── middle
        └── bottom
            └── hello.txt
13 directories, 3 files
```

Az `ls -l  ~/tmp_dir/` parancsra pedig a következőhöz hasonló `rwx` értékeket mutatja:

```
drwxr-xr-x 4 he he 4096 Feb 17 14:54 animals
drwxr-xr-x 5 he he 4096 Feb 17 14:55 colors
-rwxrwxrwx 1 he he    0 Feb 17 14:52 py_exec.py
-rw-r--r-- 1 he he    0 Feb 17 14:53 simple_text.txt
drwxr-xr-x 3 he he 4096 Feb 17 14:43 top
```



### Megoldás segédlet

```
mkdir -p top/middle/bottom
mkdir -p colors/{red,green,blue}
mkdir -p animals/{cat,dog/{vizsla,puli,komondor}}
```

## Szöveges fájlok

Ha még nem hozuk létre, akkor készítsünk egy `~/tmp_text/` mappát.

A mappán belül készítsünk egy `hello.py` fájlt, majd terminálból töltsük fel a következő tartalommal:

``` python
import sys
print('\nHello vilag!\nA verzio pedig:\n' + sys.version)
```

Tegyük futtathatóvá és futtassuk.


### Megoldás segédlet

``` python
echo "import sys" >> hello.py
echo "print('\nHello vilag!\nA verzio pedig:\n' + sys.version)" >> hello.py
```