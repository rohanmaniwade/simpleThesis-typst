#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

= Theoretical Background

== Fatigue Damage in Vibration Testing

Fatigue damage prediction is essential for designing components that can handle repeated loading over their service life, especially in environments where vibration is a major factor. Predicting fatigue life relies heavily on Miner’s law for cumulative damage, Basquin’s Law for stress-life relationships, and the S-N curve for visualising how materials withstand cycles at different stress levels.

=== Palmgren-Miner Rule for Fatigue Damage Equivalence

Miner's law, also known as the Palmgren-Miner rule, helps engineers estimate when a material will fail under varying stress cycles by quantifying fatigue damage accumulation. According to this rule, each stress cycle consumes a fraction of the total fatigue life, and failure occurs when the sum of these fractions equals one,

$ D=sum^n_"i=1" n_i/N_i $

where $n_i$ is the number of cycles at stress level $i$, and $N_i$ is the number of cycles to failure at that level. Miner's law provides a practical way to condense a lifetime's worth of damage into an accelerated lab test, but it does assume that each cycle contributes independently to failure. Real materials sometimes deviate due to load sequence effects or nonlinear damage accumulation, a limitation explored in more advanced research @Palmgren1924 @miner1945cumulative.

=== Basquin's Law 
Basquin’s law describes the relationship between the amplitude of cyclic stress and the number of cycles to failure, especially important for high-cycle fatigue scenarios. It is typically given as a power law,

$ sigma_a = sigma'_f (2N_f)^b $

Here, $sigma_a$ is the stress amplitude, $sigma'_f$ is the fatigue strength coefficient, $N_f$ is the cycles to failure, and $b$ is a negative exponent that reflects the sensitivity of fatigue life to stress changes. Even a small increase in stress can sharply decrease fatigue life, depending on the material's $b$ exponent. Basquin’s law is widely used to fit experimental fatigue data and model S-N curves @oh1910exponential.

=== S-N curve

#figure(
box(stroke: 1pt + black, inset: 5pt)[
  #image("../../Images/sncurve.svg", width: 100mm)
],
caption: [S-N curve @Suresh1998],
)

The S-N curve, or Wöhler curve, is a log-log plot of stress amplitude versus cycles to failure. It provides a clear picture of how materials behave under repeated loading, revealing the reduction in life as stress increases. The concept originated in the mid 19th century through the pioneering work of August Wöhler, a German railway engineer who conducted systematic fatigue tests on railway axles to study their failure mechanisms under cyclic loading. His experiments involved applying alternating stresses to metal components and observing the number of cycles to failure, laying the foundation for modern fatigue testing @Suresh1998.

The S-N curve typically exhibits two distinct regions. In the high stress, low cycle region, materials fail quickly after a small number of cycles. In the low stress, high cycle region, materials can withstand millions of cycles before failure. For many steels and ferrous metals, the S-N curve flattens at low stress levels, reaching what is called the endurance limit or fatigue limit. Materials operating below this threshold can theoretically withstand infinite cycles without failure. However, aluminum and many non-ferrous metals lack a defined endurance limit and will eventually fail even at very low stress levels @Suresh1998. S-N curves are constructed experimentally and typically fitted using Basquin’s law. This approach helps engineers create test profiles that reflect real use conditions in a compressed timeframe @Juvinall2012 @Suresh1998.

Miner's law lets engineers sum damage from diverse stress cycles, Basquin’s law predicts fatigue life as a function of stress amplitude, and S-N curve visualises material performance under varying conditions. These tools are foundational for accelerated vibration testing strategies, ensuring components are reliable and safe without unnecessary over-testing @Pook2007.

== Mission Synthesis

The concept of mission synthesis originates from the need to reproduce the fatigue damage experienced by structures in real operational environments within shorter laboratory tests. After World War II, engineers in aerospace and defense realised that many standardised tests defined by conservative envelopes either undertested or overtested components. Early studies on fatigue, such as Basquin’s stress-life relationship (1910) @oh1910exponential or Miner’s linear cumulative damage hypothesis (1945), provided a mathematical foundation to link cyclic loading with fatigue life @miner1945cumulative.

