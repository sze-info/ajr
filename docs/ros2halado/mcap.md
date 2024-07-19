---
layout: default
title: MCAP fájlok
parent: ROS 2 haladó 
---

## `MCAP` fájlok

Az `ROS 2` az log adatokhoz az `MCAP` formátumot használja. Ez a formátum **nem** dedikáltan az ROS saját formátuma, hanem egy nyílt forráskódú konténerfájl típus tetszőleges multimodális log-adatokhoz. Támogatja az időbélyegzővel ellátott, előre sorba rendezett adatokat. Így ideális a pub/sub vagy robotikai alkalmazásokban való használatra is, a `ROS 2` is ezért döntött mellette. A következőkben arról lesz szó, hogyan lehetséges a formátum C++,	Go,	Python,	Rust,	Swift vagy TypeScript nyelven történő szerkesztése. Illetve egy python példán keresztül gyakorlati oldalról is szemléltetjük ezt.

Az MCAP egy fejlett logfájlformátum, amely kifejezetten a pub/sub üzenetek és multimodális szenzoradatok időbélyeggel ellátott csatornáinak tárolására szolgál. Nem kötődik egyetlen sorosítási formátumhoz sem, így képes bármilyen formátumú bináris üzenetek, például Protobuf, DDS (CDR), ROS, JSON és mások rögzítésére és visszajátszására. Az MCAP nagy teljesítményű írást tesz lehetővé a sororientált, csak hozzáfűző tervezésének köszönhetően, amely minimalizálja a lemez I/O műveleteket és csökkenti az adatvesztés kockázatát nem tiszta leállítások esetén.

Az MCAP önálló formátum, mivel az üzenetek sémáit is az adatok mellett tárolja, így a fájlok a jövőben is olvashatóak maradnak, még akkor is, ha a kódbázis időközben változik. Az MCAP fájlok opcionális indexet tartalmaznak, ami gyors és hatékony adatolvasást tesz lehetővé, még alacsony sávszélességű internetkapcsolaton keresztül is. Opcionális tömörítést is kínál, például LZ4 vagy Zstandard formájában, miközben továbbra is támogatja a hatékony indexelt olvasást.

Az MCAP széles körű nyelvi támogatást nyújt, natív olvasó és író könyvtárakkal C++, Go, Python, Rust, Swift és TypeScript nyelveken. A formátum rugalmasan konfigurálható opcionális funkciókkal, mint a darabolás, indexelés, CRC ellenőrzőösszegek és tömörítés, hogy a megfelelő kompromisszumokat kínálja az adott alkalmazáshoz. Az MCAP gyártásra kész formátum, amelyet széles körben használnak különböző cégek, például autonóm járművek és drónok esetében, és ez az alapértelmezett logformátum a ROS 2-ben.


Az `MCAP` fájlformátum ROS 2 agnosztikus, tehát nem függ magától az ROS 2-től, így bármilyen Python projektben használható. Fontos megjegyezni, hogy a `rosbag2-api` python csomag viszont ROS 2 függő. Így célszerű inkább az `mcap-ros2-support` python csomag használata, amely nem igényel ROS 2-t, így például Windowson is futtatható.

A Python MCAP ROS2 support csomag (`mcap-ros2-support`) lehetővé teszi a ROS2 támogatást a Python MCAP fájlformátum olvasó számára. Telepítsük a következő parancshoz hasonló módon:

```bash
pip install mcap mcap-ros2-support matplotlib numpy pandas scipy
```

## MCAP fájl olvasása példa

A [github.com/jkk-research/jkk_utils/tree/ros2/mcap_scripts](https://github.com/jkk-research/jkk_utils/tree/ros2/mcap_scripts) elérésen több hasonló példa is megtalálható:

```python
from mcap_ros2.decoder import DecoderFactory
from mcap.reader import make_reader
def main():
    with open('C:\\temp\\test.mcap', "rb") as f:
        reader = make_reader(f, decoder_factories=[DecoderFactory()])
        #list all topics and types
        channels = reader.get_summary().channels.items()
        print("Available topics are the following:")
        for index, (channel_key, channel_value) in enumerate(channels):
            print("%2d. topic: %s" % (index+1, channel_value.topic))
```


# Források

- [docs.ros.org/en/humble/How-To-Guides/Visualizing-ROS-2-Data-With-Foxglove-Studio.html](https://docs.ros.org/en/humble/How-To-Guides/Visualizing-ROS-2-Data-With-Foxglove-Studio.html)
- [github.com/jkk-research/jkk_utils/tree/ros2/mcap_scripts](https://github.com/jkk-research/jkk_utils/tree/ros2/mcap_scripts)
- [mcap.dev](https://mcap.dev/)
- [mcap.dev/docs/python/raw_reader_writer_example](https://mcap.dev/docs/python/raw_reader_writer_example)
- [pypi.org/project/mcap-ros2-support](https://pypi.org/project/mcap-ros2-support/) (✔️ recommended, no ROS 2 dependency)
- [pypi.org/project/rosbag2-api](https://pypi.org/project/rosbag2-api/) (❌ ROS 2 dependency)