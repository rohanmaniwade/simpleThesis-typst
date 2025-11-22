#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

= Signal Processing and Spectral Synthesis

Because three sensors record along three orthogonal axes, nine accelerated profiles are produced (one per sensor‑axis channel). The code was written to do the following,

1. Inspect vibration time‑history signals for each mode (visualisation and sanity checks).
2. Convert time histories to Power Spectral Densities (PSDs).
3. Compute the Fatigue Damage Spectrum (FDS) for each mode.
4. Form a composite FDS by summing modal damage contributions weighted by their dwell times in the endurance profile.
5. Invert the composite FDS to an equivalent PSD for the target life duration.
6. Apply time reduction from @timecompression to derive accelerated PSDs for 1 h, 1.5 h, 2 h, 4h, 5 h, 10 h, 20 h, 50 h, and 100 h.
7. Compute the Extreme Response Spectrum (ERS) for each accelerated PSD and compare against the Shock Response Spectrum (SRS) envelope of the reference shock event (e.g., cheese‑blending load) to check severity.

The Python libary VibeAccelKit @vibeaccelkit2025 was used for the computation and signal processing.

== Introduction to VibeAccelKit

VibeAccelKit @vibeaccelkit2025 is a Python-based toolkit developed as part ot this thesis work to implement and automate the complete workflow for vibration test tailoring, mission synthesis, and test acceleration. The library integrates established damage equivalence methodologies, particularly the Fatigue Damage Spectrum method and FDS-to-PSD conversion method @lalanne2010mechanicalvol @mcneill2008implementing into a cohesive, reproducible framework suitable for both research and industrial application.

The toolkit addresses three primary objectives, 
+ Quantifying fatigue damage across multiple mission profiles using spectral damage metrics
+ Synthesising composite damage spectra that represent combined mission loading, and
+ Generating accelerated Power Spectral Density (PSD) test profiles that replicate equivalent damage in reduced test durations.

Additionally, VibeAccelKit incorporates validation capabilities to ensure that the accelerated test specifications do not exceed critical response limits, such as the Shock Response Spectrum (SRS) and Extreme Response Spectrum (ERS), thereby preventing overtesting.

Built upon NumPy and SciPy for computational efficiency, VibeAccelKit implements both time domain and frequency domain approaches for FDS calculation. The time domain method employs a single-degree-of-freedom (SDOF) oscillator simulation coupled with rainflow cycle counting to directly quantify fatigue damage from accelerated time histories. The frequency domain approach leverages spectral moment analysis and probabilistic damage rate models (Rice and Rayleigh distributions) to compute FDS directly from PSDs, offereing computational advantages for stationary random processes.

The core acceleration methodology follows Lalanne’s analytical framework, which relates FDS to an equivalent PSD through the relationship between damage accumulation, spectral density, and test duration. The acceleration process scales the equivalent PSD according to the target test duration and fatigue exponent, maintaining damage equivalence while reducing test time. validation routines that verify that the accelerated profile satisfies design constraints, ensuring that response spectra remain within acceptable bounds relative to the original mission requirements. 

VibeAccelKit represents a practical implementation of vibration test acceleration theory, providing researchers and test engineers with an open-source tool for developing, analysing, and validation accelerated vibration test profiles. The library facilitates reproducible research workflows and enables systematic exploration of acceleration parameters, fatigue exponents, and validation criteria within a unified computational environment.

With time histories collected for each operating mode of Thermomix#super[#sym.trademark.registered] TM7, Lalanne’s specification was applied to derive accelerated PSDs that are damage‑equivalent to the field profile while compressing duration. The Python library VibeAccelKit @vibeaccelkit2025 used for signal processing, test synthesis, and verification.


== Data Import and Preprocessing

