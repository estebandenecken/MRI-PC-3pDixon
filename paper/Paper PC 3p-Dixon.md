# Simultaneous acquisition of water, fat and velocity images using a Phase-contrast 3p-Dixon method

*Esteban Denecken*$^{1,2}$, *Cristóbal Arrieta*$^{3}$, *Diego Hernando*$^{4}$, *Julio Sotelo*$^{5}$, *Hernán Mella*$^{6}$ *and Sergio Uribe*$^{1,7}$

1. Biomedical Imaging Center, Pontificia Universidad Católica de Chile, Santiago, Chile.
2. Department of Electrical Engineering, Pontificia Universidad Católica de Chile, Santiago, Chile.
3. Faculty of Engineering, Universidad Alberto Hurtado, Santiago, Chile.
4. Departments of Radiology and Medical Physics, University of Wisconsin-Madison, Wisconsin Institutes for Medical Research, Madison, WI, USA.
5. Departamento de Informática, Universidad Técnica Federico Santa María, Santiago , Chile.
6. School of Electrical Engineering, Pontificia Universidad Católica de Valparaíso, Valparaíso, Chile.
7. Department of Medical Imaging and Radiation Sciences, School of Primary and Allied Health Care / Faculty of Medicine, Nursing and Health Sciences. Monash University, Melbourne, Australia.


## Abstract

**Purpose:** Phase-contrast MRI (2D PC-MRI) and Dixon techniques share the characteristic that the difference in frequency between water and fat, as well as the velocity, are encoded in the phase of the MR signal. We propose to take advantage of this characteristic to obtain both sets of images simultaneously. Such an acquisition will improve efficiency by obtaining both types of images in the same scan and will provide co-registered images of water-fat species and velocity images. This, in turn, will correct fat artifacts due to chemical shift in PC-MRI based measurements.

**Methods:** This study presents a novel PC multi-echo (PCME-MRI) sequence jointly with a 3-point (3p-) Dixon pipeline that enables reconstruction of water, fat, and velocity images simultaneously. The proposed 3p-Dixon approach preserves the phase information of water-fat images, while velocity images are obtained from the resulting water components.

**Results:** Numerical phantom tests and 2D MR axial images of the neck acquired in 12 healthy volunteers demonstrated the feasibility of the PC 3p-Dixon method, showing comparable performance to standard techniques. In volunteers the median and range MAE comparing PC 3p-Dixon, and standard 3p-Dixon fat fraction were 0.06 and [0.03, 0.09]. The median and range of velocity for PC 3p-Dixon were 6.15 ml and [3.86, 7.21]ml, compared to 6.43 ml and [4.62, 8.27]ml obtained by 2D PC-MRI.

**Conclusion:** Numerical phantom experiments and acquisitions from healthy volunteers showed promising results in fat fraction and velocity estimation of PC 3p-Dixon compared with standard 3p-Dixon and 2D PC-MRI, obtaining both data sets in similar times as standard 3p Dixon.


## Introduction

Phase-contrast MRI (2D PC-MRI) is a non-invasive technique that provides accurate quantitative information about blood flow [1, 2]. 2D PC-MRI can be used to determine abnormal flow dynamics [2, 3] and calculate relevant hemodynamic parameters [4-7]. 2D PC-MRI requires acquisitions with bipolar gradients that induce a velocity-dependent phase on the MR signal [1].

On the other hand, multi-point Dixon methods are chemical shift encoding techniques used to separate water and fat signals, achieving fat suppression and quantification [8-12]. The difference in resonance frequency between water and fat introduce changes in the phase of the MR signal that can be used by post-processing methods to isolate water and fat components from the MR signal [13-18].

The intrinsic phase changes produced by fat in the image phase can bias 2D PC-MRI measurements, especially in regions with significant fat content due to chemical shift artifacts [19, 20]. This can occur in hepatic vasculature, coronary arteries, carotids, and the venous system [19, 21]. Therefore, it would be ideal to obtain a set of images in which velocity, water, and fat content could be obtained simultaneously. This can be done, for instance, by combining 2D PC-MRI with Dixon techniques. Such an acquisition would improve efficiency by obtaining both types of images in the same scan, providing co-registered images of water-fat components and velocity images, and offering chemical shift artifact-free 2D PC-MRI flow measurements. These simultaneous measurements would be beneficial for diagnosing diseases such as Metabolic Dysfunction Associated Steatotic Liver Disease (MASLD) [13, 17], diabetes [18], and cardiac steatosis [14, 16], where fat and flow quantification is sometimes required. Nevertheless, the simultaneous acquisition of Dixon and 2D PC-MRI data is challenging.

Multi-point Dixon methods typically focus on obtaining the magnitude of water and fat components to maximize the SNR [10-12]. Although some works have addressed the issue of the phase of fat and water [22], Dixon methods usually neglect the phase information. Hence, combining Dixon methods and PC can be difficult due to the phase is usually not used in signal modeling and usually not saved into DICOMs by the vendor protocol.

Johnson et al. [21] proposed a chemical shift and radial dual-echo sequence to simultaneously obtain water, fat and velocity imaging. This technique recovers velocity images of water (blood) corrected for the influence of fat. While this method employs a non-linear reconstruction algorithm that can require additional computational time, their results were promising. To our knowledge, no other works have attempted to simultaneously obtain water-fat and velocity images.

This work introduces a novel method that combines 2D PC-MRI and a modified 3-point (3p-) Dixon technique to obtain velocity images and water-fat components in a single acquisition. This acquisition, based on a phase-contrast multi-echo (PCME-MRI) approach, combines two 3p-Dixon acquisitions with bipolar gradients of opposed polarity before the readouts to encode blood flow velocity. This PCME-MRI acquisition allows straightforward algebraic post-processing. Our novel 3p-Dixon method preserves the phase information in water and fat, and the components are obtained with algebraic operations similar to the original Dixon method. The water phase information obtained from Dixon data, acquired with positive and negative polarity, is then used to compute the 2D PC-MRI.


## Methods

### Phase-aware 3p-Dixon method

This study considered the standard Dixon acquisition in-phase (IP) and opposed-phase (OP), acquiring image sequences IP-OP-IP and OP-IP-OP. Three-point acquisitions with optimized Echo Times (TEs) as proposed by Pineda et al. [23] are out of the scope of this research.

To combine 2D PC-MRI and 3p-Dixon methods, we introduced a new formulation of the Dixon method aware of the phase information of water and fat components. Instead of considering water and fat magnitudes, which is the classical Dixon model [9-12, 19, 24], we used the complex voxel-wise model of the signal $S_n$ at the echo time $t_n$ defined in Eq. (1), where $\rho_W$ and $\rho_F$ are the complex values of water and fat components of the signal, $\Delta f$ is the known chemical shift between water and fat, and $\Delta B$ represents the $B_0$ (inhomogeneities)

$$S_n = \left(\rho_W + \rho_F e^{i2\pi\Delta f t_n}\right) e^{-i\gamma\Delta B t_n} \quad\quad \text{Eq. 1}$$

Full description of the method is given in Appendix A. 

We considered water and fat components as complex values, i.e., composed by magnitude ($M_W$ and $M_F$) and phase ($\phi_W$ and $\phi_F$). Therefore, we can represent $\rho_W=M_W e^{i\phi_W}$ and $\rho_F=M_F e^{i\phi_F}$.
 
By adding and subtracting the IP and OP images, we obtained the phase-aware water and fat components:

$$\rho_W = M_W e^{i\phi_W} = \frac{1}{2} \left(S_{ip,1}e^{i\gamma\Delta B t_{ip,1}} + S_{op}e^{i\gamma\Delta B t_{op}}\right) \quad\quad \text{Eq. 2a}$$

