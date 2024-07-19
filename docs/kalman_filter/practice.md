---
# icon: material/code-braces-box # gyakorlati tananyag
title: Gyakorlat - Kálmán filter
---

# Gyakorlat



[GitHub :material-github: link](https://github.com/sze-info/Lecture_ADSE/blob/master/02_basics_of_mapping_and_localization/practice/practice_Kalman-Filter-IMU%2BGPS_short.ipynb){: .md-button}



# Import

``` python
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm
%matplotlib inline
plt.rcParams["figure.figsize"] = [16, 9]
plt.rc("xtick", labelsize=20)
plt.rc("ytick", labelsize=20)
```

# Kalman Filter for Constant Acceleration Model

![Kalman Filter Step](https://github.com/sze-info/Lecture_ADSE/raw/master/02_basics_of_mapping_and_localization/practice/resources/Kalman-Filter-Step.png)

## State Vector - Constant Acceleration
Constant Acceleration Model for Ego Motion in Plane

$$x_{k+1} = A \cdot x_{k} + B \cdot u$$



### Newton's Equations of Motion

$$ x = x_0 + v_{x0} * t + \frac{1}{2}a_x * t^2 $$
<br>

$$ y = y_0 + v_{y0} * t + \frac{1}{2}a_y * t^2 $$

### State Transition (no control input)

$$x_{k+1} = \begin{bmatrix}1 & 0 & \Delta t & 0 & \frac{1}{2}\Delta t^2 & 0 \\ 0 & 1 & 0 & \Delta t & 0 & \frac{1}{2}\Delta t^2 \\ 0 & 0 & 1 & 0 & \Delta t & 0 \\ 0 & 0 & 0 & 1 & 0 & \Delta t \\ 0 & 0 & 0 & 0 & 1 & 0  \\ 0 & 0 & 0 & 0 & 0 & 1\end{bmatrix} \cdot \begin{bmatrix} x \\ y \\ \dot x \\ \dot y \\ \ddot x \\ \ddot y\end{bmatrix}_{k}$$

$$y = H \cdot x$$

Acceleration (IMU) and position (GNSS) ($\ddot x$, $\ddot y$, $x$, $y$) sensors are used.

$$y = \begin{bmatrix}0 & 0 & 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 0 & 0 & 1 \\ 1 & 0 & 0 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 & 0 & 0 \end{bmatrix} \cdot x$$

### Initial State
``` python
plt.figure(figsize=(18, 10))
x = np.matrix([[0.0, 0.0, 0.0, 0.0, 0.0, 0.0]]).T
n = x.size  # States
plt.scatter(float(x[0]), float(x[1]), s=100)
plt.title("Initial Location", fontsize=20)
plt.ylabel("y in m", fontsize=20)
plt.xlabel("x in m", fontsize=20)
plt.grid(True)
#### Initial Uncertainty
P = np.matrix(
    [
        [10.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        [0.0, 10.0, 0.0, 0.0, 0.0, 0.0],
        [0.0, 0.0, 10.0, 0.0, 0.0, 0.0],
        [0.0, 0.0, 0.0, 10.0, 0.0, 0.0],
        [0.0, 0.0, 0.0, 0.0, 10.0, 0.0],
        [0.0, 0.0, 0.0, 0.0, 0.0, 10.0],
    ]
)
print(P)

fig = plt.figure(figsize=(6, 6))
im = plt.imshow(P, interpolation="none", cmap=plt.get_cmap("binary"))
plt.title("Initial Covariance Matrix $P$")
ylocs, ylabels = plt.yticks()
# set the locations of the yticks
plt.yticks(np.arange(7))
# set the locations and labels of the yticks
plt.yticks(
    np.arange(6),
    ("$x$", "$y$", "$\dot x$", "$\dot y$", "$\ddot x$", "$\ddot y$"),
    fontsize=22,
)

xlocs, xlabels = plt.xticks()
# set the locations of the yticks
plt.xticks(np.arange(7))
# set the locations and labels of the yticks
plt.xticks(
    np.arange(6),
    ("$x$", "$y$", "$\dot x$", "$\dot y$", "$\ddot x$", "$\ddot y$"),
    fontsize=22,
)

plt.xlim([-0.5, 5.5])
plt.ylim([5.5, -0.5])

from mpl_toolkits.axes_grid1 import make_axes_locatable

divider = make_axes_locatable(plt.gca())
cax = divider.append_axes("right", "5%", pad="3%")
plt.colorbar(im, cax=cax)

plt.tight_layout()
```

## Dynamic Matrix
It is calculated from the dynamics of the Egomotion.

$$x_{k+1} = x_{k} + \dot x_{k} \cdot \Delta t +  \ddot x_k \cdot \frac{1}{2}\Delta t^2$$
<br>

$$y_{k+1} = y_{k} + \dot y_{k} \cdot \Delta t +  \ddot y_k \cdot \frac{1}{2}\Delta t^2$$

$$\dot x_{k+1} = \dot x_{k} + \ddot x \cdot \Delta t$$
<br>

$$\dot y_{k+1} = \dot y_{k} + \ddot y \cdot \Delta t$$

$$\ddot x_{k+1} = \ddot x_{k}$$
<br>

$$\ddot y_{k+1} = \ddot y_{k}$$

``` python
dt = 0.1  # Time Step between Filter Steps

A = np.matrix(
    [
        [1.0, 0.0, dt, 0.0, 1 / 2.0 * dt ** 2, 0.0],
        [0.0, 1.0, 0.0, dt, 0.0, 1 / 2.0 * dt ** 2],
        [0.0, 0.0, 1.0, 0.0, dt, 0.0],
        [0.0, 0.0, 0.0, 1.0, 0.0, dt],
        [0.0, 0.0, 0.0, 0.0, 1.0, 0.0],
        [0.0, 0.0, 0.0, 0.0, 0.0, 1.0],
    ]
)
print(A)
## Measurement Matrix
This matrix determines how the sensor measurements map to the vehicle state. In this example, the position and the accelerations are measured ($x$, $y$, $\ddot x$, $\ddot y$).
H = np.matrix(
    [
        [0.0, 0.0, 0.0, 0.0, 1.0, 0.0],
        [0.0, 0.0, 0.0, 0.0, 0.0, 1.0],
        [1.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        [0.0, 1.0, 0.0, 0.0, 0.0, 0.0],
    ]
)
print(H)
## Measurement Noise Covariance
ra = 10.0 ** 2
rp = 2.0 ** 2

R = np.matrix(
    [[ra, 0.0, 0.0, 0.0], [0.0, ra, 0.0, 0.0], [0.0, 0.0, rp, 0.0], [0.0, 0.0, 0.0, rp]]
)
print(R)
```

## Process Noise Covariance Matrix Q for CA Model
The Position of an object can be influenced by a force (e.g. wind), which leads to an acceleration disturbance (noise). This process noise has to be modeled with the process noise covariance matrix Q.

$$Q = \begin{bmatrix}
    \sigma_{x}^2 & 0 & \sigma_{x \dot x} & 0 & \sigma_{x \ddot x} & 0 \\
    0 & \sigma_{y}^2 & 0 & \sigma_{y \dot y} & 0 & \sigma_{y \ddot y} \\
    \sigma_{\dot x x} & 0 & \sigma_{\dot x}^2 & 0 & \sigma_{\dot x \ddot x} & 0 \\
    0 & \sigma_{\dot y y} & 0 & \sigma_{\dot y}^2 & 0 & \sigma_{\dot y \ddot y} \\
    \sigma_{\ddot x x} & 0 & \sigma_{\ddot x \dot x} & 0 & \sigma_{\ddot x}^2 & 0 \\
    0 & \sigma_{\ddot y y} & 0 & \sigma_{\ddot y \dot y} & 0 & \sigma_{\ddot y}^2
   \end{bmatrix} \cdot \sigma_{j}$$

#### Symbolic Calculation
``` python
from sympy import Symbol, Matrix
from sympy.interactive import printing

dts = Symbol("\Delta t")
sj = 0.1

Q = (
    np.matrix(
        [
            [(dt ** 6) / 36, 0, (dt ** 5) / 12, 0, (dt ** 4) / 6, 0],
            [0, (dt ** 6) / 36, 0, (dt ** 5) / 12, 0, (dt ** 4) / 6],
            [(dt ** 5) / 12, 0, (dt ** 4) / 4, 0, (dt ** 3) / 2, 0],
            [0, (dt ** 5) / 12, 0, (dt ** 4) / 4, 0, (dt ** 3) / 2],
            [(dt ** 4) / 6, 0, (dt ** 3) / 2, 0, (dt ** 2), 0],
            [0, (dt ** 4) / 6, 0, (dt ** 3) / 2, 0, (dt ** 2)],
        ]
    )
    * sj ** 2
)

print(Q)
fig = plt.figure(figsize=(6, 6))
im = plt.imshow(Q, interpolation="none", cmap=plt.get_cmap("binary"))
plt.title("Process Noise Covariance Matrix $Q$")
ylocs, ylabels = plt.yticks()
# set the locations of the yticks
plt.yticks(np.arange(7))
# set the locations and labels of the yticks
plt.yticks(
    np.arange(6),
    ("$x$", "$y$", "$\dot x$", "$\dot y$", "$\ddot x$", "$\ddot y$"),
    fontsize=22,
)

xlocs, xlabels = plt.xticks()
# set the locations of the yticks
plt.xticks(np.arange(7))
# set the locations and labels of the yticks
plt.xticks(
    np.arange(6),
    ("$x$", "$y$", "$\dot x$", "$\dot y$", "$\ddot x$", "$\ddot y$"),
    fontsize=22,
)

plt.xlim([-0.5, 5.5])
plt.ylim([5.5, -0.5])

from mpl_toolkits.axes_grid1 import make_axes_locatable

divider = make_axes_locatable(plt.gca())
cax = divider.append_axes("right", "5%", pad="3%")
plt.colorbar(im, cax=cax)

plt.tight_layout()
## Identity Matrix
I = np.eye(n)
## Measurement
import pandas as pd
from pyproj import Proj

# Read data

# Use every 5th value to get GPS updates in every timestep
n_rows = 10800  # len(df)
skip = np.arange(n_rows)
skip = np.delete(skip, np.arange(0, n_rows, 5))
df = pd.read_csv("data/2014-03-26-000-Data.csv", skiprows=skip)

# Extract values
ax = df["ax"].dropna()
ay = df["ay"].dropna()
px = df["latitude"].dropna()
py = df["longitude"].dropna()

m = len(df["ax"])  # Measurements

# Lat Lon to UTM
utm_converter = Proj(
    "+proj=utm +zone=33U, +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
)

for i in range(len(px)):
    py[i], px[i] = utm_converter(py[i], px[i])
    px[i] = px[i] + np.random.normal(0, 2.0, 1)
    py[i] = py[i] + np.random.normal(0, 2.0, 1)
    # px[i] = 0 #TODO
    # py[i] = 0 #TODO

# Start from position (0 ,0)
py_offset = py[0]
px_offset = px[0]
px = px - px_offset
py = py - py_offset

# Stack measurement vector
measurements = np.vstack((ax, ay, px, py))
fig = plt.figure(figsize=(16, 9))
plt.step(range(m), ax, label="$a_x$")
plt.step(range(m), ay, label="$a_y$")
plt.ylabel("Acceleration in m / $s^2$", fontsize=20)
plt.xlabel("Number of measurements", fontsize=20)
plt.title("IMU Measurements", fontsize=20)
plt.ylim([-20, 20])
plt.legend(loc="best", prop={"size": 18})
fig = plt.figure(figsize=(16, 9))
plt.step(px, py, label="$GNSS$")
plt.xlabel("x in m", fontsize=20)
plt.ylabel("y in m", fontsize=20)
plt.title("GNSS Measurements", fontsize=20)
plt.xlim([min(px), max(px)])
plt.ylim([min(py), max(py)])
plt.legend(loc="best", prop={"size": 18})
# Preallocation for Plotting
xt = []
yt = []
dxt = []
dyt = []
ddxt = []
ddyt = []
Zx = []
Zy = []
Px = []
Py = []
Pdx = []
Pdy = []
Pddx = []
Pddy = []
Kx = []
Ky = []
Kdx = []
Kdy = []
Kddx = []
Kddy = []
```


## Kalman Filter

![Kalman Filter Step](https://github.com/sze-info/Lecture_ADSE/raw/master/02_basics_of_mapping_and_localization/practice/resources/Kalman-Filter-Step.png)
``` python
for n in range(m):

    # Time Update (Prediction)
    # ========================
    # Project the state ahead
    x = A * x

    # Project the error covariance ahead
    P = A * P * A.T + Q

    # Measurement Update (Correction)
    # ===============================
    # Compute the Kalman Gain
    S = H * P * H.T + R
    K = (P * H.T) * np.linalg.pinv(S)

    # Update the estimate via z
    Z = measurements[:, n].reshape(H.shape[0], 1)
    y = Z - (H * x)  # Innovation or Residual
    x = x + (K * y)

    # Update the error covariance
    P = (I - (K * H)) * P

    # Save states for Plotting
    xt.append(float(x[0]))
    yt.append(float(x[1]))
    dxt.append(float(x[2]))
    dyt.append(float(x[3]))
    ddxt.append(float(x[4]))
    ddyt.append(float(x[5]))
    Zx.append(float(Z[0]))
    Zy.append(float(Z[1]))
    Px.append(float(P[0, 0]))
    Py.append(float(P[1, 1]))
    Pdx.append(float(P[2, 2]))
    Pdy.append(float(P[3, 3]))
    Pddx.append(float(P[4, 4]))
    Pddy.append(float(P[5, 5]))
    Kx.append(float(K[0, 0]))
    Ky.append(float(K[1, 0]))
    Kdx.append(float(K[2, 0]))
    Kdy.append(float(K[3, 0]))
    Kddx.append(float(K[4, 0]))
    Kddy.append(float(K[5, 0]))
## Plots
### Covariance Matrix
fig = plt.figure(figsize=(6, 6))
im = plt.imshow(P, interpolation="none", cmap=plt.get_cmap("binary"))
plt.title("Covariance Matrix $P$ (after %i Filter Steps)" % (m), fontsize=20)
ylocs, ylabels = plt.yticks()
# set the locations of the yticks
plt.yticks(np.arange(7))
# set the locations and labels of the yticks
plt.yticks(
    np.arange(6),
    ("$x$", "$y$", "$\dot x$", "$\dot y$", "$\ddot x$", "$\ddot y$"),
    fontsize=22,
)

xlocs, xlabels = plt.xticks()
# set the locations of the yticks
plt.xticks(np.arange(7))
# set the locations and labels of the yticks
plt.xticks(
    np.arange(6),
    ("$x$", "$y$", "$\dot x$", "$\dot y$", "$\ddot x$", "$\ddot y$"),
    fontsize=22,
)

plt.xlim([-0.5, 5.5])
plt.ylim([5.5, -0.5])

from mpl_toolkits.axes_grid1 import make_axes_locatable

divider = make_axes_locatable(plt.gca())
cax = divider.append_axes("right", "5%", pad="3%")
plt.colorbar(im, cax=cax)


plt.tight_layout()
## State Vector
fig = plt.figure(figsize=(16, 12))

plt.subplot(311)
plt.step(range(len(measurements[0])), ddxt, label="$\ddot x$")
plt.step(range(len(measurements[0])), ddyt, label="$\ddot y$")

plt.title("Estimate (Elements from State Vector $x$)", fontsize=20)
plt.legend(loc="best", prop={"size": 22})
plt.ylabel("Acceleration in m/ $s^2$", fontsize=20)

plt.subplot(312)
plt.step(range(len(measurements[0])), dxt, label="$\dot x$")
plt.step(range(len(measurements[0])), dyt, label="$\dot y$")

plt.ylabel("")
plt.legend(loc="best", prop={"size": 22})
plt.ylabel("Velocity in m/s", fontsize=20)

plt.subplot(313)
plt.step(range(len(measurements[0])), xt, label="$x$")
plt.step(range(len(measurements[0])), yt, label="$y$")

plt.xlabel("Filter Step", fontsize=20)
plt.ylabel("Position in m", fontsize=20)
plt.legend(loc="best", prop={"size": 22})
## Position x/y
fig = plt.figure(figsize=(16, 9))

plt.step(px, py, label="$GNSS$")

plt.scatter(xt[0], yt[0], s=100, label="Start", c="g")
plt.scatter(xt[-1], yt[-1], s=100, label="Goal", c="r")
plt.plot(xt, yt, label="State", alpha=0.5)
plt.xlabel("x in m", fontsize=20)
plt.ylabel("y in m", fontsize=20)
plt.title("Position", fontsize=20)
plt.legend(loc="best", fontsize=20)
plt.xlim(min(xt), max(xt))
plt.ylim(min(yt), max(yt))
```