The recorded vibration time histories for all speed modes were imported as `.csv` files for processing. ArtemiS Suite natively records measurements in `.hdf` format, which was converted to `.csv` within the software before export. Each `.csv` file contains time history data for all nine channels, corresponding to the three accelerometers measuring along their respective X, Y, and Z axes.

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/time_history_CENTER_Z_cropped.pdf", encoding: none), width: 150mm,
    )
  ],
  caption: [Time history signal for `PCB_CENTER` Z-axis]
)<timehistory_center_z>

@timehistory_center_z presents the vibration time histories recorded at sensor `PCB_CENTER` along the Z axis for all operating modes and shock events. Most speed modes exhibit stationary random behaviour, with relatively stable amplitude distributions over time. The dough mode introduces transient variations due to the alternating blade direction and dough resistance. The signal in black corresponds to the cheese block blending event, where two 200-gram blocks of Grana Padano were processed at Speed 8. This event produced significantly higher amplitude peaks and broader frequency content compared to normal operation, making it suitable as a reference shock for validating that accelerated profiles do not exceed realistic severity limits.

The RMS value quantifies the overall intensity of a vibration signal and serves as a fundamental damage metric @BruelKjaer1982_MeasuringVibration @ISO2041_2018. For time domain signals,

$ x_(R M S)= sqrt(1/T)integral^T_0 x^2(t) d t approx sqrt(1/N) sum^N_(i=1) x^2_i $  <rmstimecalculation>

For frequency domain analysis, RMS is computed from the PSD using Parseval's theorem @BendatPiersol2010,

$ x_(R M S)= sqrt(integral^infinity_0 S_(x x)(f)d f) $ <rmspsdcalculation>

where $S_(x x)(f)$ is the power spectral density. VibeAccelKit implements using the trapezoidal rule for improved accuracy over discrete frequency grids.

== Power Spectral Density Estimation

The PSD characterises the frequency content and intensity of random vibration signals @BendatPiersol2010 @Newland2012. VibeAccelKit implements Welch's method @Welch1967 for robust PSD estimation from time histories,

$ S_(x x)(f)= 1/K sum^K_(k=1)|(F F T_k (x)|^2 dot 1/(f_s.N_(s e g)) $ <psdfromtimehistory>

where $K$ is the number of overlapping segments, $N_(s e g)$ is the segment length, and $f_s$ is the sampling frequency. The method applies a Hanning window to each segment to reduce spectral leakage,

$ w(n)= 0.5 (1 - cos(2pi n)/N_(s e g) - 1 ) $ 

The windowing correction factor ensures proper PSD amplitude scaling. For theoretical PSD-to-time conversions, the library preserves the RMS relationship through careful normalisation of synthesised signals.

MIL-STD-810 random vibration profiles for electronics typically span 20-2000 Hz. Extending the analysis beyond 2 KHz does not improve fidelity for PCB-level durability assessments, since the standard environmental spectra contain negligble energy above this point @MILSTD810H_2019. 

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/psd_inspect_CENTER_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [PSDs of all motor speed modes for `PCB_CENTER` Z-axis]
)<PSDinspect>

@PSDinspect presents the power spectral densities computed from 1-minute recordings for all motor speeds at sensor `PCB_CENTER` along the Z axis. Each colored trace corresponds to a different operating speed, spanning the frequency range from 0 to 2000 Hz. The spectral shapes vary noticeably across operating conditions. At lower speeds, energy concentrates in narrow peaks around blade pass frequencies and their harmonics. As speed increases, the vibration energy spreads more broadly across the spectrum, reflecting the more complex excitation from faster blade motion and fluid interaction. Elevated spectral content appears consistently between 50 and 200 Hz across multiple modes, coinciding with the first few structural resonances identified during modal analysis. This concentration of energy near natural frequencies indicates resonant amplification, which directly influences fatigue accumulation. The PSDs form the input for fatigue damage spectrum calculations, where the spectral energy at each frequency is weighted according to how effectively that frequency excites structural oscillators across a range of natural frequencies.

== Fatigue Damage Spectrum calculation

The FDS quantifies cumulative fatigue damage as a function of natural frequency for a population of single-degree-of-freedom (SDOF) oscillators subjected to base excitation @lalanne2010mechanicalvol. VibeAccelKit implements two complementary appraoches. 

