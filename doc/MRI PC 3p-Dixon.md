# MRI PC 3p-Dixon

## Phase-aware Three-point Dixon Water-Fat Separation

$f_x$ `Dixon(Sn,tn,typ)`: Function that performs Three-point Dixon Water-Fat separation in an MRI acquisition preserving the phase information.

*Input:*
- `Sn`: Signal acquisition
- `tn`: Echo times $[s]$
- `typ`: Three-point Dixon type `"IOI"` or `"OIO"`

*Output:*
- `Mw` and `Mf`: Water and Fat images respectively
- `Phi`: Estimated Field Map $[Hz]$

We introduced a new formulation of the Dixon method aware of the phase information of water and fat components. We used the complex voxel-wise model of the signal $S_n$ at the echo time $t_n$ defined in the following equation, where $\rho_W$ and $\rho_F$ are the complex values of water and fat components of the signal, $\Delta f$ is the known chemical shift between water and fat, and $\Delta B$ represents the $B_0$ inhomogeneities.

$$S_n = \left(\rho_W + \rho_F e^{i2\pi\Delta f t_n}\right) e^{-i\gamma\Delta B t_n}$$

We considered water and fat components as complex values, i.e., composed by magnitude ($M_W$ and $M_F$) and phase ($\phi_W$ and $\phi_F$). Therefore, we can represent $\rho_W=M_W e^{i\phi_W}$ and $\rho_F=M_F e^{i\phi_F}$, then, the MRI signal in each voxel can be described as:

$$S_n = \left(M_W e^{i\phi_W} + M_F e^{i\left[\phi_F + 2\pi\Delta f t_n\right]}\right) e^{-i\gamma\Delta B t_n}$$

The 3p-Dixon equations representing the multi-echo acquisition IP-OP-IP assuming a single peak fat model are:

$$S_{ip,1} = \left(M_W e^{i\phi_W} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip,1}}$$

$$S_{op} = \left(M_W e^{i\phi_W} - M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{op}}$$

$$S_{ip,2} = \left(M_W e^{i\phi_W} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip,2}}

In equations $S_{ip,1}$ and $S_{ip,2}$, the exponential with the chemical shift $e^{i2\pi\Delta f t_{ip}}=1$, and in equation $S_{op}$, the exponential $e^{i2\pi\Delta f t_{op}}=-1$. We estimated $\Delta B$ by considering the two IP acquisitions as follows,

$$-\gamma\Delta B = \frac{\angle\left(S_{ip,1}^* \cdot S_{ip,2}\right)}{t_{ip,2} - t_{ip,1}}$$

where $S_{ip,1}^*$ represents the conjugate of $S_{ip,1}$. Then, we obtained the phase-aware water and fat components by adding and subtracting the IP and OP images.

$$\rho_W = M_W e^{i\phi_W} = \frac{1}{2} \left(S_{ip,1}e^{i\gamma\Delta B t_{ip,1}} + S_{op}e^{i\gamma\Delta B t_{op}}\right)$$

$$\rho_F = M_F e^{i\phi_F} = \frac{1}{2} \left(S_{ip,1}e^{i\gamma\Delta B t_{ip,1}} - S_{op}e^{i\gamma\Delta B t_{op}}\right)$$

The resulting water and fat components preserve the phase information of each element. 

In a similar way, we can apply the phase-preserving 3p-Dixon method in an OP-IP-OP acquisition. In this acquisition, we estimated the field inhomogeneities by considering two OP acquisitions. After computing the water and fat components using the corrected IP and OP images, we obtained water and fat components.


## PC 3p-Dixon method

The PC 3p-Dixon method assumes that only the water component has velocity information, and it is encoded in the signal phase and characterized by $\phi_V$. The new complex voxel-wise signal model can be defined by:

$$S_n = \left(\rho_W e^{i\phi_V} + \rho_F e^{i2\pi\Delta f t_n}\right) e^{-i\gamma\Delta B t_n}$$

PC 3p-Dixon requires obtaining two 3p-Dixon acquisitions with bipolar gradients of opposite polarity before the multi-echo sequence. For bipolar gradient of positive polarity at IP and OP echo times, we can define:

$$S_{ip}^+ = \left(M_W e^{i\left[\phi_W + \phi_V\right]} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip}}$$

$$S_{op}^+ = \left(M_W e^{i\left[\phi_W + \phi_V\right]} - M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{op}}$$

Analogously, for negative polarity:

$$S_{ip}^- = \left(M_W e^{i\left[\phi_W - \phi_V\right]} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip}}$$

$$S_{op}^- = \left(M_W e^{i\left[\phi_W - \phi_V\right]} - M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{op}}$$

The resulting water and fat components computed from the 3p-Dixon acquisitions with bipolar gradients of negative and positive polarity are defined as follows:

$$\rho_{W-} = M_W e^{i\left[\phi_W - \phi_V\right]} \qquad , \qquad \rho_{F-} = M_W e^{i\phi_F}$$

$$\rho_{W+} = M_W e^{i\left[\phi_W + \phi_V\right]} \qquad , \qquad \rho_{F+} = M_W e^{i\phi_F}$$

The resulting water and fat components in both acquisitions preserve the phase information of each chemical species. Notice that both water components have the phase terms of velocity with opposite signs. Therefore, we can perform a conventional 2D PC-MRI combining $\rho_ {W-}$ and $\rho_ {W+}$, and considering the user-defined VENC, the velocity can be computed as follows:

$$\left(\rho_{W-} \cdot \rho_{W+}^*\right) = \rho_W^2 e^{i\left[\phi_W + \phi_V\right]} e^{-i\left[\phi_W - \phi_V\right]}$$

$$\phi_V = \frac{\angle\left(\rho_{W-} \cdot \rho_{W+}^*\right)}{2}$$

$$V = \text{VENC} \cdot \frac{2\phi_V}{\pi}$$

To improve the SNR in water and fat component images, we averaged the magnitudes of the water and fat images:

$$\rho_W = \frac{|\rho_{W-}|+|\rho_{W+}|}{2}$$

$$\rho_F = \frac{|\rho_{F-}|+|\rho_{F+}|}{2}$$

We obtained identical equations using the proposed PC 3p-Dixon method for Dixon acquisitions IP-OP-IP and OP-IP-OP.
