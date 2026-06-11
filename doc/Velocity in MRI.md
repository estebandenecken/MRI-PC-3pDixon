# Velocity in MRI

## Phase-contrast MRI
Phase-contrast MRI encodes velocity in the phase of the MRI signal using bipolar pulses in the acquisition.

$f_x$ `phasecontrast(S1,S2,Venc)`: Function that compute phase contrast between two MRI acquisitions with bipolar pulses of opposite polarity.

*Input:*
- `S1` and `S2`:  Signal acquisitions
- `Venc`: Velocity encoding value

*Output:*
- `PC.V`: is the estimated velocity map
- `PC.Ph`: is the measured phase difference

$$S_{-} = M e^{i\left[\phi_0+\phi_V\right]} \qquad
S_{+} = M e^{i\left[\phi_0-\phi_V\right]}$$

$$\angle\left(S_{-} \cdot S_{+}^*\right)  = 2\phi_V$$

$$V = VENC \cdot \frac{\phi_V}{\pi}$$