- Time Domain FDS: For each natural frequency $f_0$ and damping ratio $zeta$ the relative displacement of $z(t)$ of a base-excited SDOF oscillator is computed by solving,

$ dot.double(z)+ 2zeta w_0 dot(z) + w_0^2 z = -a_(b a s e) (t) $

where $w_0=2 pi f_0$. The library uses bilinear transformation (Tustin's method) @OppenheimSchafer2010 for stable numerical integration of the continuous-time system. Fatigue damage is then calculated from @fatiguedamage using rainflow cycle counting @ASTM_E1049_85_2017 according to the Palmgren-Miner rule @miner1945cumulative.

- Frequency Domain FDS: For stationary random processes, FDS is computed from the PSD using spectral moments @Steinberg2000 @halfpenny2006accelerated. The relative displacement PSD of the SDOF system is,

$ S_z(f) = |H(f,f_0)|^2 dot S_(a c c)(f) $

where the transfer function for base excitation is,

$ H(f,f_0)= (-1) /(-w^2 +2j zeta w_0 w + w_0^2) $

Spectral moments are computed as,

$ m_n = integral^infinity_0 w^n S_z (w)d w $

The damage rate is estimated using Rice's formula @Rice1944 for narrow-band processes (irregularity factor $y approx 1$),

$ dot(D)_(R a y l e i g h)= v_p sigma^b dot 2^(b/2) Gamma (1+b/2) $

where $v_p = sqrt(m_2/m_0)$ is the peak frequency and $sigma=sqrt(m_o)$ is the RMS response. For broadband processes, Rice's general formulation is employed @Rice1944 @Rice1945,

$ dot(D)_(R i c e) = v_p sigma^b integral^infinity_0 u^b q(u)d u $

where the probability density function $q(u)$ depends on the irregularity factor $y= m_2/sqrt(m_o m_4)$ The total FDS is then $D=dot(D).T$

=== Composite Fatigue Damage Spectrum

Finally, FDSs of multiple mission profiles are combined using time-weighted summation giving us the composite FDS @MILSTD810H_2019 @lalanne2010mechanicalvol,

$ F D S_(c o m p)(f) = sum^N_(j=1) F D S_j (f). T_j/T_(t o t a l) $ <seriesfds>

where $F D S_j (f)$ is the damage spectrum for mission $j$ with duration $T_j$.
@seriesfds is used for events in series. For events in parallel, an envelope operation can also be applied,

$ F D S_(e n v) (f)=max_j [F D S_j (f)] $ <parallelfds>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/fds_b9_center_z_cropped.pdf", encoding: none)
    )
  ],
  caption: [Composite FDS of all motor speeds for `PCB_CENTER` Z-axis ($b=9$, $zeta=0.05$)]
)<compositefdsb9centerz>

The FDS methodology has an important mathematical property: when the same fatigue exponent $b$ and damping ratio $zeta$ are used consistently for both the forward calculation (PSD to FDS) and inverse transformation (FDS back to PSD), these values cancel out in the final accelerated profile. Accurate material specific values should be used when available from testing or supplier data. When such data is unavailable, established default values provide reasonable approximations. Following Lalanne's recommendations for electronic assemblies, calculations were performed with $b = 8$ and $b = 9$ (typical for solder joints) and $zeta = 0.05$ (Q = 10, representing lightly damped PCB behavior) @lalanne2010_fatigue_damage @LalanneSummary. Both exponent values were evaluated to examine their influence on the resulting test specifications.

The frequency-domain approach was chosen for computational efficiency. While time-domain and frequency-domain methods produce equivalent results for stationary Gaussian vibration, the frequency-domain calculation runs substantially faster when processing multiple channels across many operating modes. Preliminary comparisons confirmed negligible differences between the two approaches, validating the frequency-domain method for this application.

