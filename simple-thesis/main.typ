// main.typ
#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "template.typ": thesis
#include "../title.typ"

#muchpdf(
  read("../Sperrvermerk_prof.pdf", encoding: none)
)
#muchpdf(
  read("../Sperrvermerk_Studierende_EN.pdf", encoding: none)
)



#show: doc => thesis(
  //title: "Master's Thesis:
  //Development of a Methodology for Accelerating Vibration Endurance //Tests on Complex Assemblies",
  //author: "Rohan Maniwade",
  //degree1: "Your First Degree",
  //degree2: "Your Second Degree",
  //department: "Your Department",
  //school1: "Your First School",
  //school2: "Your Second School",
  //institution1: "Your First Institution",
  //institution2: "Your Second Institution",
  //advisor: "Your Advisor's Name",
  //date: datetime(year: 2024, month: 1, day: 1,),
  //committee: ("Committee Member 1", "Committee Member 2", "Committee Member 3"),
  // Optional section toggles:
  showSignatures: false,        // true or false
  showCommittee: false,         // true or false
  showDedication: false,        // true or false
  showAcknowledgements: false,  // true or false
  showPublications: false,       // true or false
  publications: (
    [This thesis includes the following publications:],
    [Publication 1. (Year). Title. Journal/Conference. DOI/URL],
    [Publication 2. Authors. "Title." *Venue*, Location, Date.],
  ),
  acronyms: [
    N - Number of cycles to failure \
    #sym.zeta - Damping factor \
    #sym.sigma - Stress \
    b - Parameter b of basquin relationship N #sym.sigma#super[b] = C

  ],
  abstract: [
    #lorem(200)
  ],
  acknowledgements: [
    [Your acknowledgements text here]
  ],
  dedication: [
    [Your dedication text here]
  ],
  doc,
)

#show figure.where(kind: table): set block(breakable: true, sticky: true)

= Introduction

== Problem Statement
Many engineered products operate in complex environments of loads over their service life. This can gradually lead to mechanical fatigue to the point of loss of function. To manage that risk, manufacturers validate and verify their products to meet a specified lifetime in the field. However, conventional endurance testing is lengthy and resource intensive, which makes it hard to iterate and slows down development.

The Thermomix#super[#sym.trademark.registered] TM7, a product of the Vorwerk Group, is affected by vibrational, thermal, and transportational loads that originate from within and outside the product. Inside the company, a combined vibration and thermal endurance profile is used to assure 4,000 field hours of service. Running this complete profile on a complex assembly takes considerable time and effort, which motivates a more efficient approach.

This thesis formulates a methodology to derive an accelerated test profile that reproduces, in a laboratory setting, the fatigue damage and relevant operational loads observed in the field, while reducing test duration. The TM7 serves as the case study; the methodology is intended to generalise to other complex assemblies.

== Thermomix#super[#sym.trademark.registered] TM7
#align(center)[
  #figure(
    image("../../Images/Thermomix_TM7_Product_Photo_MainDeviceSide-scaled.jpeg", width: 120mm),
    caption: [Thermomix#super[#sym.trademark.registered] TM7 @thermomix_tm7_image],
  ))
]

*Thermomix#super[#sym.trademark.registered] TM7* is the latest generation multifunctional cooking appliance by Vorwerk, designed to integrate numerous cooking, mixing, heating, and food-preparation capabilities into a single device.

Key features and specifications,
- Dimensions: 33.6cm #sym.times 25.3cm #sym.times 40.5cm
- Speed range: 40-10700rpm
- Weight: 8.6kg
- Mixing bowl capacity: 2.2L
- Heating power: 1000W
- Motor power: 500W @vorwerk_tm7




== Endurance profile for Thermomix#super[#sym.trademark.registered] TM7
Vorwerk has developed an endurance testing profile for the Thermomix#super[#sym.trademark.registered] TM7 based on usage patterns observed in earlier product generations. If the appliance experiences a characteristic distribution of motor speeds and heating temperatures over 4,000 hours in the field, the qualification test should reproduce that distribution. Accordingly, field data captures how frequently each speed mode is engaged, its average dwell time, and associated temperature ranges. Each mode is therefore assigned a percentage share of the cumulative operating interval.