$$\rho_F = M_F e^{i\phi_F} = \frac{1}{2} \left(S_{ip,1}e^{i\gamma\Delta B t_{ip,1}} - S_{op}e^{i\gamma\Delta B t_{op}}\right) \quad\quad \text{Eq. 2b}$$

### Phase-contrast 3p-Dixon method

The proposed method assumes that only the water component has velocity information, and it is encoded in the signal phase and characterized by $\phi_V$. The new complex voxel-wise signal model can be defined by Eq. (3),

$$S_n = \left(\rho_W e^{i\phi_V} + \rho_F e^{i2\pi\Delta f t_n}\right) e^{-i\gamma\Delta B t_n} \quad\quad \text{Eq. 3}$$

The proposed PC 3p-Dixon method, summarized in Fig. 1}, requires obtaining two 3p-Dixon acquisitions with bipolar gradients of opposite polarity before the multi-echo sequence. For bipolar gradient of positive polarity at IP and OP echo times, we can define:

$$S_{ip}^+ = \left(M_W e^{i\left[\phi_W + \phi_V\right]} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip}} \quad\quad \text{Eq. 4a}$$

$$S_{op}^+ = \left(M_W e^{i\left[\phi_W + \phi_V\right]} - M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{op}} \quad\quad \text{Eq. 4b}$$

Analogously, for negative polarity:

$$S_{ip}^- = \left(M_W e^{i\left[\phi_W - \phi_V\right]} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip}} \quad\quad \text{Eq. 5a}$$

$$S_{op}^- = \left(M_W e^{i\left[\phi_W - \phi_V\right]} - M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{op}} \quad\quad \text{Eq. 5b}$$

The resulting water and fat components computed from the 3p-Dixon acquisitions with bipolar gradients of negative and positive polarity are defined as follows:

$$\rho_{W-} = M_W e^{i\left[\phi_W - \phi_V\right]} \qquad , \qquad \rho_{F-} = M_W e^{i\phi_F} \quad\quad \text{Eq. 6a}$$

$$\rho_{W+} = M_W e^{i\left[\phi_W + \phi_V\right]} \qquad , \qquad \rho_{F+} = M_W e^{i\phi_F} \quad\quad \text{Eq. 6b}$$

The resulting water and fat components in both acquisitions preserve the phase information of each chemical species. Notice that both water components have the phase terms of velocity with opposite signs. Therefore, we can perform a conventional 2D PC-MRI combining $\rho_ {W-}$ and $\rho_ {W+}$, and considering the user-defined VENC, the velocity can be computed using Eq. (7), as follows:

$$\left(\rho_{W-} \cdot \rho_{W+}^*\right) = \rho_W^2 e^{i\left[\phi_W + \phi_V\right]} e^{-i\left[\phi_W - \phi_V\right]} \quad\quad \text{Eq. 7a}$$

$$\phi_V = \frac{\angle\left(\rho_{W-} \cdot \rho_{W+}^*\right)}{2} \quad\quad \text{Eq. 7b}$$

$$V = \text{VENC} \cdot \frac{2\phi_V}{\pi} \quad\quad \text{Eq. 7c}$$

To improve the SNR in water and fat component images, we averaged the magnitudes of the water and fat images:

$$\rho_W = \frac{|\rho_{W-}|+|\rho_{W+}|}{2} \quad\quad \text{Eq. 8a}$$

$$\rho_F = \frac{|\rho_{F-}|+|\rho_{F+}|}{2} \quad\quad \text{Eq. 8b}$$

We obtained identical equations using the proposed PC 3p-Dixon method for Dixon acquisitions IP-OP-IP and OP-IP-OP.

![Fig1](<Fig_PC_3pDixon/Fig1.png>)

Figure 1: Diagram of PC 3p-Dixon method. We acquired two Dixon acquisitions with bipolar gradients of opposite polarities. Then, we separated the water and fat components of each acquisition. Subsequently, we averaged the magnitudes of the two water components and the two fat components to obtain water and fat components. Finally, using the two water components we used Phase-contrast (PC) to estimate the velocity images.


## Experiments

### Numerical simulation experiments

#### Impact of fat on velocity measurement

Similar to Johnson et al. [21], we tested velocity measurements in the presence of static fat using Monte Carlo simulations in PC 3p-Dixon IP-OP-IP and OP-IP-OP, and 2D PC-MRI. We performed 16 single pixel simulations using 16 different fat fraction values evenly spaced between 0 and 0.5. We conducted 160,000 realizations for each simulation. In each simulation we performed 10,000 realizations for each of the 16 distinct velocity values evenly spaced between 0 cm/s and 100 cm/s, and the velocity encoding (VENC) was set at 100 cm/s. For each realization, we assigned random values of $\Delta B$ using a uniform distribution, ranging from -1.65 parts per million (ppm) to 1.65 ppm. We compared Monte Carlo simulations of PC 3p-Dixon using a single-peak fat model and without considering T2* decay, with simulations using a multi-peak model and considering T2* decay with values between 10 and 200 ms [25]. We also compared simulations using SNRs of 100 and 20. We computed the SNR as the magnitude of the signal divided by the standard deviation of Gaussian noise.

We estimated the water and fat fractions and velocity of the pixel using the proposed PC 3p-Dixon method. The simulation results were evaluated for velocity bias relative to the ground truth.

Additionally, using the same parameters of previous Monte Carlo simulations, we performed 16 single-pixel simulations using 16 different velocity values evenly spaced between 0 cm/s and 100 cm/s, the VENC was set at 100 cm/s. In each simulation we performed 10,000 realizations for each of the 16 distinct fat fractions values evenly spaced from 0 to 1. The simulation results were evaluated by computing the velocity-to-noise ratio (VNR). We computed the VNR as shown in Eq. (9) [26].

$$\text{VNR} = \frac{\pi}{\sqrt{2}} \cdot \frac{V}{\text{VENC}} \cdot \text{SNR} \quad\quad \text{Eq. 9}$$

#### Numerical in-silico phantom

To test the methodology in a synthetic image, we tested the PC 3p-Dixon IP-OP-IP and OP-IP-OP in a numerical phantom of 13 vials with different water-fat components from 0 to 1 of fat fraction. Additionally, we included three vials with 100\% water concentration and uniform water velocity, two of them with 80 cm/s and another one with 40 cm/s of velocity. A gradient field of inhomogeneities varying from -70 to 70 Hz along the phantom was also included. Eq. (10) shows the signal model used to build the phantom, with $t_n$ denoting the echo times, $M_W$ and $M_F$ water and fat components, $\phi_W$ and $\phi_F$ uniform randomly distributed initial phases, $\phi_V$ the phase of velocity information, $\Delta f_k$ the chemical shift components of fat, $\alpha_k$ the multipliers of the multi-peak model of fat [27-29], $k$ the summation index, and $\Delta B$ the field inhomogeneities. This numerical phantom considered T2* decay with values between 10 ms and 200 ms, and customizable additive complex Gaussian noise $N=N_R+iN_I$ to perform more realistic simulations. Although the PC 3p-Dixon method used in the signal fitting process did not consider T2* decay or a multi-peak model of fat, we did consider these components to generate the simulated MR signal.

$$S_n = \left(M_W  e^{i\left[ \phi_{W} + \phi_{V} \right]} + M_F e^{i\phi_{F}} \sum_k \alpha_k e^{i2\pi \Delta f_{k} t_n}\right) e^{-i\gamma \Delta B t_n} e^{-t_n/T_2^*} + N \qquad \sum_k \alpha_k = 1 \quad\quad \text{Eq. 10}$$