@compositefdsb9centerz shows the FDS for each motor speed at sensor `PCB_CENTER` Z-axis from 0 to 2000 Hz, computed with $b = 9$ and $zeta = 0.05$. Each colored trace represents one operating speed, revealing how that mode contributes to damage at different natural frequencies. The bold composite FDS, calculated by time-weighted summation per @seriesfds, sums up all individual contributions. This composite represents the total accumulated fatigue damage over the complete endurance profile and directly determines the accelerated test specification.

== FDS to PSD inversion 

The FDS to PSD inversion is a critical step in developing accelerated vibration test specifications from field data. After the composite FDS is calculated that bounds all measured vibration environments, this method converts it into a PSD profile that can be programmed into vibration testing equipment. The equivalent PSD is derived from the composite FDS using Lalanne's analytical relationship @lalanne2010mechanicalvol,

$ P S D_(e q) (f)= (8 pi f)/Q [(F D S_(c o m p) (f))/f.T_(e q). Gamma(1+b/2)]^(1/b) $ <fdstopsdinit>

where $ Q=1/(2 zeta) $ is the quality factor, $Gamma$ is the gamma function, and $T_(e q)$ is the equivalent test duration. This inversion assumes narrow-band response (Rayleigh damage model) and provides a lower-bound PSD estimate.

=== Implementation of an Iterative Method
While the Lalanne formula provides an excellent initial estimate, it assumes narrow-band response. In practice, structural vibration may have broad-band characteristics. Therefore, an iterative refinement process is employed.

Applying the FDS to PSD inversion to the composite FDS from the Thermomix backend endurance profile yields an equivalent PSD with a test duration of 924 hours. This equivalent PSD represents a single continuous test profile that would replicate the same cumulative fatigue damage as the complete field endurance cycle.

+ Initial Estimate: Apply Lalanne formula to obtain $P S D_(i n i t)$.
+ Forward Calculation: Compute the FDS that the current PSD would produce using a mode sophisticated model (Rice's method with bandwidth correction) @Rice1944 @Rice1945.
+ Error Assessment: Compare computed FDS to target composite FDS
+ Multiplicative Correction: Update PSD using @lalanne2010mechanicalvol,$ c o r r = ((F D S_(t a r g e t))/(F D S_(c u r r e n t)))^(2/b) $ <corr>
+ Under-relaxation: Apply damping factor ($alpha=0.9$) to prevent oscillation @Press2007.
+ Gain Limiting: Constrain corrections between 0.5 and 2.0 per iteration  @NASAHDBK7005.
+ Convergence Check: Stop when FDS error $<0.1 d B$ @Steinberg2000.

The correction exponent $2/b$ is derived from the relationship: since damaging scales as $P S D^(b/2)$, correcting an FDS error by factor $R$ requires adjusting PSD by $R^(2/b)$.


#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/psd_init_cropped.pdf", encoding: none)
    )
  ],
  caption: [Initial equivalent PSD derived from Lalanne's formula for `PCB_CENTER` Z-axis ($b=9$, $zeta=0.05$, $T_(e q)=924$ hours)]
)<psdinit>

@psdinit shows the initial equivalent PSD obtained by directly applying Lalanne's analytical inversion formula per @fdstopsdinit to the composite FDS. This initial estimate assumes narrow-band Rayleigh response characteristics and provides the starting point for the iterative refinement process. While this analytical solution offers a computationally efficient first approximation, the assumption of narrow-band behavior may not fully capture the broadband nature of the actual structural response.

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/psd_match_cropped.pdf", encoding: none)
    )
  ],
  caption: [Comparison of initial and converged equivalent PSDs for `PCB_CENTER` Z-axis]
)<psdmatch>

The iterative refinement process adjusts the initial PSD to account for broadband response characteristics using Rice's more general damage formulation. @psdmatch compares the initial PSD from Lalanne's formula with the converged PSD after iterative correction. At each iteration, the multiplicative correction factor from @corr is applied frequency-by-frequency to adjust the PSD based on the ratio of target to computed FDS values. The refined profile shows localized adjustments, particularly in frequency regions where the narrow-band assumption deviates from the actual broadband damage accumulation. Under-relaxation and gain limiting ensure stable convergence without oscillation.

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/fds_match_cropped.pdf", encoding: none)
    )
  ],
  caption: [Target composite FDS and recomputed FDS from converged equivalent PSD for `PCB_CENTER` Z-axis]
)<fdsmatch>

