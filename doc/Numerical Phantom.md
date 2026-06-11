# Phantoms MRI Water Fat Velocity

## Numerical Phantoms
$f_x$ `PCMEPhantom(tn1,tn2,bip,NSD,ki,dim,mpk)`
$f_x$ `PCMEPhantomV(tn1,tn2,bip,NSD,ki,dim,mpk)`

Codes that generates a simulation of an MRI signal.

*Input:*
- `tn1`, `tn2`: Echo times 
- `bip`: Bipolar pulse (yes / no = 1 / 0)
- `NSD`: Standard Deviation of Noise
- `ki`: Phantom options (T2* and noise)
- `dim`: Dimension of the 2D square image
- `mpk`: Multi-peak / Single-peak = 1 / 0

*Output:*
- `PH`: Structure that contains echo times, simulated MRI signal, propereties of water, fat, velocity, field map and T2* of the simulation

The signal model shown in the equation was used to build the phantoms, with $t_n$ denoting the echo times, $M_W$ and $M_F$ water and fat components, $\phi_W$ and $\phi_F$ uniform randomly distributed initial phases, $\phi_V$ the phase of velocity information, $\Delta f_k$ the chemical shift components of fat, $\alpha_k$ the multipliers of the multi-peak model of fat, $k$ the summation index, and $\Delta B$ the field inhomogeneities. This numerical phantom considered T2* decay with values between 10 ms and 200 ms, and customizable additive complex Gaussian noise $N=N_R+iN_I$ to perform more realistic simulations.
$$
S_n = \left(M_W  e^{i\left[ \phi_{W} + \phi_{V} \right]} + M_F e^{i\phi_{F}} \sum_k \alpha_k e^{i2\pi \Delta f_{k} t_n}\right) e^{-i\gamma \Delta B t_n} e^{-t_n/T_2^*} + N \qquad \sum_k \alpha_k = 1
$$