Random Gaussian noise values with zero mean and SD of 7.5\% (SNR$=$13.3) were added to the phantom. We tested the sensitivity to noise by performing 20 different phantom simulations using different SD for the Gaussian noise ranging from 0\% to 23.5\%.

Additionally, we performed numerical simulations using a phantom with a modified signal model to compare a multi-peak versus a single-peak chemical shift model and with and without T2* and noise. These results are detailed in Appendix B.

We also performed an additional experiment where all the vials of the numerical phantom contained non-zero fat fraction and non-zero velocity values to demonstrate the capability of the proposed method to separate fat and water and obtain the velocity. These results are detailed in Appendix C. 

### Acquisitions in volunteers

We acquired data from 12 healthy volunteers on a 1.5 T Philips Achieva MR scanner (Philips, Best, The Netherlands) using a 2D axial slice of the neck containing the carotid arteries. The data was acquired using an 8-element head coil.

We implemented a customized 2D gradient-echo multi-echo sequence of 3p-Dixon acquisitions with bipolar gradients before every readout to encode velocity information. The sequence had velocity-compensated readout gradients. We compared measurements from PC 3p-Dixon OP-IP-OP (TEs of 2.3, 4.6, and 6.9 ms) and PC 3p-Dixon IP-OP-IP (TEs of 4.6, 6.9, and 9.2 ms) with standard 3p-Dixon OP-IP-OP and IP-OP-IP, and 2D PC-MRI acquisitions keeping all the parameters constant. We used retrospective cardiac gating and maintained the same spatial resolution for all acquisitions. Fully sample data were acquired without using any parallel imaging acceleration during the scans.

We acquired a single slice of 8 mm thickness, spatial resolution of $0.83 \times 0.83$ mm, with a matrix size of $240 \times 240$ and 20 cardiac phases with VENC of $100 \pm 10$ cm/s depending on the volunteer. PC 3p-Dixon, 2D PC-MRI, and standard 3p-Dixon acquisitions were obtained using the same temporal resolution (20 cardiac phases). Water-fat components were compared using the images acquired in a representative peak systolic cardiac phase.

The scan duration for each acquisition was: 120 s for PC 3p-Dixon (OP-IP-OP and IP-OP-IP), 120 s for standard 3p-Dixon (OP-IP-OP and IP-OP-IP), and 120 s for standard 2D PC-MRI. Table 1 shows a summary of the MRI acquisition parameters, and Fig. 2 shows a diagram of the pulse sequence implementation of PC 3p-Dixon method.

Table 1: The MRI acquisition parameters.

| **Parameter** |  |
|---|---|
| Voxel size, mm | $0.83 \times 0.83 \times 8.0$ |
| Cardiac phases | $20$ |
| VENC, cm/s | $100 \pm 10$ |
| Resolution | $240 \times 240$ |
| Echo time, ms | |
| &emsp; PC 3p-Dixon IP-OP-IP and 3p-Dixon IP-OP-IP | 4.6, 6.9, and 9.2 |
| &emsp; PC 3p-Dixon OP-IP-OP and 3p-Dixon OP-IP-OP | 2.3, 4.6, and 6.9 |
| &emsp; 2D PC-MRI | 2.04 |
| Acquisition time, s | |
| &emsp; PC 3p-Dixon IP-OP-IP | 119 |
| &emsp; 3p-Dixon IP-OP-IP | 120 |
| &emsp; PC 3p-Dixon OP-IP-OP | 120 |
| &emsp; 3p-Dixon OP-IP-OP | 120 |
| &emsp; 2D PC-MRI | 120 |

![Fig2](<Fig_PC_3pDixon/Fig2.png>)
Figure 2: Pulse sequence diagram of the PC 3p-Dixon sequence. Velocity encoding gradients are applied immediately after RF excitation, followed by three readout gradients at TEs adjusted to obtain IP-OP-IP and OP-IP-OP images. Velocity encoding gradients can be applied in any of the three axes separately or simultaneously. In **(B)**, the velocity encoding gradients are applied with opposite polarity.

### Statistical assessment

Quantitative comparisons between the PC 3p-Dixon methods and standard 3p-Dixon methods were performed by calculating the Mean Absolute Error (MAE$=\sum_{i=1}^n\left|x_i-y_i\right|/n$) and Structural Similarity Index (SSIM).

In the numerical phantom, we draw 16 regions of interest (ROIs), each covering the entire vial. The fat fraction of the phantom is reported as the median and range over the vials. The MAE was calculated for all ROIs simultaneously. 

In volunteers, we manually draw three ROIs in muscles of the neck, spine, and subcutaneous fat. We then computed the estimation error of fat fractions in three ROIs using the median values. Velocity estimation was compared by computing the blood flow in the carotid arteries for each cardiac phase and the total blood flow per cardiac cycle in PC 3p-Dixon and standard PC images. We performed a Wilcoxon Signed Rank test of the blood volume estimation in a cardiac cycle for both carotid arteries, considering a $p$-value $<$ 0.05 as significant.


## Results

### Monte Carlo Simulations

Monte Carlo experiments were conducted to compare velocity bias for different velocity values using PC 3p-Dixon and standard PC (Fig. 3A), and to compare velocity estimation in the presence of different fat fractions (Fig. 3B). Fig. 3A shows the velocity bias computed from Monte Carlo simulations data performed for different velocity values comparing PC 3p-Dixon IP-OP-IP (single-peak without T2* decay and multi-peak with T2* decay) with standard PC. Fig. 3B shows an analogous comparison for the VNR computed from the Monte Carlo simulations data performed for different fat fraction values. Results for the OP-IP-OP case are shown in Appendix D.

We observed that in standard PC, velocity bias increased with the amount of fat, whereas they were corrected with the PC 3p-Dixon method when the phantom does not include T2* decay and multi-fat spectrum. PC 3p-Dixon demonstrated better velocity estimation than standard PC in the presence of fat. All methods show a high VNR without the presence of fat; however, as the fat fraction increased, we observed a decrease in the VNR for standard PC. If the phantom includes T2* decay and multi-fat spectrum, the PC 3p-Dixon method also shows a decrease in VNR as the fat fraction increases. However, PC 3p-Dixon shows a homogeneous VNR for almost any amount of fat fraction when the phantom does not include T2* decay and multi-fat spectrum.

![Fig3](<Fig_PC_3pDixon/Fig3.png>)
Figure 3: Monte Carlo simulations, comparison of PC 3p-Dixon IP-OP-IP single-peak without T2* decay, PC 3p-Dixon IP-OP-IP multi-peak with T2* decay, and standard 2D PC-MRI. **(A)** Velocity bias (cm/s) vs velocity ground truth. Colors in this plot indicate the fat fraction used in each simulation. Plots show the range $\pm 15$ cm/s of velocity bias to easily compare velocity bias for lower values of fat fraction. **(B)** Velocity-to-noise ratio (VNR) vs fat fraction. Colors in this plot indicate the velocity used in each simulation.

### Numerical phantom experiments

Appendix E shows a comparison between the phase-aware and the standard Dixon methods performed using phantom simulations. In this case the vials with velocity were not considered in the simulation. We observed that the water and fat separation are in concordance with the ground truth in both cases. 

Nevertheless, when performing numerical experiments with vials with velocity (Fig. 4B), the phase of the water components in the phase-aware 3p-Dixon method kept the phase associated with the velocity information, which is not seen in the other 3p-Dixon implementation. Furthermore, the phase-aware 3p-Dixon accurately performed a water-fat separation compared to the ground truth as previously reported 3p-Dixon methods.