@fdsmatch validates the inversion process by comparing the target composite FDS with the FDS recomputed from the final converged PSD using Rice's broadband damage model. The close agreement between the two curves confirms that the iterative method successfully produces an equivalent PSD that reproduces the desired fatigue damage spectrum. The resulting equivalent PSD corresponds to a test duration of 924 hours, meaning this profile, when run continuously for 924 hours, would replicate the same cumulative fatigue damage as the complete endurance cycle. The convergence criterion of less than 0.1 dB error ensures that the resulting test specification will deliver fatigue damage equivalent to the field profile across the entire frequency range of interest.

=== PSD Envelope Smoothing Method

The iteratively matched PSD contains sharp peaks and deep notches that challenge practical shaker reproduction, as seen in @psdmatch. Electrodynamic shakers have inherent limitations in control loop bandwidth, actuator response, and fixture dynamics that make it difficult to accurately follow such irregular spectra.

To address this, a log frequency peak follower envelope is applied. This approach tracks the dominant resonant peaks while limiting the spectral decay between adjacent peaks to 1 dB per octave. The envelope is enforced to remain conservative at all frequencies, ensuring that $P S D_(e n v)(f) >= P S D_(m a t c h e d)(f)$ everywhere. This preserves the critical resonant content driving fatigue damage while eliminating the sharp drops and narrow notches that shakers cannot reliably control. The result is a smoothed specification that maintains test severity and remains executable in the laboratory.

== Accelerated Profile Generation 

Once the equivalent PSD is established, accelerated test profiles are generated by scaling this baseline spectrum according to the target test duration. The scaling relationship follows @timecompression and maintains fatigue damage equivalence while compressing the test from the equivalent duration $T_(e q)$ down to the accelerated duration $T_(a c c)$. As the test duration decreases, the PSD amplitude increases according to @timereductionacc, raising the RMS level to deliver the same cumulative damage in less time.

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/acc_psds_cropped.pdf", encoding: none)
    )
  ],
  caption: [Accelerated PSD profiles for `PCB_CENTER` Z-axis ($b=9$, $zeta=0.05$)]
)<acceleratedpsds>

@acceleratedpsds presents the equivalent PSD corresponding to the full 924-hour endurance profile along with a series of accelerated profiles spanning 1, 1.5, 2, 4, 5, 10, 20, 50, and 100 hours. Each accelerated curve represents the same fatigue damage as the baseline but compressed into a shorter duration. Shorter test times require higher spectral amplitudes to maintain damage equivalence, illustrating the trade-off between test efficiency and severity. This complete set of accelerated profiles was generated for both $b = 8$ and $b = 9$ across all three sensors (`PCB_LEFT`, `PCB_CENTER`, `PCB_TOP`) and all three axes (X, Y, Z), yielding nine independent test specifications to evaluate the influence of the fatigue exponent and capture the full vibrational behavior of the backend PCB.

== Response Spectrum Validation

To ensure that the accelerated PSD does not introduce unrealistically high dynamic responses, the profile is validated using response spectra computed from single-degree-of-freedom (SDOF) oscillators across the frequency of interest. Two complementary metrics are used, the Shock Response Spectrum (SRS) and the Extreme Response Spectrum (ERS).

=== Shock Response Spectrum Calculation

The SRS represents the maximum absolute acceleration response of an SDOF oscillator subjected to the excitation. The calculation of SRS is explained in @srs. The maximax SRS convention is adopted in this work, meaning the peak of peak values across events @lalanne2014_mechanical_shock. For numerical implementation, the well established recursive algorithm of Smallwood (1981) @smallwood1981_improved_srs is used, which provides an efficient and stable way to compute the SRS for arbitrary time histories. @srsenvelopecheese shows the SRS of all the channels and axes of the shock event, which is the blending of 400 grams of Grana Padano cheese in Thermomix#super(sym.trademark.registered) TM7.