To shorten development cycles, an accelerated profile is created with approximately the same load. Time and cycle allocations across modes are rebalanced so that essential exposure to critical combinations of speed and temperature is retained while the total laboratory duration is reduced to roughly 800 hours. The resulting schedule still exercises representative operating segments but in a more concentrated form that preserves relevance to real field use.

Even in this accelerated form, the campaign remains lengthy and resource demanding once pauses, handling, and supervision are included. This residual duration highlights a clear need for methods that can achieve additional reduction without sacrificing representativeness.



#let data = from-csv(delimiter: ",", "
000000,-8800,1,4.00,32,16896000
,-4400,1,2.50,20,5280000
,-3100,20,0.50,4,744000
,-2000,25,0.50,4,480000
,-1100,1,0.50,4,264000
,-800,62,0.50,4,192000
,-500,418,0.50,4,120000
,-350,1,0.50,4,84000
,-200,840,1.00,8,96000
,-150,1,0.50,4,36000
,-100,11903,6.00,48,288000
,-70,421,1.00,8,33600
,-40,9287,5.00,40,96000
,0,2713,3.00,24,0
,40,10398,6.00,48,115200
,66,1,2.00,16,63360
,70,44,2.00,16,67200
,80,9,2.00,16,76800
,100,26574,7.00,56,336000
,150,188,2.00,16,144000
,200,10170,4.00,32,384000
,350,195,2.00,16,336000
,500,1528,2.00,16,480000
,800,752,2.00,16,768000
,1100,4389,4.00,32,2112000
,1550,108,2.00,16,1488000
,2000,5924,6.00,48,5760000
,2550,163,2.00,16,2448000
,3100,242,2.00,16,2976000
,4000,126,2.00,16,3840000
,4400,219,2.00,16,4224000
,5100,44,2.00,16,4896000
,5800,196,3.00,24,8352000
,6700,16,2.00,16,6432000
,7600,48,2.00,16,7296000
,8800,16,2.00,16,8448000
,10000,1214,6.00,48,28800000

")

#let bar_n(x) = {
  rect(width: int(x) / 7000000 * 0.85cm, fill: red.lighten(20%), text(fill: black, x))
}

#let bar_p(x) = {
  rect(width: float(x) / 3 * 1cm, fill: green.darken(0%), text(fill: black, x))
}

#let bar_h(x) = {
  rect(width: int(x) /  70 * 1cm, fill: green.darken(0%), text(fill: black, x))
}

#let bar_t(x) = {
  rect(width: int(x) /  5000 * 1cm, fill: red.lighten(20%), text(fill: black, x))
}

#figure(kind: table, caption: [Endurance Motor Load])[
#tblr(columns: 5,
  stroke: black,
  align: center,
  // formatting directives#
  cells((0, 0), colspan: 2,),
  cols(within: "body", 0, align: right, stroke: (right: 0.0em)),
  rows(within: "header", auto, fill: aqua.lighten(60%), hooks: strong),
  rows(within: "header", auto, inset: (y: 0.5em)),
  cols(within: "body", 3, align: left, hooks: bar_p),
  cols(within: "body", -1, align: left, hooks: bar_n),
  cols(within: "body", 4, align: left, hooks: bar_h),
  cols(within: "body", 1, align: left, hooks: bar_t),
    // content
  table.header([Target Speed (rpm)],[Target Speed (rpm)],[Count],[Percentage (%)],[Duration (h)],[Number of cycles (n)]),
  ..data,
)
]


== Objective
The main objective of this thesis is to establish a reliable and efficient methodology for reducing test time during validation of complex assemblies. In our case,  the endurance profile for the Thermomix#super[#sym.trademark.registered] TM7 takes around 800 hours of testing time.

