
The log data is in .mcap format, the standard logging format for [`ROS 2`](https://docs.ros.org/). [`MCAP`](https://mcap.dev/) is an open source container file format for multimodal log data. It supports multiple channels of timestamped pre-serialized data, and is ideal for use in pub/sub or robotics applications.

## Getting started

### Download the `mcap` (bag) files

[Download every MCAP as a ZIP](https://laesze-my.sharepoint.com/:u:/g/personal/herno_o365_sze_hu/EVofDCG_ORZJh--XTVLFsFEBOUYB1eAbHAzdTVDdf19Y9g?download=1){ .md-button }

[Download a sample MCAP](https://laesze-my.sharepoint.com/:u:/g/personal/herno_o365_sze_hu/EWJBcyPd8YZOtdys4zo8kzIButGvzj-PjTS4D-PFoUfpnQ?download=1){ .md-button }

You can instanly view the data in [Foxglove Studio](https://foxglove.dev/) (Free, online or on ay platform).

![](/img/dataset02A.png)

One of the easiest way to getting started with the dataset is to look at the notebook examples:

[Open MCAP in python notebook](https://github.com/jkk-research/jkk-research.github.io/blob/master/notebooks/mcap_basics.ipynb){ .md-button }

## Dataset description


| Route Name | Description | Terrain |
| --- | --- | --- |
| `nissan_zala_90_country_road_1` | road section | flat - no hills |
| `nissan_zala_90_country_road_2` | longer stretches of highway, slight bends, some roundabouts | hilly road |
| `nissan_zala_50_sagod` | slightly winding roads with some sharper turns | 1 slight uphill |
| `nissan_zala_50_zeg_1` | mostly going in one direction, interrupted by roundabouts, continuous going | flat - no hills |
| `nissan_zala_50_zeg_2` | roundabouts, bends, stationary situations (due to traffic) | flat - no hills |
| `nissan_zala_50_zeg_3` | square bends with parking | flat - no hills |
| `nissan_zala_50_zeg_4` | winding | flat - no hills |
| `nissan_zala_90_mixed` | dynamic, city and country road | mostly flat, last about 10m hilly |


# Usage in Ubuntu / Windows WSL

## Install `mcap`:
```
pip install mcap
```

## Download dataset, e.g. to `/mnt/c/bag/jkkds02/`:
``` bash
cd /mnt/c/bag/jkkds02/
```

``` bash
wget https://laesze-my.sharepoint.com/:u:/g/personal/herno_o365_sze_hu/EVofDCG_ORZJh--XTVLFsFEBOUYB1eAbHAzdTVDdf19Y9g?download=1 -O jkkds02.zip
```

Make sure you have `unzip` (`sudo apt-get install unzip`) and:

``` bash
unzip jkkds02.zip
``` 

## Some images

![](/img/jkk_dataset_02_2023_07_11-11_12.svg){ width="600" }

![](/img/jkk_dataset_02_2023_07_11-14_02.svg){ width="600" }