![Fig4](<Fig_PC_3pDixon/Fig4.png>)
Figure 4: **(A)** Scheme of the numerical in-silico phantom showing the fat fraction (percentage) and velocity (cm/s) encoded in each of the vials. **(B)** Comparison of 3p-Dixon methods for water-fat separation. Water and fat components, the phase of the water component, and field inhomogeneities estimated using the phase-aware 3p-Dixon method compared with the 3p-Dixon proposed by Brown et al. (Brown et al., 2014)

![Fig5](<Fig_PC_3pDixon/Fig5.png>)
Figure 5: Comparison of water-fat components, field map of inhomogeneities, and velocity images between PC 3p-Dixon methods and a standard 3p-Dixon acquisition to compare water and fat components, and a standard 2D PC-MRI to compare velocity images in the numerical phantom.

Fig. 5 shows a qualitative comparison between the PC 3p-Dixon method and the standard method obtained from numerical simulations. Water-fat components and field maps were compared against the standard 3p-Dixon method, and the velocity image was compared with the gold standard 2D PC-MRI.

This section depicted the results obtained using the IP-OP-IP version of 3p-Dixon. Analogous results presenting the OP-IP-OP version of 3p-Dixon are presented in Appendix F.

Fig. 6 shows the estimated error in fat fraction in each of the vials of the numerical phantom that had different concentrations of water and fat. A quantitative comparison with the ground truth of the numerical phantom using the median values of the ROIs in the vials showed a median and range fat fraction difference of 0.1004 and [0.0119, 0.2470] respectively for PC 3p-Dixon IP-OP-IP compared to 0.1033 and [0.0028, 0.2064] obtained in standard 3p-Dixon IP-OP-IP, both compared with nominal values. Those errors are mainly because the numerical phantom included T2* decay and multi-peak fat modeling, which was not accounted for in both the 3p-Dixon and PC 3p-Dixon models, as can be seen in Appendix A. We obtained a MAE of 0.0981 of fat fraction in PC 3p-Dixon, compared to 0.0920 obtained in standard 3p-Dixon. For the velocity, we obtained a median and range error of 0.08 and [0.01, 0.28]\% respectively for PC 3p-Dixon compared to 0.10 and [0.05, 0.12]\% obtained in standard 2D PC-MRI. The MAE obtained for the velocity was 3.42 cm/s for PC 3p-Dixon, compared to 2.68 cm/s obtained in standard 2D PC-MRI. MAE values were computed using all the pixels in the vials.

![Fig6](<Fig_PC_3pDixon/Fig6.png>)
Figure 6: Quantitative comparison of the estimated error obtained from the fat fraction in the vials of the numerical phantom. We compared PC 3p-Dixon (red) and standard 3p-Dixon (blue) results for IP-OP-IP Dixon acquisitions.

In the presence of noise, the PC 3p-Dixon IP-OP-IP performs similarly to the standard 3p-Dixon IP-OP-IP with a difference less than 1.44\% for the error in fat fraction. Appendix G shows detailed plots comparing the noise performance between methods.

![Fig7](<Fig_PC_3pDixon/Fig7.png>)
Figure 7: **(A)** Water-fat components and velocity images obtained from PC 3p-Dixon and standard 3p-Dixon acquisition to compare water and fat components. Standard 2D PC-MRI images were used to compare velocity estimation in a representative volunteer. **(B)** Plots of velocity estimation through the 20 cardiac phases of a representative volunteer in each carotid artery. Blue lines correspond to the velocity estimation using the proposed PC 3p-Dixon IP-OP-IP method. The red lines correspond to the velocity estimation using standard 2D PC-MRI.

### Acquisitions in volunteers

This section presents the results of 3p-Dixon IP-OP-IP acquisitions in volunteers. Results for the PC 3p-Dixon OP-IP-OP version are presented in Appendix H.

Fig. 7A shows images of water and fat fractions, estimated field inhomogeneities, and the velocity of a representative volunteer. Fig. 7B shows plots of the mean velocity estimated in each carotid artery throughout the cardiac cycle acquired in a representative volunteer.

The median and range fat fraction difference, across volunteers, comparing both methods were 0.0331 $\pm$ 0.0290 for muscle ROIs, 0.0523 $\pm$ 0.0295 for spine ROIs, and 0.0608 $\pm$ 0.0561 for subcutaneous fat ROIs. Wilcoxon Signed Rank of the median values in the fat fraction ROIs showed no significant differences between PC 3p-Dixon and standard 3p-Dixon ($p$-value of 0.16 for PC 3p-Dixon IP-OP-IP). Bland Altman plots comparing the median values of fat fractions in each ROI for PC 3p-Dixon IP-OP-IP and standard 3p-Dixon IP-OP-IP are shown in Fig. 8.

The median and range MAE values comparing PC 3p-Dixon, and standard 3p-Dixon fat fraction were 0.06 $\pm$ 0.03 across all volunteers. The median and range SSIM of fat fraction of PC 3p-Dixon and standard 3p-Dixon were 0.85 $\pm$ 0.08. MAE and SSIM values in volunteers were computed using all the pixels in the region of the neck.

![Fig8](<Fig_PC_3pDixon/Fig8.png>)
Figure 8: Bland Altman plots of the fat fraction estimated comparing the PC 3p-Dixon IP-OP-IP methods with standard 3p-Dixon methods using three different ROIs for each volunteer.

Bland Altman plot of Fig. 9 compares the estimated net blood flow of 12 volunteers using PC 3p-Dixon against standard 2D PC-MRI. The median and range of velocity obtained with our technique was 6.15 and [3.86, 7.21]ml, compared to 6.43 and [4.62, 8.27]ml obtained by 2D PC-MRI. Wilcoxon Signed Rank of blood volume estimations showed significant differences in PC 3p-Dixon and standard 2D PC-MRI ($p$-value 0.0004 for PC 3p-Dixon IP-OP-IP). Bland Altman plots show an underestimation of 0.49 ml (in IP-OP-IP), and all measurements were contained in the agreement limits.

![Fig9](<Fig_PC_3pDixon/Fig9.png>)
Figure 9: Bland Altman plot of blood flow estimated in PC 3p-Dixon IP-OP-IP versus standard 2D PC-MRI in each carotid artery per cardiac cycle of the 12 volunteers.

The reconstruction time of our method PC 3p-Dixon IP-OP-IP and OP-IP-OP is 2 s for each volunteer acquisition.


## Discussion

We have developed a method that can simultaneously obtain water-fat and velocity images, providing co-register images and in half of the time if both data set were acquired separately. The PC 3p-Dixon and standard 2D PC-MRI acquisitions took an average of 119 s and 120 s respectively to complete, whereas standard 3p-Dixon techniques took 120 s. We did not use acceleration techniques in any of the acquisitions, which could further accelerate the acquisition of the data.

Since the model is able to resolve for water and fat components simultaneously with velocity, it has the potential to obtain velocity data free from inaccuracies induced from fat. Monte Carlo simulations demonstrated that PC 3p-Dixon outperforms standard PC in the presence of fat. Velocity bias in standard PC increases as fat fraction increases, whereas velocity bias in 3p-Dixon remains low.

When examining velocity bias in Fig. 2A, we see that if the data is generated using a single peak to model fat, the velocity estimation shows nearly zero error for both SNR conditions, independent of the velocity. However, when data is generated using a multi-peak model, both 2D PC-MRI and our method show that the absolute value of error in velocity increases with higher fat content. In our method, for a given fat fraction, the error increases linearly with velocity, whereas in 2D PC-MRI, the error increases quadratically. Furthermore, in our method, for fat fractions below 0.25, the difference in velocity is less than 10\%. In 2D PC-MRI, the error becomes larger for velocities exceeding 40 cm/s at the same fat fraction (0.25). Our method also demonstrated robustness in low SNR scenarios (SNR$=$20), showing an error below 10\% for a fat fraction of 0.25 and velocities under 100cm/s. Another method to deal with flow inaccuracies from fat due to the chemical shift is to use a high bandwidth [20] however that approach results in low SNR and cannot be used to obtain water-fat and velocity images simultaneously.