By leveraging the Fatigue Damage Spectrum (FDS) as the link between measured time histories of different modes of the test subject and laboratory test specifications, the study aims to generate equivalent and accelerated Power Spectral Densities (PSDs) that reproduce real operational fatigue damage within a reduced test duration. The methodology will be applied to the main PCBA of Thermomix#super[#sym.trademark.registered] TM7 (further named as the backend) as a representative case study validated through experimental vibration testing and response spectrum criteria following the the works of Christian Lalanne on Specification Development @lalanne2010mechanicalvol and MIL-STD-810G @nagle2010test for test tailoring and test-time compression.

= Accelerated testing
Accelerated testing aims to reduce test duration while preserving the same failure mechanisms as in service. Various methodologies exist, ranging from classical endurance approaches to modern vibration-based spectral methods.

== Literature Review
Accelerated testing has evolved through several methodological streams that differ by failure mechanism focus (statistical life modelling, stress–life acceleration, random vibration damage equivalence, resonance‑based reduction, and spectrum tailoring). The principal published contributions are grouped below, with authors named consistently and years supplied for clarity. For multi‑author works (three or more authors) “et al.” is used uniformly after the first author.

=== Statistical accelerated life models
Nelson (1980) @nelson2009accelerated formalised maximum‑likelihood analysis procedures for step‑stress accelerated life data, enabling estimation of life distribution parameters under varying stresses. Rotem (1981) @rotem1981accelerated proposed a progressive (ramping) stress‑amplitude fatigue method that increases amplitude monotonically with cycle count to reduce specimen count and test duration while still invoking Miner’s cumulative damage rule. These methods support parametric life prediction but provide limited direct guidance for constructing vibration PSD inputs for complex multi‑modal assemblies.

=== Stress–life acceleration relations
Basquin (1910) @oh1910exponential introduced what is often paraphrased as the “exponential law of endurance,” and the Inverse Power Law (IPL) subsequently became a standard means to relate elevated stress (including vibration Grms) to reduced life in procedures such as MIL‑STD‑810G @nagle2010test. The conventional single‑exponent IPL loses accuracy for materials or assemblies exhibiting multi‑segment (kneed) S–N behaviour. Ge et al. (2022) @ge2022improved proposed an improved IPL (IIPL) with correction terms that significantly reduce prediction error for alloys such as 6061‑T6 and AZ31B‑F. While these formulations are valuable for scalar stress escalation, they do not encode frequency content or multi‑axis interaction inherent in operational vibration.

=== Random vibration acceleration and statistical characterisation
Wang & Wang (2018) @wang2018accelerated related life directly to RMS acceleration curves, extracting scaling factors without strict reliance on generic inverse power modelling. Earlier, Wang & Wang (2017) @wang2017accelerated advanced PSD‑based tailoring methods for transport packaging applications. Jiang et al. (2015) @jiang2015experimental designed accelerated random vibration fatigue experiments combining Gaussian and non‑Gaussian excitation and validated life predictions against WAFO simulations. Jiang et al. (2022) @jiang2021non extended this line by incorporating higher‑order statistics (skewness, kurtosis) into non‑Gaussian acceleration models to better emulate real service environments. Collectively, these works show that matching only RMS or simple stress exponents can miss higher‑order response features relevant to fatigue.

=== Resonance‑ and response‑guided reduction
Česnik et al. (2012) @vcesnik2012uninterrupted implemented uninterrupted resonance tracking, monitoring shifts in natural frequency and damping in real time to maintain approximately constant stress, thereby reducing the number of cycles needed to establish S–N data. This adaptive resonance‑based control emphasises structural dynamics observability but is more applicable to coupon or component characterisation than to synthesising a holistic mission profile spanning multiple interacting subsystems.

=== Application‑specific PSD tailoring
Risam et al. (2006) @risam2006methodology presented iterative electrodynamic shaker PSD shaping to converge on field‑representative automotive road usage while correlating rig and road fatigue life. Ge (2000) @ge2000model proposed a Weibull‑based Mean Time to Failure (MTTF) model linking accelerated laboratory vibration for packaging to actual transportation exposure durations. These empirically driven strategies emphasise convergence to measured usage but may lack a unifying damage metric across disparate operating segments.