=== Test Tailoring Procedure

Lalanne @lalanne2010mechanicalvol defines _test tailoring_ as the structured process of creating test specifications directly from a product's life cycle profile and its real environment data, rather than from fixed standard envelopes. This approach is consistent with modern standards such as GAM.EG13 and MIL-STD-810F/G, and STANAG 4370 (AECTP 400), which all require that mechanical and climatic tests reflect measured service conditions rather than arbitrary limits.


#figure(
box(stroke: 1pt + black, inset: 25pt, radius: 3pt)[
  #image("../../Images/general_tailoring_procedure.svg", width: 100mm)
],
caption: [General Tailoring Procedure @lalanne2010mechanicalvol],
) <general_tailoring_procedure>


According to Lalanne, tailoring consists of four principal stages,

+ Analysis of the life cycle profile -- Identify and divide the product's operational life into "situations", each representing a distinct environment (e.g., storage, transport, flight, operation). Each situation is further broken into events of sub-situations (e.g., take-off, cruise, landing), characterised qualitatively by factors such as vibration type, shock, temperature, acoustics.
+ Collection of real environment data -- Quantify each situation using measured time histories of PSDs. Parameters include vibration amplitudes, temperature ranges, and durations.
+ Synopsis of data -- The collected data from all events within a situation are condensed into representative spectra,
  - Compute Shock Response Spectra (SRS) for shock events.
  - Compute Extreme Response Spectra (ERS) and Fatigue Damage Spectra (FDS) for vibration events.
  - Determine statistical descriptors such as the mean, standard deviation, and variation coefficient for each frequency band.
  - Combine the results - for shocks, by enveloping all SRS curves anf for vibrations, by summing FDS curves and enveloping ERS curves. 
  - The result of this stage is one representative set of spectra per situation - an SRS, an ERS, and an FDS.
+ Establishment of the test program -- From the composite FDS of the life profile, generate a test spectrum that reproduces the same cumulative fatigue damage in a shorter, laboratory-controlled time. Apply test factors that account for sample size, confidence level, and the probability of failure.

This procedure ensures that the resulting test is representative, traceable, efficiently accelerated and severe enough to reproduce service damage without introducing unrealistic loads.

=== Fatigue Damage Spectrum (FDS) <fds>

*Fatigue Damage Spectrum (FDS)* describes how a single‑degree‑of‑freedom (SDOF) linear system accumulates fatigue damage under a given vibration input as a function of its natural frequency f#sub[0] and an assumed damping ratio #sym.zeta.