For VNR (Fig. 2B), it remains constant if a single peak and no T2* decay was considered in the data generation. However, if the data included a multi-peak model and T2* decay, VNR decreases linearly with fat fraction for a given velocity. For both SNR 100 and 20, the VNR drop was less than 10\% for fat fractions under 0.40, again demonstrating the robustness of our method across different SNR scenarios.

Numerical phantom experiments showed similar quantification of water-fat components between the PC 3p-Dixon and standard 3p-Dixon, for both IP-OP-IP and OP-IP-OP. ROIs in the vials showed a median and range fat fraction difference of 0.1004 and [0.0119, 0.2470] respectively for PC 3p-Dixon IP-OP-IP compared to 0.1033 and [0.0028, 0.2064] obtained in standard 3p-Dixon IP-OP-IP, and median and range fat fraction difference of 0.0577 and [0.0117, 0.1572] for PC 3p-Dixon OP-IP-OP compared to 0.0786 and [0.0028, 0.1492] obtained in standard 3p-Dixon OP-IP-OP. Furthermore, MAE results of fat showed neglectable differences between PC 3p-Dixon and standard 3p-Dixon. Velocity estimation also showed equivalent results in PC 3p-Dixon and 2D PC-MRI simulations. Noise performance simulations showed small differences comparing the fat fraction for PC 3p-Dixon and standard 3p-Dixon.

Fig. B.1 assesses the Dixon method and our method under varying conditions. Without noise, and with single-peak and no T2* decay, the error is zero for almost any fat fraction in both Dixon and our method. The error exceeds 10\% only for fat fractions approaching 1.0 when there is either T2*, noise, or a combination of both. This pattern holds for both IP-OP-IP and OP-IP-OP configurations. For a multi-peak phantom, both Dixon and our method perform similarly for fat fractions below 0.60 in both IP-OP-IP and OP-IP-OP configurations. In both methods, the primary impact on fat fraction error stems from the multi-peak model rather than T2* or noise. Fat fraction errors were lower for OP-IP-OP than for IP-OP-IP, and below 5\% when fat fraction was below 0.35, which can be considered as an acceptable error.

The proposed PC 3p-Dixon method is limited by the requirement for fixed TEs, as Dixon methods depend on specific echo times where water and fat signals are either IP or OP and therefore it is difficult to integrate a multi peak modeling in the Dixon method. To further improve the accuracy of the methodology presented here, we are working on an approach that combines PC and IDEAL methods to handle multi-peak models and T2* relaxation effectively and provide flexibility in the selection of TEs.

In volunteers, water-fat components obtained from PC 3p-Dixon acquisitions showed equivalent results to standard 3p-Dixon. Nevertheless, there was a significant statistical difference in the velocity compared to 2D PC-MRI (Fig. 7). Quantitative comparisons in fat fractions from volunteers (Fig. 8) showed variations lower than 5\% of fat between PC 3p-Dixon, against standard 3p-Dixon, highlighting a low bias and good limits of agreement. MAE and SSIM values corroborated these results. Blood flow estimation in the carotid arteries (Fig. 9) showed differences between PC 3p-Dixon methods and standard 2D PC-MRI. We found a small bias of blood flow comparing PC 3p-Dixon with standard 2D PC-MRI, a bias of 0.49 ml, equivalent to 8.24\% of the mean carotid blood flow, for IP-OP-IP. While the error remains below 10\%, potential insights may be gleaned from Monte Carlo simulations. Notably, in scenarios with low fat fractions, standard 2D PC-MRI demonstrated VNR values slightly surpassing those of PC 3p-Dixon, accompanied by an overestimated velocity. Conversely, PC 3p-Dixon exhibited a minor underestimation in velocity under similar conditions. These distinctions could account for the bias observed in our volunteer studies.

Comparing fat fraction in IP-OP-IP and OP-IP-OP data from phantom and volunteers showed a slightly smaller bias in PC 3p-Dixon OP-IP-OP (Fig. F.2 bias equal to -0.0209 in phantom; Fig. H.1, bias equal to -0.0088 in volunteers) in contrast to PC 3p-Dixon IP-OP-IP (Fig. 6 bias equal to -0.0029 in phantom; Fig. 7, bias equal to -0.0141 in volunteers). This could be caused because 3p-Dixon OP-IP-OP acquisitions have shorter TEs than IP-OP-IP. However, blood flow estimation in volunteers was more accurate in PC 3p-Dixon IP-OP-IP (Fig. 8, Bland Altman mean of 0.486 ml), compared to PC 3p-Dixon OP-IP-OP (Fig. H.2, Bland Altman mean of 0.795 ml).

Previous research has demonstrated the use of readout gradients for velocity encoding in velocity measurement [30]. However, multi-echo gradient readouts restrict velocity measurement to in-plane velocities, and the VENC setup is challenging due to gradient amplitude and bandwidth limitations. Incorporating bipolar gradients, however, enables velocity measurement in customizable directions, overcoming these limitations. Combining bipolar gradient and multiple echo readout may limit the temporal resolution of the PC 3p-Dixon methods, however we were able to simultaneously obtain water-fat components and velocity information.

### Limitations

Our study has some limitations. First, the method relies on a simplified signal model that does not account for T2* decay or multi-peak fat modeling, both of which are known to impact the accuracy of fat fraction estimation. These simplifications may limit its applicability in realistic scenarios where confounding factors, such as field inhomogeneities and noise, are prevalent. We are currently developing and validating a methodology to address these limitations by incorporating more sophisticated models, such as PC-IDEAL, to effectively handle multi-peak fat signals and T2* decay. Second, the study involved a small sample size of healthy volunteers, and the absence of patient data limits the clinical relevance of the findings. Expanding the study to include patients with conditions such as atherosclerosis, MASLD, or cardiac steatosis is crucial for evaluating the broader applicability of the technique. Third, the evaluation was restricted to the carotid arteries, which are relatively stable during imaging. Testing the method in more challenging anatomical regions, such as the heart or liver, where motion artifacts and higher demands on imaging robustness are present, would provide a more comprehensive assessment of its utility. However, as MR scans in these regions are typically performed under breath-hold, we do not anticipate significant effects on the results of our method. Fourth, the lack of a direct comparison with Johnson et al.'s method may raise questions about the relative performance of our technique, particularly in terms of acquisition efficiency, reconstruction quality, and robustness. Johnson et al. introduced an alternative method combining chemical shift and radial dual-echo acquisition to simultaneously obtain water, fat, and velocity imaging. While promising, their approach involves a non-linear reconstruction algorithm, which differs fundamentally from the simplified and algebraic methodology proposed in this study. Future studies could address these gaps to better evaluate and clarify the advancements of the proposed technique.


## Conclusion

This work proposed a novel method that simultaneously obtains water-fat components and velocity images combining 2D PC-MRI and 3p-Dixon. Our method requires a straightforward algebraic post-processing to perform the water-fat separation and velocity estimation. Numerical phantom experiments and acquisitions from healthy volunteers showed promising results in fat fraction and velocity estimation of PC 3p-Dixon compared with standard 3p-Dixon and PC-MRI, obtaining both data set in similar times as standard 3p-Dixon.


## Appendix

### A. Phase-aware 3p-Dixon method

To combine 2D PC-MRI and 3p-Dixon methods, we introduced a new formulation of the Dixon method aware of the phase information of water and fat components. We used the complex voxel-wise model of the signal $S_n$ at the echo time $t_n$ defined in Eq. (A.1), where $\rho_W$ and $\rho_F$ are the complex values of water and fat components of the signal, $\Delta f$ is the known chemical shift between water and fat, and $\Delta B$ represents the $B_0$ inhomogeneities.