=== Fatigue Damage Spectrum (FDS) driven synthesis
Lalanne (2010) @lalanne2010mechanicalvol formalised a specification development framework in which measured environments are transformed into fatigue damage spectra (FDS). These spectra are enveloped or summed (depending on whether environments act in parallel or sequence) to build a composite target; an accelerated PSD is then synthesised to deliver equivalent cumulative damage in a compressed duration and validated against SRS / ERS envelopes. This frequency‑resolved damage approach bridges operational variability and laboratory reproducibility more directly than scalar stress escalation alone.

=== Gap and motivation for this work

In Vorwerk, testing time takes up a considerable amount of resources and creates a bottleneck hinder



= Theoretical Background

== Mission Synthesis
=== Origins and Historical Development
Mission Synthesis referes to the methodology of tailoring vibration tests based on actual service (mission) environments, ensuring lab tests produce equivalent damage to real-world usage. The concept emerged in the mid-20th century as engineers sought more realistic test criteria than generic benchmarks. As early as the 1950s, aerospace data were collected from aircraft flights and used to derive vibration test standards

== Fatigue Damage Spectrum (FDS)

*Fatigue Damage Spectrum (FDS)* describes how a single‑degree‑of‑freedom (SDOF) linear system accumulates fatigue damage under a given vibration input as a function of its natural frequency f#sub[0] and an assumed damping ratio #sym.zeta.