The standard calculation relies on the following assumptions:
- The system behaves as a linear SDOF oscillator.
- The S–N curve follows Basquin’s relation ($N#sym.sigma _p^b = C$).
- Peak stress is proportional to the maximum relative displacement ($#sym.sigma _p = K z_p$).
- The rainflow counting method is used to identify stress (displacement) cycles.
- Miner’s damage accumulation rule applies.

#figure(
    box(stroke: 1pt+black)[
      #image("../../Images/fds.png", width: 130mm)
    ], caption: [Fatigue Damage Spectrum @SiemensFDSImage]
  ) <fatiguedamagespectrum>

If $n_i$ is the number of half‑cycles at amplitude $z_p_i$, then the fatigue damage is given by

$ D=K^b/(2C) sum_(i=1)^m n_i z^b_p_i $  <fatiguedamage>

Repeating this evaluation across a sweep of natural frequencies $f_0$ (and for specified values of $zeta$, $b$, $K$, and $C$) yields the _fatigue damage spectrum_ (FDS) $D(f_0)$ of the excitation.

The FDS may be computed from either a time history or a PSD representation, provided the underlying random vibration is stationary and approximately Gaussian @lalanne2010mechanicalvol.

In this work, one‑minute time history segments are sampled, converted to PSD form, and aggregated to estimate cumulative damage over the full operating duration.

=== Extreme Response Spectrum (ERS) <ers>
The Extreme Response Spectrum gives, for each natural frequency $f_0$ at damping ζ, the maximum relative displacement response of an equivalent linear SDOF system driven by the input @lalanne2010mechanicalvol.

ERS in displacement form is

$ E R S (f_0, ζ) = max_t | z(t; f_0, ζ) | $

and the scaled acceleration form is

$ E R S _ a (f_0, ζ) = (2pi f_0)^2 max_t | z(t; f_0, ζ) | $

In practice, ERS is computed by filtering the input through a bank of linear SDOF systems across $f_0$ at the chosen damping and then taking the per‑filter maximum of the relative displacement or the corresponding acceleration. ERS assumes linearity and a specified damping ratio. Unlike FDS, it summarises peak response rather than accumulated damage @lalanne2010mechanicalvol.

=== Shock Response Spectrum (SRS) <srs>

The Shock Response Spectrum characterises a transient shock by the maximum response of a bank of linear SDOF oscillators, each with natural frequency $f_0$ and damping ζ, when subjected to the same base‑excitation time history. In its most common form, the SRS reports the peak absolute acceleration response per $f_0$. Alternative conventions include peak relative displacement and pseudo‑velocity forms that are useful for damage correlation and historical limits @lalanne2014_mechanical_shock.

Acceleration form for a base‑excited SDOF is

$ S R S _ a (f_0, ζ) = max_t | a_{abs}(t; f_0, ζ) | $ <shockresponsespectrumcalc>

Here, $a_{abs}(t)$ denotes the absolute acceleration of the mass, which is the sum of base acceleration and the relative component, for the oscillator tuned to $f_0$ at damping ζ under the given shock input. The spectrum is computed by filtering the input through a bank of SDOF filters that span the frequency range of interest and by recording the peak value for each filter.

=== Difference between Extreme Response Spectrum and Shock Response Spectrum
ERS and SRS use the same mathematical device, a bank of linear SDOF oscillators at a chosen damping ratio ζ, equivalently a quality factor $Q ≈ (2 ζ)^(-1)$, to report a peak response versus natural frequency. They differ mainly in the type of input they target and in how the peak is interpreted.

- Input and intent - ERS is used for random long duration vibration. SRS is used for short transients and shocks.
- How the peak is taken - For SRS the largest response may occur during or after the shock. Practice is to take the envelope of the primary and residual responses. For ERS under random excitation peaks are taken over a defined time window or sample. When ERS is derived from a PSD it represents an expected maximum for the specified duration.
- Required representation - SRS is computed from a time history. ERS can be computed from time histories or, under stationarity and Gaussian assumptions, from PSDs.

In this thesis ERS characterises peak response under random profiles. SRS provides the reference envelope for shock severity. @lalanne2010mechanicalvol


=== Test Time Compression

Reducing vibration test time is achieved by compressing the lifetime damage occuring in the field into a shorter, more intense laboratory test. The time compression formula is grounded in Miner’s rule @miner1945cumulative, where the total accumulated fatigue damage should be equivalent for both the accelerated and real-world scenario. 

If a component is expected to undergo a random vibration profile for $T_"field"$ hours in the real world, and the damage accumulation formula indicates the total damage incurred at the original severity, we can increase the input vibration's severity (RMS value) so the same damage happens in a shorter time period $T_"test"$.

To compute the new laboratoxry test time, one uses the following relationship, 

$ dot.double(x)_"rms test"= dot.double(x)_"rms field" (T_"field"/T_"test")^(1/b) $ <timereductionacc>

and for power spectral density G, we have,

$ G_"test"= G_"field" (T_"field"/T_"test")^(2/b) $  <timecompression>

where $T_"field"$ is real life duration, $T_"test"$ is the planned acceleration test duration, $dot.double(x)_"rms test"$, $dot.double(x)_"rms field"$ $G_"test"$, and $G_"field"$ are PSD levels and acceleration rms in test and field environments respectively, and $b$ is the Basquin’s exponent which is unique to each material.

For example, if the test RMS is doubled and $b=8$ for typical solder joints, the time compression factor is $C=2^8=256$, meaning a 256-hour field duration can theoretically be simulated in a 1 hour test. @nagle2010test @lalanne2010mechanicalvol.

=== Limits of Time Compression <limitsoftimecompression>

Achieving effective test time reduction while maintaining realistic severity requires careful attention to several critical factors. The compression must accurately represent real world conditions without introducing artificial failures or missing genuine failure modes.

The most important consideration is selecting an appropriate value for the material exponent $b$. This parameter should be as close as possible to the actual material behavior, and when uncertain, conservative default values should be used. The accuracy of $b$ directly affects the validity of the time compression calculation.

Physical limits constrain how much compression is practically achievable. The excitation level cannot exceed the material's ultimate strength, which typically limits the amplification factor to 2 or 3 times the fatigue limit for most materials. While this constraint may seem restrictive, it can still enable substantial time reduction. For an amplification factor of 2, the maximum achievable compression varies significantly with the material exponent, as shown in @testtimereduction.

#figure(kind: table, caption: [Maximum limit for test time reduction according to material exponent $b$ @lalanne2010mechanicalvol])[
  #tblr(columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  inset: 1em,
  rows: 2,
  stroke: 0.05em,
  table.header([$b$],[_4_],[_6_],[_8_],[_9_],[_10_],[_14_],[$T_(f i e l d)/T_(t e s t)$],[_16_],[_64_],[_256_],[_640_],[_1024_],[_16384_]),
)
]<testtimereduction>

