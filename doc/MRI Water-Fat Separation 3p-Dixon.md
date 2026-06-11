# MRI Water-Fat Separation 3p-Dixon

## Three-point Dixon Water-Fat Separation (Haacke 2014)

$f_x$ `DixonH(Sn,tn,typ)`: Function that performs Three-point Dixon Water-Fat separation in an MRI acquisition (Haacke 2014)

*Input:*
- `Sn`: the signal acquisition
- `tn`: Echo times $[s]$
- `typ`: Three-point Dixon type `"IOI"` or `"OIO"`

*Output:*
- `Mw` and `Mf`: Water and Fat images respectively
- `Phi`: Estimated Field Map $[Hz]$

The Three-point Dixon (Haacke 2014) MRI signal in each voxel can be described as shown in the equation:

$$S_n = \left(M_W e^{i\phi_W} + M_F e^{i\left[\phi_F + 2\pi\Delta f t_n\right]}\right) e^{-i\gamma\Delta B t_n + i\phi_0}$$

The 3p-Dixon equations representing the multi-echo acquisition IP-OP-IP assuming a single peak fat model are:

$$S_{ip,1} = \left(M_W e^{i\phi_W} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip,1}} e^{-i\phi_0}$$

$$S_{op} = \left(M_W e^{i\phi_W} - M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{op}} e^{-i\phi_0}$$

$$S_{ip,2} = \left(M_W e^{i\phi_W} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip,2}} e^{-i\phi_0}$$

In equations $S_{ip,1}$ and $S_{ip,2}$, the exponential with the chemical shift $e^{i2\pi\Delta f t_{ip}}=1$, and in equation$S_{op}$, the exponential $e^{i2\pi\Delta f t_{op}}=-1$. $\Delta B$ and $\phi_0$ are estimated by considering the two IP acquisitions as follows,

$$-\gamma\Delta B = \frac{\angle\left(S_{ip,1}^* \cdot S_{ip,2}\right)}{t_{ip,2} - t_{ip,1}}$$

$$\phi_0 = \angle\left(S_{ip,1}\right) + \gamma\Delta B t_{ip,1}$$

where $S_{ip,1}^*$ represents the conjugate of $S_{ip,1}$. Then, the in-phase signal $S_{ip}$ and opposed-phase signal $S_{op}$ are corrected by removing the estimated phase terms as follows,

$$S_{ip} = \frac{1}{2} \left(\left|S_{ip,1}\right| + \left|S_{ip,2}\right|\right)$$

$$S_{op} = S_{op} e^{i\left(\gamma\Delta B t_{op} + \phi_0\right)} 
$$

Finally, water and fat components are obtained by adding and subtracting the corrected IP and OP images.

$$M_W = \frac{1}{2} \left|S_{ip} + S_{op} \right|$$

$$M_F = \frac{1}{2} \left|S_{ip} - S_{op} \right|$$


## Dixon Water-Fat Separation

$f_x$ `DixonP(Sn,tn,alg,typ)`: Function that performs Two-point or Three-point Dixon Water-Fat separation in an MRI acquisition preserving the phase information

*Input:*
- `Sn`: Signal acquisition
- `tn`: Echo times $[s]$
- `alg`: Dixon algorithm. `alg` is set to `"two"` for Two-point Dixon, `"three"` for phase-aware Three-point Dixon, `"haacke"` for Haacke 2014 Three-point Dixon, or `"pauly"` for Pauly 2007 Three-point Dixon.
- `typ`: Three-point Dixon type `"IOI"` or `"OIO"`

*Output:*
- `Mw` and `Mf`: Water and Fat images respectively
- `Phi`: Estimated Field Map $[Hz]$
- `Phi0`: Initial Field Map $[Hz]$

The Two-point Dixon MRI signal in each voxel can be described as:

$$S_n = M_W e^{i\phi_W} + M_F e^{i\left[\phi_F + 2\pi\Delta f t_n\right]}$$

The Two-point Dixon equations representing the multi-echo acquisition assuming a single peak fat model are:

$$S_{ip} = M_W e^{i\phi_W} + M_F e^{i\phi_F}$$

$$S_{op} = M_W e^{i\phi_W} - M_F e^{i\phi_F}$$

Water and fat components are obtained by adding and subtracting the acquired IP and OP images.

$$M_W = \frac{1}{2} \left|S_{ip} + S_{op} \right|$$

$$M_F = \frac{1}{2} \left|S_{ip} - S_{op} \right|$$

The Three-point Dixon (Pauly 2007) MRI signal in each voxel and the 3p-Dixon equations representing the multi-echo acquisition are analogous to Three-point Dixon (Haacke 2014).

$$S_n = \left(M_W e^{i\phi_W} + M_F e^{i\left[\phi_F + 2\pi\Delta f t_n\right]}\right) e^{-i\gamma\Delta B t_n + i\phi_0}$$

The 3p-Dixon equations representing the multi-echo acquisition IP-OP-IP:

$$S_{ip,1} = \left(M_W e^{i\phi_W} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip,1}} e^{-i\phi_0}$$

$$S_{op} = \left(M_W e^{i\phi_W} - M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{op}} e^{-i\phi_0}$$

$$S_{ip,2} = \left(M_W e^{i\phi_W} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip,2}} e^{-i\phi_0}$$

$\Delta B$ and $\phi_0$ are estimated by considering the two IP acquisitions as follows,

$$-\gamma\Delta B = \frac{\angle\left(S_{ip,1}^* \cdot S_{ip,2}\right)}{2}$$

$$\phi_0 = \angle\left(S_{ip,1}\right)$$

Water and fat components are obtained by adding and subtracting the corrected IP and OP images.

$$M_W = \frac{1}{2} \left(S_{ip} + S_{op} e^{i\gamma\Delta B -i\phi_0} \right)$$

$$M_F = \frac{1}{2} \left(S_{ip} - S_{op} e^{i\gamma\Delta B -i\phi_0} \right)$$