=== Extreme Response Spectrum Calculation

The Extreme Response Spectrum (ERS) is used to estimate the expected peak absolute acceleration response of a family of base-excited SDOF oscillators subjected to stationary random vibration. The calculation of ERS in time domain is explained in @ers. However, for stationary Gaussian random signals, the ERS can be computed from PSDs.

For each oscillator with natural frequency $f_0$ and damping $zeta$, the absolute acceleration function is @Newland2012 @Steinberg2000,

$ |H_a(f,f_0)|^2 = (w_0^4+(2 zeta w_0 w)^2) /((w_0^2-w^2)^2+(2 zeta w_0w)^2) $

and the response PSD is,

$ S_(y y)(f,f_0)=|H_a|^2 S_(x x)(f) $

Spectral moments @BendatPiersol2010 @Newland2012,

$ m_n = integral^infinity_0 (2 pi f)^n S_(y y)(f,f_0)d f $

give the RMS response $sigma_y=sqrt(m_0)$

The expected peak is obtained using Vanmarcke's peak-factor model @vanmarcke1972_spectralmoments,

$ k=sqrt(2 ln(v_0 T))+(gamma Epsilon - ln(ln(v_o T)))/(sqrt(2ln(v_0 T))), v_0=1/2pi sqrt(m_2/m_0) $

A bandwidth correction using the irregularity factor,

$ epsilon = 1 - m^2_2/(m_0 m_4) $

prevents unrealistically high peaks for narrowband responses @cartwright1956_maxima @davenport1964_gustloading.

The final ERS is as follows,

$ E R S(f_0)= k(f_0,T)sigma_y(f_0) $

ERS is used to validate accelerated PSD profiles against shock limits, consistent with vibration fatigue guidance in @lalanne2010mechanicalvol.

=== Validation Criterion 

The validation follows the procedure described in @responsespectrumvalidation. To avoid over-testing, the following validation rule is adopted,

$ E R S_(a c c)(f_0) <= S R S(f_0) $

The reference SRS envelope is constructed from the shock event recorded during data acquisition, which is cheese block blending. This event represents the most severe transient load the backend experiences during operation. The SRS is computed using the maximax convention, taking the peak absolute acceleration response at the same damping ratio and frequency grid as the ERS calculation.

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/granapadanopsd_cropped.pdf", encoding: none)
    )
  ],
  caption: [PSDs of Shock Event - Blending of 400 grams of Grana Padano]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/srsenvelopeofcheese_cropped.pdf", encoding: none)
    )
  ],
  caption: [Shock Response Spectrum Envelope of Blending of Grana Padano]
) <srsenvelopecheese>

If the ERS of an accelerated profile remains below the SRS envelope across all frequencies, the profile is validated and can proceed to laboratory testing. If the ERS exceeds the SRS at any frequency, the test duration must be increased to reduce the spectral amplitude, thereby lowering the peak responses while maintaining fatigue damage equivalence. This iterative adjustment ensures that the accelerated test remains representative of field conditions without introducing artificial failure modes.

#let img1 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b8/CENTER_X-1.png")]
#let img2 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b8/CENTER_Y-1.png")]
#let img3 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b8/CENTER_Z-1.png")]
#let img4 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b8/LEFT_X-1.png")]
#let img5 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b8/LEFT_Y-1.png")]
#let img6 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b8/LEFT_Z-1.png")]
#let img7 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b8/TOP_X-1.png")]
#let img8 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b8/TOP_Y-1.png")]
#let img9 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b8/TOP_Z-1.png")]

#show figure: set block(breakable: true)