The standard calculation relies on the following assumptions:
- The system behaves as a linear SDOF oscillator.
- The S–N curve follows Basquin’s relation ($N#sym.sigma _p^b = C$).
- Peak stress is proportional to the maximum relative displacement ($#sym.sigma _p = K z_p$).
- The rainflow counting method is used to identify stress (displacement) cycles.
- Miner’s damage accumulation rule applies.

If $n_i$ is the number of half‑cycles at amplitude $z_p_i$, then the fatigue damage is given by

$ D=K^b/(2C) sum_(i=1)^m n_i z^b_p_i $

Repeating this evaluation across a sweep of natural frequencies $f_0$ (and for specified values of $zeta$, $b$, $K$, and $C$) yields the _fatigue damage spectrum_ (FDS) $D(f_0)$ of the excitation.

The FDS may be computed from either a time history or a PSD representation, provided the underlying random vibration is stationary and approximately Gaussian @lalanne2010mechanicalvol.

In this work, one‑minute time history segments are sampled, converted to PSD form, and aggregated to estimate cumulative damage over the full operating duration.



nce 

== Extreme Response Spectrum (ERS)
The Extreme Response Spectrum gives, for each natural frequency $f_0$ at damping ζ, the maximum relative displacement response of an equivalent linear SDOF system driven by the input @lalanne2010mechanicalvol.

ERS in displacement form is

$ E R S (f_0, ζ) = max_t | z(t; f_0, ζ) | $

and the scaled acceleration form is

$ E R S _ a (f_0, ζ) = (2pi f_0)^2 max_t | z(t; f_0, ζ) | $

In practice, ERS is computed by filtering the input through a bank of linear SDOF systems across $f_0$ at the chosen damping and then taking the per‑filter maximum of the relative displacement or the corresponding acceleration. ERS assumes linearity and a specified damping ratio. Unlike FDS, it summarises peak response rather than accumulated damage @lalanne2010mechanicalvol.




== Shock Response Spectrum (SRS)

The Shock Response Spectrum characterises a transient shock by the maximum response of a bank of linear SDOF oscillators, each with natural frequency $f_0$ and damping ζ, when subjected to the same base‑excitation time history. In its most common form, the SRS reports the peak absolute acceleration response per $f_0$. Alternative conventions include peak relative displacement and pseudo‑velocity forms that are useful for damage correlation and historical limits @lalanne2010mechanicalvol.

Acceleration form for a base‑excited SDOF is

$ S R S _ a (f_0, ζ) = max_t | a_{abs}(t; f_0, ζ) | $

Here, $a_{abs}(t)$ denotes the absolute acceleration of the mass, which is the sum of base acceleration and the relative component, for the oscillator tuned to $f_0$ at damping ζ under the given shock input. The spectrum is computed by filtering the input through a bank of SDOF filters that span the frequency range of interest and by recording the peak value for each filter @lalanne2010mechanicalvol. We adopt the maximax SRS convention, meaning the peak of peak values across events @lalanne2010mechanicalvol.


== Difference between Extreme Response Spectrum and Shock Response Spectrum
ERS and SRS use the same mathematical device, a bank of linear SDOF oscillators at a chosen damping ratio ζ, equivalently a quality factor $Q ≈ (2 ζ)^(-1)$, to report a peak response versus natural frequency. They differ mainly in the type of input they target and in how the peak is interpreted.

- Input and intent - ERS is used for random long duration vibration. SRS is used for short transients and shocks.
- How the peak is taken - For SRS the largest response may occur during or after the shock. Practice is to take the envelope of the primary and residual responses. For ERS under random excitation peaks are taken over a defined time window or sample. When ERS is derived from a PSD it represents an expected maximum for the specified duration.
- Required representation - SRS is computed from a time history. ERS can be computed from time histories or, under stationarity and Gaussian assumptions, from PSDs.

In this thesis ERS characterises peak response under random profiles. SRS provides the reference envelope for shock severity. @lalanne2010mechanicalvol

== Response spectrum validation

We check peak response consistency by comparing the ERS of each accelerated profile with an SRS envelope that represents a relevant reference shock. The envelope uses the maximax convention. We select a small damping ζ to match structural behaviour and we space frequency points on a logarithmic grid. This confirms that time compression does not introduce unrealistic peaks @lalanne2010mechanicalvol @nagle2010test.

[Add the verification of time reduction images]

= Methodology

== Research Design
#lorem(150) 

== Data Acquisition

=== Vibration Data Acquisition
We begin by measuring vibration at the Thermomix backend printed‑circuit board (PCB). These measurements anchor the accelerated PSDs to real operational responses. For each representative operating mode in the endurance profile (motor speed and thermal state), we record time histories that capture the structural input the backend experiences in service.

=== Accelerometer Placement
We instrument the backend PCB at dynamically critical points. Candidate locations were selected through a modal analysis performed in ANSYS and verified experimentally with an impulse‑hammer test. Based on the resulting mode shapes, we placed accelerometers near antinodes (regions of maximum deformation) while respecting packaging, cable routing, and mass‑loading constraints. This ensures the measured signals are sensitive to resonant amplification yet representative of in‑service response.

To balance constraints with coverage, two mini‑triaxial accelerometers and one triaxial accelerometer were installed at locations that collectively capture the dominant bending and torsional responses of the board.

=== Squadriga - Frontend

== Signal Processing Pipeline

With time histories collected for each operating mode of the Thermomix#super[#sym.trademark.registered], we apply Lalanne’s specification to derive accelerated PSDs that are damage‑equivalent to the field profile while compressing duration. The Python library VibeAccelKit is used for signal processing, test synthesis, and verification.

Because three sensors record along three orthogonal axes, nine accelerated profiles are produced (one per sensor‑axis channel). The pipeline proceeds as follows:

1. Inspect time‑history signals for each mode (visualisation and sanity checks).
2. Convert time histories to Power Spectral Densities (PSDs).
3. Compute the Fatigue Damage Spectrum (FDS) for each mode.
4. Form a composite FDS by summing modal damage contributions weighted by their dwell times in the endurance profile.
5. Invert the composite FDS to an equivalent PSD for the target life duration.
6. Apply time‑compression (via the b‑factor) to derive accelerated PSDs for 1 h, 2 h, 5 h, 10 h, 50 h, and 100 h.
7. Compute the Extreme Response Spectrum (ERS) for each accelerated PSD and compare against the Shock Response Spectrum (SRS) envelope of the reference shock event (e.g., cheese‑blending load) to check severity.


== Accelerated PSD Generation

== Time History Synthesis from PSD

== Validation Procedure

= Experimental Setup
== Test Fixture for the Backend

== 


= Results and Discussion
== Finding 1
#lorem(200)

== Finding 2
#lorem(200)
== Analysis
#lorem(250)

== Implications
#lorem(250)

= Conclusion and Outlook
== Summary
#lorem(150)

== Future Work
#lorem(150)

#bibliography("references.bib", style: "ieee")