$$S_n = \left(\rho_W + \rho_F e^{i2\pi\Delta f t_n}\right) e^{-i\gamma\Delta B t_n} \quad\quad \text{Eq. A.1}$$

We considered water and fat components as complex values, i.e., composed by magnitude ($M_W$ and $M_F$) and phase ($\phi_W$ and $\phi_F$). Therefore, we can represent $\rho_W=M_W e^{i\phi_W}$ and $\rho_F=M_F e^{i\phi_F}$, then, the MRI signal in each voxel can be described as shown in Eq. (A.2).

$$S_n = \left(M_W e^{i\phi_W} + M_F e^{i\left[\phi_F + 2\pi\Delta f t_n\right]}\right) e^{-i\gamma\Delta B t_n} \quad\quad \text{Eq. A.2}$$

Eq. (A.3) shows the 3p-Dixon equations representing the multi-echo acquisition IP-OP-IP assuming a single peak fat model.

$$S_{ip,1} = \left(M_W e^{i\phi_W} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip,1}} \quad\quad \text{Eq. A.3a}$$

$$S_{op} = \left(M_W e^{i\phi_W} - M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{op}} \quad\quad \text{Eq. A.3b}$$

$$S_{ip,2} = \left(M_W e^{i\phi_W} + M_F e^{i\phi_F}\right) e^{-i\gamma\Delta B t_{ip,2}} \quad\quad \text{Eq. A.3c}$$

In Eq. (A.3a) and Eq. (A.3c), the exponential with the chemical shift $e^{i2\pi\Delta f t_{ip}}=1$, and in Eq. (A.3b) $e^{i2\pi\Delta f t_{op}}=-1$. We estimated $\Delta B$ by considering the two IP acquisitions as follows,

$$-\gamma\Delta B = \frac{\angle\left(S_{ip,1}^* \cdot S_{ip,2}\right)}{t_{ip,2} - t_{ip,1}} \quad\quad \text{Eq. A.4}$$

where $S_{ip,1}^*$ represents the conjugate of $S_{ip,1}$. Then, we obtained the phase-aware water and fat components by adding and subtracting the IP and OP images.

$$\rho_W = M_W e^{i\phi_W} = \frac{1}{2} \left(S_{ip,1}e^{i\gamma\Delta B t_{ip,1}} + S_{op}e^{i\gamma\Delta B t_{op}}\right) \quad\quad \text{Eq. A.5a}$$

$$\rho_F = M_F e^{i\phi_F} = \frac{1}{2} \left(S_{ip,1}e^{i\gamma\Delta B t_{ip,1}} - S_{op}e^{i\gamma\Delta B t_{op}}\right) \quad\quad \text{Eq. A.5b}$$

The resulting water and fat components preserve the phase information of each element. 

In a similar way, we can apply the phase-preserving 3p-Dixon method in an OP-IP-OP acquisition. In this acquisition, we estimated the field inhomogeneities by considering two OP acquisitions (instead of IP in Eq. (A.44)). After computing the water and fat components using the corrected IP and OP images, we obtained water and fat components. 

### B. 3p-Dixon model Multi-peak vs Single-peak

3p-Dixon techniques assume a single-peak model for the chemical shift of fat and do not consider the effect of T2* decay. We tested the effect of these assumptions using different signal models to generate the numerical phantom. We compared different configurations of the numerical phantom, including multi-peak versus single-peak chemical shift models, and whether include or not T2* decay and noise.

Table B.1 and Fig. B.1 show comparisons of the different configurations of the signal model to generate the numerical phantom. We also compared standard 3p-Dixon methods and the PC 3p-Dixon methods. Table B.1 shows the fat fraction estimation errors in each scenario and Fig. B.1 shows plots of the fat fraction estimation error in each of the vials of the numerical phantom.

Table B.1: Fat fraction estimation errors (values are expressed in percentage) in the numerical phantom for different signal models used to generate the numerical phantom.

**Multi-peak phantom**

|  | Without T2* and Noise | T2* only | T2* and Noise | Noise only |
|---|---|---|---|---|
| PC Dixon IP-OP-IP 	| 8.2220 | 9.0313 | 9.9075 | 8.8778 |
| Dixon IP-OP-IP 		| 7.2794 | 7.5745 | 9.2173 | 8.3005 | \midrule
| PC Dixon OP-IP-OP 	| 4.4557 | 4.6260 | 6.0945 | 5.6572 |
| Dixon OP-IP-OP 		| 6.0424 | 5.8244 | 6.8637 | 6.5667 |

**Single-peak phantom**

|  | Without T2* and Noise | T2* only | T2* and Noise | Noise only |
|---|---|---|---|---|
| PC Dixon IP-OP-IP 	| 0.0007 | 1.4578 | 2.3170 | 1.1192 |
| Dixon IP-OP-IP 		| 0.0001 | 0.1183 | 1.6592 | 1.0080 | \midrule
| PC Dixon OP-IP-OP 	| 0.0035 | 1.4441 | 1.5792 | 1.1166 |
| Dixon OP-IP-OP 		| 0.0008 | 0.1190 | 1.3700 | 0.9793 |

![FigS1](<Fig_PC_3pDixon/FigS1.png>)
Figure B.1: Plots of the fat fraction estimation error in the phantom vials. We plotted the error computed using the standard 3p-Dixon method (blue dots) and the proposed PC 3p-Dixon methods (red dots).

Since the 3p-Dixon method proposed did not consider T2* decay or a multi-peak model of fat, the comparison performed in Table B.1 and Fig. B.1 show the fat fraction estimation error increases when we generate the numerical phantom using a multi-peak chemical shift model instead of a single-peak model.

Fig. B.1 shows the increase in fat fraction estimation error as fat fraction value increases in multi-peak phantoms for fat fraction values smaller than 0.6. In single-peak phantoms, the estimation error in these cases is negligible. For higher values of fat fraction, the estimation errors are variable for multi-peak phantoms and increase in single-peak phantoms when considering T2* decay and/or noise.

### C. Numerical phantom experiments with velocity and fat fraction in vials

#### 3p-Dixon IP-OP-IP

![FigS2](<Fig_PC_3pDixon/FigS2.png>)
Fiure C.1: Comparison of water-fat components, field map of inhomogeneities, and velocity images between PC 3p-Dixon methods and a standard 3p-Dixon acquisition to compare water and fat components, and a standard 2D PC-MRI to compare velocity images in the numerical phantom.

This section presents results for numerical phantom simulations for 3p-Dixon IP-OP-IP with velocity in the vials containing water and fat components.

Fig. C.1 shows qualitative comparisons between the PC 3p-Dixon IP-OP-IP method and standard methods obtained from numerical simulations.

Fig. C.2 shows the difference in fat fraction in each of the vials of the numerical phantom that have different concentrations of water and fat. Quantitative comparison with the ground truth of the numerical phantom using the median values of the ROIs in the vials showed median and range fat fraction difference of 0.1016 and [0.0113, 0.2470] for PC 3p-Dixon compared to 0.1033 and [0.0028, 0.2064] obtained in standard 3p-Dixon. We obtained a MAE of 9.73\% of fat fraction in PC 3p-Dixon, compared to 9.20\% of fat fraction obtained in standard 3p-Dixon. For the velocity, we obtained a median and range error of 12.15 and [0.01, 61.84]\% for PC 3p-Dixon, compared to 18.83 and [0.05, 174.93]\% obtained in standard PC-MRI. The MAE obtained in the velocity estimation for PC 3p-Dixon was 9.09 cm/s, compared to 25.60 cm/s obtained in standard 2D PC-MRI.