#subpar.grid(columns: 1, inset: 0em,
  figure(img1, caption: [`PCB_CENTER` X-axis]),<srsvserscenterxaxisb8>,
  figure(img2, caption: [`PCB_CENTER` Y-axis]),<srsvserscenteryaxisb8>,
  figure(img3, caption: [`PCB_CENTER` Z-axis]),<srsvserscenterzaxisb8>,
  figure(img4, caption: [`PCB_LEFT` X-axis]),<srsvsersleftxaxisb8>,
  figure(img5, caption: [`PCB_LEFT` Y-axis]),<srsvsersleftyaxisb8>,
  figure(img6, caption: [`PCB_LEFT` Z-axis]),<srsvsersleftzaxisb8>,
  figure(img7, caption: [`PCB_TOP` X-axis]),<srsvserstopxaxisb8>,
  figure(img8, caption: [`PCB_TOP` Y-axis]),<srsvserstopyaxisb8>,
  figure(img9, caption: [`PCB_TOP` Z-axis]),<srsvserstopzaxisb8>,
  caption: [SRS vs ERS validation for all sensors and axes ($b=8$)],
)



#let img1 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b9/CENTER_X_cropped_page-0001.jpg")]
#let img2 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b9/CENTER_Y_cropped_page-0001.jpg")]
#let img3 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b9/CENTER_Z_cropped_page-0001.jpg")]
#let img4 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b9/LEFT_X_cropped_page-0001.jpg")]
#let img5 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b9/LEFT_Y_cropped_page-0001.jpg")]
#let img6 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b9/LEFT_Z_cropped_page-0001.jpg")]
#let img7 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b9/TOP_X_cropped_page-0001.jpg")]
#let img8 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b9/TOP_Y_cropped_page-0001.jpg")]
#let img9 = box(stroke: black, inset: 0.5em)[#image("../../Images/Plots/SRSvsERSforall/b9/TOP_Z_cropped_page-0001.jpg")]

#show figure: set block(breakable: true)

#subpar.grid(columns: 1, inset: 0em,
  figure(img1, caption: [`PCB_CENTER` X-axis]),<srsvserscenterxaxisb9>,
  figure(img2, caption: [`PCB_CENTER` Y-axis]),<srsvserscenteryaxisb9>,
  figure(img3, caption: [`PCB_CENTER` Z-axis]),<srsvserscenterzaxisb9>,
  figure(img4, caption: [`PCB_LEFT` X-axis]),<srsvsersleftxaxisb9>,
  figure(img5, caption: [`PCB_LEFT` Y-axis]),<srsvsersleftyaxisb9>,
  figure(img6, caption: [`PCB_LEFT` Z-axis]),<srsvsersleftzaxisb9>,
  figure(img7, caption: [`PCB_TOP` X-axis]),<srsvserstopxaxisb9>,
  figure(img8, caption: [`PCB_TOP` Y-axis]),<srsvserstopyaxisb9>,
  figure(img9, caption: [`PCB_TOP` Z-axis]),<srsvserstopzaxisb9>,
  caption: [SRS vs ERS validation for all sensors and axes ($b=9$)],
)


The validation results from @srsvserscenterxaxisb8 through @srsvserstopzaxisb8 (for $b=8$) and @srsvserscenterxaxisb9 through @srsvserstopzaxisb9 (for $b=9$) confirm that the majority of accelerated profiles remain within acceptable severity limits across all sensor locations and axes. For most channels, even the most aggressive 1 hour test duration produces ERS values that stay below the SRS envelope, validating these profiles for laboratory testing without risk of overtesting. However, the `PCB_TOP` X-axis location exhibits notably higher dynamic response amplification. At this location, accelerated profiles shorter than 10 hours exceed the reference shock severity, indicating that the combination of structural amplification and acceleration factor would introduce unrealistic loading conditions. Consequently, only the 10 hour profile and longer durations are validated for this channel. This constraint reflects the proximity of `PCB_TOP` to a structural antinode where modal amplification is particularly pronounced, resulting in elevated response levels that limit the achievable acceleration factor while maintaining damage equivalence without overtesting.