Poorly controlled time reduction can create artificial problems that do not exist under normal operating conditions. Several risks must be avoided,

- Maximum stress levels may exceed the ultimate strength limit, creating failure modes that never occur at real operating levels. This leads to false failures that do not represent actual service conditions.
- Equipment containing mechanical clearances may experience shocks under high acceleration that would not appear at normal levels, or would be much smaller in magnitude. These artificial impacts can dominate the test results and mask the actual failure mechanisms of interest.
- The damage equivalence calculation assumes linear structural behavior, which often breaks down in practice. As stress levels increase beyond the linear range, errors in the amplification factor become more significant, and the shorter the test time, the larger these errors become. This can lead to either overly conservative or non conservative results depending on how the nonlinearities affect the actual structure. @lalanne2010mechanicalvol




=== Response spectrum validation <responsespectrumvalidation>

Peak response consistency is checked by comparing the MRS (Maximum Response Spectrum), also known as ERS (Extreme Response Spectrum), of each accelerated profile with an SRS envelope that represents a relevant reference shock. The envelope uses the maximax convention. A small damping ζ is selected to match structural behaviour and frequency points are spaced on a logarithmic grid. This check confirms that time compression does not introduce unrealistic peaks @lalanne2010mechanicalvol @nagle2010test.

#figure(
    box(stroke: 1pt+black)[
      #image("../../Images/srsvsersvalidationdiagram.png", width: 130mm)
    ], caption: [Criteria for Acceptance of Accelerated Vibration Tests @SiemensMissionSynthesis]
  )

Two outcomes are possible when validating the accelerated profile,

- If the ERS of the accelerated test remains below the SRS of the reference shock event, the test is within acceptable severity limits and can proceed at the specified duration. The accelerated profile does not introduce peak responses beyond what the component would experience in the field.

- If the ERS of the accelerated test exceeds the SRS of the reference shock event, the test may introduce unrealistic peak loads that would not occur during normal operation. In this case, the test duration must be increased to reduce the PSD amplitude, bringing the peak responses back within the envelope defined by the field shock events.