![FigS3](<Fig_PC_3pDixon/FigS3.png>)
Figure C.2: Quantitative comparison of the estimated error obtained from the fat fraction in the vials of the numerical phantom. We compared PC 3p-Dixon (red) and standard 3p-Dixon (blue) results for IP-OP-IP Dixon acquisitions.

#### 3p-Dixon OP-IP-OP

![FigS4](<Fig_PC_3pDixon/FigS4.png>)
Figure C.3: Comparison of water-fat components, field map of inhomogeneities, and velocity images between PC 3p-Dixon methods and a standard 3p-Dixon acquisition to compare water and fat components, and a standard 2D PC-MRI to compare velocity images in the numerical phantom.

This section presents results for numerical phantom simulations for 3p-Dixon OP-IP-OP with velocity in the vials containing water and fat components.

Fig. C.3 shows qualitative comparisons between the PC 3p-Dixon OP-IP-OP method and standard methods obtained from numerical simulations.

Fig. C.4 shows the difference in fat fraction in each of the vials of the numerical phantom that have different concentrations of water and fat. Quantitative comparison with the ground truth of the numerical phantom using the median values of the ROIs in the vials showed median and range fat fraction difference of 0.0572 and [0.0111, 0.1572] for PC 3p-Dixon compared to 0.0786 and [0.0028, 0.1492] obtained in standard 3p-Dixon. We obtained a MAE of 6.15\% of fat fraction in PC 3p-Dixon, compared to 6.93\% of fat fraction obtained in standard 3p-Dixon. For the velocity, we obtained a median and range error of 3.22 and [0, 42.53]\% for PC 3p-Dixon, compared to 18.83 and [0.05, 174.93]\% obtained in standard 2D PC-MRI. The MAE obtained in the velocity estimation for PC 3p-Dixon was 12.59 cm/s, compared to 25.60 cm/s obtained in standard 2D PC-MRI.

![FigS5](<Fig_PC_3pDixon/FigS5.png>)
Quantitative comparison of the estimated error obtained from the fat fraction in the vials of the numerical phantom. We compared PC 3p-Dixon (red) and standard 3p-Dixon (blue) results for OP-IP-OP Dixon acquisitions.

### D. Monte Carlo Simulations, 3p-Dixon OP-IP-OP

Fig. D.1A shows the velocity bias computed from the Monte Carlo simulations data performed for different velocity values comparing PC 3p-Dixon OP-IP-OP (single-peak without T2* decay and multi-peak with T2* decay) with standard PC. Fig. D.1B shows an analogous comparison for the VNR computed from Monte Carlo simulations data performed for different fat fraction values.

![FigS6](<Fig_PC_3pDixon/FigS6.png>)
Figure: D.1: Monte Carlo simulations, comparison of PC 3p-Dixon OP-IP-OP single-peak without T2* decay, PC 3p-Dixon OP-IP-OP multi-peak with T2* decay, and standard PC-MRI. **(A)** Velocity bias (cm/s) vs velocity ground truth. Colors in this plot indicate the fat fraction used in each simulation. Plots show the range $\pm 15$cm/s of velocity bias to easily compare velocity bias for lower values of fat fraction. **(B)** Velocity-to-noise ratio (VNR) vs fat fraction. Colors in this plot indicate the velocity used in each simulation.

### E. Phase-aware vs standard Dixon methods

![FigS7](<Fig_PC_3pDixon/FigS7.png>)
Figure E.1: Comparison of 3p-Dixon methods for water-fat separation. Water and fat components, field inhomogeneities estimated using the phase-aware 3p-Dixon method compared with the 3p-Dixon proposed by Brown et al. (Brown et al., 2014)

To compare the proposed phase-aware and standard 3p-Dixon methods we did not include the T2* decay in the simulations. We did not add velocity to the vials of the phantom as well. Fig. E.1 shows a qualitative comparison of the water and fat components, and field map. Quantitative comparison of fat fraction between the phase-aware 3p-Dixon and the ground truth of the numerical phantom showed MAE values of 8.20\% (IP-OP-IP) and 4.56\% (OP-IP-OP), while a comparison of the ground truth with standard 3p-Dixon showed a MAE of 7.24\% (IP-OP-IP) and 5.88\% (OP-IP-OP).

### F. Numerical phantom experiments, 3p-Dixon OP-IP-OP

This section presents results for numerical phantom simulations for 3p-Dixon OP-IP-OP.

Fig. F.1 shows qualitative comparisons between the PC 3p-Dixon OP-IP-OP method and standard methods obtained from numerical simulations.

![FigS8](<Fig_PC_3pDixon/FigS8.png>)
Figure F.1: Comparison of water-fat components, field map of inhomogeneities, and velocity images between PC 3p-Dixon methods and a standard 3p-Dixon acquisition to compare water and fat components, and a standard 2D PC-MRI to compare velocity images in the numerical phantom.

Fig. F.2 shows the difference in fat fraction in each of the vials of the numerical phantom that have different concentrations of water and fat. Quantitative comparison with the ground truth of the numerical phantom using the median values of the ROIs in the vials showed median and range fat fraction difference of 0.0577 and [0.0117, 0.1572] for PC 3p-Dixon compared to 0.0786 and [0.0028, 0.1492] obtained in standard 3p-Dixon. We obtained a MAE of 6.18\% of fat fraction in PC 3p-Dixon, compared to 6.93 of fat fraction obtained in standard 3p-Dixon. For the velocity, we obtained a median and range error of 0.01 and [0.00, 0.29]\% for PC 3p-Dixon, compared to 0.10 and [0.05, 0.12]\% obtained in standard 2D PC-MRI. The MAE obtained in the velocity estimation for PC 3p-Dixon was 2.99 cm/s, compared to 2.68 cm/s obtained in standard 2D PC-MRI.

![FigS9](<Fig_PC_3pDixon/FigS9.png>)
Figure F.2: Quantitative comparison of error obtained from the fat fraction in the tubes of the numerical phantom. We compared PC 3p-Dixon and standard 3p-Dixon results for OP-IP-OP Dixon acquisitions.

### G. SNR Analysis

We tested the tolerance to noise performing 20 different phantom simulations using a SD for the Gaussian noise between 0\% and 23.5\%. Fig. G.1 shows the errors comparing the fat fraction obtained comparing PC 3p-Dixon and standard 3p-Dixon methods.

Standard 3p-Dixon IP-OP-IP performs slightly better than PC 3p-Dixon IP-OP-IP with differences less than 1.44\% in fat fraction estimation error. PC 3p-Dixon OP-IP-OP perform better than standard 3p-Dixon IP-OP-IP method with differences less than 1.21\% in fat fraction estimation error.

![FigS10](<Fig_PC_3pDixon/FigS10.png>)
Figure G.1: Estimation error values of the fat fractions obtained for Gaussian noise with SDs between 0\% and 23.5\% to compare PC 3p-Dixon and standard 3p-Dixon methods, **(A)** 3p-Dixon IP-OP-IP, **(B)** 3p-Dixon OP-IP-OP.

### H. Acquisitions in volunteers, 3p-Dixon OP-IP-OP

This section presents results for acquisitions in volunteers for 3p-Dixon OP-IP-OP.

The median and range fat fraction difference comparing both methods are 0.0078 $\pm$ 0.0118 for the ROIs in muscle, 0.0291 $\pm$ 0.0295 for the ROIs in spine, and 0.0349 $\pm$ 0.0600 for the ROIs in subcutaneous fat.

Wilcoxon Signed Rank of the median values in the fat fractions of the ROIs showed no significant differences in PC 3p-Dixon and standard 3p-Dixon ($p$-value of 0.0758 PC 3p-Dixon OP-IP-OP).

