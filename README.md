# MRI PC 3p-Dixon

*Numerical Simulations, MATLAB code*

> **Simultaneous acquisition of water, fat and velocity images using a Phase-contrast 3p-Dixon method**
> Esteban Denecken, Cristóbal Arrieta, Diego Hernando, Julio Sotelo, Hernán Mella, and Sergio Uribe

---

## Overview

This repository contains the numerical simulation for the **PC 3p-Dixon** method, a novel MRI technique that simultaneously acquires water, fat, and velocity images in a single scan. The method combines 2D Phase-Contrast MRI (PC-MRI) with a modified 3-point Dixon water-fat separation technique, using a Phase-Contrast Multi-Echo (PCME-MRI) acquisition with bipolar gradients of opposing polarity.

The key idea is that both velocity (PC-MRI) and chemical shift (Dixon) encode information in the *phase* of the MR signal. By designing a phase-aware Dixon formulation that preserves the phase of water and fat components, velocity images can be derived from the resulting water components using standard PC-MRI post-processing.

---

## Method Summary

The PC 3p-Dixon acquisition consists of two 3-point Dixon acquisitions with bipolar gradients of **positive** and **negative** polarity. The MR signal model is:

$$S_n = \left(\rho_W e^{i\phi_V} + \rho_F e^{i2\pi\Delta f t_n}\right) e^{-i\gamma\Delta B t_n}$$

where $\rho_W$ and $\rho_F$ are the complex water and fat components, $\phi_V$ is the velocity-encoded phase, $\Delta f$ is the water-fat chemical shift, and $\Delta B$ represents $B_0$ field inhomogeneities.

The reconstruction pipeline:
1. Apply the **phase-aware 3p-Dixon** method to each polarity acquisition separately, obtaining $\rho_{W+}$, $\rho_{W-}$, $\rho_{F+}$, $\rho_{F-}$.
2. Average water and fat magnitudes across polarities to improve SNR.
3. Compute velocity from the phase difference of the two water components:

$$\phi_V = \frac{\angle(\rho_{W-} \cdot \rho_{W+}^*)}{2}, \qquad V = \text{VENC} \cdot \frac{2\phi_V}{\pi}$$

Two Dixon acquisition schemes are supported: **IP-OP-IP** (echo times 4.6, 6.9, 9.2 ms) and **OP-IP-OP** (echo times 2.3, 4.6, 6.9 ms).

![PC 3p-Dixon method](<doc/figures/Fig 1 PC 3p-Dixon method.png>)

---

## Numerical in-silico phantom

*Signal Model*

$$S_n = \left(M_W  e^{i\left[ \phi_{W} + \phi_{V} \right]} + M_F e^{i\phi_{F}} \sum_k \alpha_k e^{i2\pi \Delta f_{k} t_n}\right) e^{-i\gamma \Delta B t_n} e^{-t_n/T_2^*} + N \qquad \sum_k \alpha_k = 1$$

We tested the PC 3p-Dixon IP-OP-IP and OP-IP-OP in a numerical phantom of 13 vials with different water-fat components from 0 to 1 of fat fraction. Additionally, we included three vials with 100\% water concentration and uniform water velocity, two of them with 80 cm/s and another one with 40 cm/s of velocity. A gradient field of inhomogeneities varying from $-$70 to 70 Hz along the phantom was also included. 

The signal model used to build the phantom, with $t_n$ denoting the echo times, $M_W$ and $M_F$ water and fat components, $\phi_W$ and $\phi_F$ uniform randomly distributed initial phases, $\phi_V$ the phase of velocity information, $\Delta f_k$ the chemical shift components of fat, $\alpha_k$ the multipliers of the multi-peak model of fat, $k$ the summation index, and $\Delta B$ the field inhomogeneities. 

This numerical phantom considered T2* decay with values between 10 ms and 200 ms, and customizable additive complex Gaussian noise $N=N_R+iN_I$ to perform more realistic simulations. Although the PC 3p-Dixon method used in the signal fitting process did not consider T2* decay or a multi-peak model of fat, we did consider these components to generate the simulated MR signal.

Random Gaussian noise values with zero mean and SD of 7.5\% (SNR$=$13.3) were added to the phantom. We tested the sensitivity to noise by performing 20 different phantom simulations using different SD for the Gaussian noise ranging from 0\% to 23.5\%.

![Numerical Phantom](<doc/figures/Fig 3 Numerical phantom.png>)

### PC 3p-Dixon IP-OP-IP

![PC 3p-Dixon IOI](<doc/figures/Fig 4 PC 3p-Dixon IOI.png>)

### PC 3p-Dixon OP-IP-OP

![PC 3p-Dixon OIO](<doc/figures/Fig 5 PC 3p-Dixon OIO.png>)

---

## How to use

To perform a standard numerical simulation, use the primary script:

`PC_3pDixon.m`

To perform a numerical simulation with velocity in all vials, use the primary script:

 `PC_3pDixon_vel.m `

---

## Requirements

- MATLAB (last tested in R2025a)
- Image Processing Toolbox
- No additional toolboxes are required for core simulations

---

## Paper Citation

```
Denecken, E., Arrieta, C., Hernando, D., Sotelo, J., Mella, H., & Uribe, S. (2025). Simultaneous acquisition of water, fat and velocity images using a phase-contrast 3p-Dixon method. Magnetic Resonance Imaging, 110341. 
https://doi.org/10.1016/j.mri.2025.110341
```

---