Bland Altman plots compare the median values of fat fractions in each ROI for PC 3p-Dixon OP-IP-OP and standard 3p-Dixon OP-IP-OP are shown in Fig. H.1.

The MAE values obtained comparing PC 3p-Dixon, and standard 3p-Dixon fat fraction were 0.06 $\pm$ 0.02. SSIM of fat fraction of PC 3p-Dixon and standard 3p-Dixon were 0.85 $\pm$ 0.04.

![FigS11](<Fig_PC_3pDixon/FigS11.png>)
Figure H.1: Bland Altman plots of the fat fraction estimated comparing the PC 3p-Dixon OP-IP-OP with gold standard 3p-Dixon methods using three different ROIs for each volunteer.

Bland Altman plots in Fig. H.2 compared the estimated blood flow of 12 volunteers using PC 3p-Dixon against standard 2D PC-MRI. The median and range of velocity obtained with our technique was 5.58 and [3.74, 6.93] ml, compared to 6.43 and [4.62, 8.27] ml obtained by PC-MRI. Wilcoxon Signed Rank of blood volume estimations showed significant differences in PC 3p-Dixon and standard 2D PC-MRI ($p$-value of 0.0003 for PC 3p-Dixon OP-IP-OP). However, the Bland Altman plot shows that all the paired measurements were contained in the agreement limits, but there was an underestimation of 0.80 ml in OP-IP-OP.

![FigS12](<Fig_PC_3pDixon/FigS12.png>)
Figure H.2: Bland Altman plot of blood flow estimated in PC 3p-Dixon OP-IP-OP versus standard 2D PC-MRI in each carotid artery per cardiac cycle of the 12 volunteers.


## References

1. Brown RW, Cheng YCN, Haacke EM, Thompson MR, Venkatesan R. MR Angiography and Flow Quantificationch. 24, :701-737. John Wiley & Sons, Ltd 2014.

2. Jarral OA, Tan MK, Salmasi MY, et al. Phase-contrast magnetic resonance imaging and computational fluid dynamics assessment of thoracic aorta blood flow: A literature review. European Journal of Cardio-thoracic Surgery. 2020;57.

3. Thompson RB, McVeigh ER. Fast measurement of intracardiac pressure differences with 2D breath-hold phase-contrast MRI. Magnetic Resonance in Medicine. 2003;49.

4. Montalba C, Urbina J, Sotelo J, et al. Variability of 4D flow parameters when subjected to changes in MRI acquisition parameters using a realistic thoracic aortic phantom. Magnetic Resonance in Medicine. 2018;79.

5. Sotelo J, Urbina J, Valverde I, et al. 3D Quantification of Wall Shear Stress and Oscillatory Shear Index Using a Finite-Element Method in 3D CINE PC-MRI Data of the Thoracic Aorta. IEEE Transactions on Medical Imaging. 2016;35.

6. Sotelo J, Urbina J, Valverde I, et al. Three-dimensional quantification of vorticity and helicity from 3D cine PC-MRI using finite-element interpolations. Magnetic Resonance in Medicine. 2018;79.

7. Sotelo J, Valverde I, Martins D, et al. Impact of aortic arch curvature in flow haemodynamics in patients with transposition of the great arteries after arterial switch operation. European Heart Journal Cardiovascular Imaging. 2022;23.

8. Dixon WT. Simple proton spectroscopic imaging.. Radiology. 1984;153:189-194. PMID: 6089263.

9. Glover GH, Schneider E. Three￿point dixon technique for true water/fat decomposition with B0 inhomogeneity correction. Magnetic Resonance in Medicine. 1991;18.

10. Ma J. Dixon techniques for water and fat imaging. Journal of Magnetic Resonance Imaging. 2008;28.

11. Pauly J. Dixon Reconstruction. Stanford Lecture Notes. 2007.

12. Wang Y, Li D, Haacke EM, Brown JJ. A three-point Dixon method for water and fat separation using 2D and 3D gradient-echo techniques. Journal of Magnetic Resonance Imaging. 1998;8.

13. Caussy C, Reeder SB, Sirlin CB, Loomba R. Noninvasive, Quantitative Assessment of Liver Fat by MRI-PDFF as an Endpoint in NASH Trials. Hepatology. 2018;68.

14. Liu CY, Redheuil A, Ouwerkerk R, Lima JA, Bluemke DA. Myocardial fat quantification in humans: Evaluation by two-point water-fat imaging and localized proton spectroscopy. Magnetic Resonance in Medicine. 2010;63.

15. McDonald N, Eddowes PJ, Hodson J, et al. Multiparametric magnetic resonance imaging for quantitation of liver disease: A two-centre cross-sectional observational study. Scientific Reports. 2018;8.

16. Pruente R, Restrepo CS, Ocazionez D, Suby-Long T, Vargas D. Fatty lesions in and around the heart: A pictorial review. British Journal of Radiology. 2015;88.

17. Tang A, Tan J, Sun M, et al. Nonalcoholic fatty liver disease: MR imaging of liver proton density fat fraction to assess hepatic steatosis. Radiology. 2013;267.

18. Vu KN, Gilbert G, Chalut M, Chagnon M, Chartrand G, Tang A. MRI-determined liver proton density fat fraction, with MRS validation: Comparison of regions of interest sampling methods in patients with type 2 diabetes. Journal of Magnetic Resonance Imaging. 2016;43.

19. Eggers H, Börnert P. Chemical shift encoding-based water-fat separation methods. Journal of Magnetic Resonance Imaging. 2014;40.

20. Middione MJ, Ennis DB. Chemical shift-induced phase errors in phase-contrast MRI. Magnetic Resonance in Medicine. 2013;69.

21. Johnson KM, Wieben O, Samsonov AA. Phase-contrast velocimetry with simultaneous fat/water separation. Magnetic Resonance in Medicine. 2010;63.

22. Bydder M, Yokoo T, Yu H, Carl M, Reeder SB, Sirlin CB. Constraining the initial phase in water-fat separation. Magnetic Resonance Imaging. 2011;29.

23. Pineda AR, Reeder SB, Wen Z, Pelc NJ. Cramér-Rao bounds for three-point decomposition of water and fat. Magnetic Resonance in Medicine. 2005;54.

24. Brown RW, Cheng YCN, Haacke EM, Thompson MR, Venkatesan R. Water/Fat Separation Techniquesch. 17, :413-445. John Wiley & Sons, Ltd 2014.

25. Barth M, Moser E. Proton NMR relaxation times of human blood samples at 1.5 T and implications for functional MRI.. Cellular and molecular biology (Noisy-le-Grand, France). 1997;43.

26. Lee AT, Pike GB, Pelc NJ. Three￿Point Phase￿Contrast Velocity Measurements with Increased Velocity￿to￿Noise Ratio. Magnetic Resonance in Medicine. 1995;33.

27. Hernando D, Liang ZP, Kellman P. Chemical shift-based water/fat separation: A comparison of signal models. Magnetic Resonance in Medicine. 2010;64.

28. Wang X, Hernando D, Reeder SB. Sensitivity of chemical shift-encoded fat quantification to calibration of fat MR spectrum. Magnetic Resonance in Medicine. 2016;75.

29. Yu H, Shimakawa A, McKenzie CA, Brodsky E, Brittain JH, Reeder SB. Multiecho water-fat separation and simultaneous R*2 estimation with multifrequency fat spectrum modeling. Magnetic Resonance in Medicine. 2008;60.

30. Grinstead J, Sinha S. In-plane velocity encoding with coherent steady-state imaging. Magnetic Resonance in Medicine. 2005;54.

----