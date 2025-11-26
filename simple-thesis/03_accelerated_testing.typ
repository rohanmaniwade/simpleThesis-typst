#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

#pagebreak()

= State of the Art
Accelerated testing aims to reduce test duration while preserving the same failure mechanisms as in service. Various methodologies exist, ranging from classical endurance approaches to modern vibration-based spectral methods.

Accelerated testing has evolved through several methodological streams that differ by failure mechanism focus (statistical life modelling, stress–life acceleration, random vibration damage equivalence, resonance‑based reduction, and spectrum tailoring).

== Statistical accelerated life models
Nelson (1980) @nelson2009accelerated formalised maximum‑likelihood analysis procedures for step‑stress accelerated life data, enabling estimation of life distribution parameters under varying stresses. Rotem (1981) @rotem1981accelerated proposed a progressive (ramping) stress‑amplitude fatigue method that increases amplitude monotonically with cycle count to reduce specimen count and test duration while still invoking Miner’s cumulative damage rule. These methods support parametric life prediction but provide limited direct guidance for constructing vibration PSD inputs for complex multi‑modal assemblies.

== Stress–life acceleration relations
Basquin (1910) @oh1910exponential introduced what is often paraphrased as the “exponential law of endurance,” and the Inverse Power Law (IPL) subsequently became a standard means to relate elevated stress (including vibration Grms) to reduced life in procedures such as MIL‑STD‑810G @nagle2010test. The conventional single‑exponent IPL loses accuracy for materials or assemblies exhibiting multi‑segment (kneed) S–N behaviour. Ge et al. (2022) @ge2022improved proposed an improved IPL (IIPL) with correction terms that significantly reduce prediction error for alloys such as 6061‑T6 and AZ31B‑F. While these formulations are valuable for scalar stress escalation, they do not encode frequency content or multi‑axis interaction inherent in operational vibration.

== Random vibration acceleration and statistical characterisation
Wang & Wang (2018) @wang2018accelerated related life directly to RMS acceleration curves, extracting scaling factors without strict reliance on generic inverse power modelling. Earlier, Wang & Wang (2017) @wang2017accelerated advanced PSD‑based tailoring methods for transport packaging applications. Jiang et al. (2015) @jiang2015experimental designed accelerated random vibration fatigue experiments combining Gaussian and non‑Gaussian excitation and validated life predictions against WAFO simulations. Jiang et al. (2022) @jiang2021non extended this line by incorporating higher‑order statistics (skewness, kurtosis) into non‑Gaussian acceleration models to better emulate real service environments. Collectively, these works show that matching only RMS or simple stress exponents can miss higher‑order response features relevant to fatigue.

== Resonance‑ and response‑guided reduction
Česnik et al. (2012) @vcesnik2012uninterrupted implemented uninterrupted resonance tracking, monitoring shifts in natural frequency and damping in real time to maintain approximately constant stress, thereby reducing the number of cycles needed to establish S–N data. This adaptive resonance‑based control emphasises structural dynamics observability but is more applicable to coupon or component characterisation than to synthesising a holistic mission profile spanning multiple interacting subsystems.

== Application‑specific PSD tailoring
Risam et al. (2006) @risam2006methodology presented iterative electrodynamic shaker PSD shaping to converge on field‑representative automotive road usage while correlating rig and road fatigue life. Ge (2000) @ge2000model proposed a Weibull‑based Mean Time to Failure (MTTF) model linking accelerated laboratory vibration for packaging to actual transportation exposure durations. These empirically driven strategies emphasise convergence to measured usage but may lack a unifying damage metric across disparate operating segments.

== Fatigue Damage Spectrum (FDS) driven synthesis
Lalanne (2010) @lalanne2010mechanicalvol formalised a specification development framework in which measured environments are transformed into fatigue damage spectra (FDS). These spectra are enveloped or summed (depending on whether environments act in parallel or sequence) to build a composite target; an accelerated PSD is then synthesised to deliver equivalent cumulative damage in a compressed duration and validated against SRS / ERS envelopes. This frequency‑resolved damage approach bridges operational variability and laboratory reproducibility more directly than scalar stress escalation alone.

== Fundamental Assumptions and Limitations of Accelerated Vibration Testing

Accelerated vibration testing compresses long operational exposure into a shorter laboratory test by either increasing amplitude, adjusting frequency content or editing the excitation environment. While widely applied, these methods rely on several modelling assumptions that introduce unavoidable uncertainty @farrar1999review. Understanding these assumptions is essential for interpreting the results that follow. As noted by Caruso and Dasgupta @caruso1998fundamental, there are no magical analytical models that can predict the life of a complex assembly with complete accuracy. Each model represents only one physical degradation mechanism acting on one specific material under one specific set of conditions. Real assemblies contain many interacting materials and geometries and therefore no single model can fully describe every process that contributes to ageing and fatigue.

Fatigue estimation in vibration testing often uses Miner’s rule @miner1945cumulative. This rule treats fatigue damage as a sum of independent increments and assumes that the number of cycles at each stress level is all that matters. It does not account for interaction between cycles or for the effect of load sequence. These assumptions simplify the physics of crack initiation and growth but do not reflect the full behaviour of components in real operational environments. Miner’s rule should therefore be viewed as a useful approximation rather than a complete physical model.

There is also uncertainty in the fatigue exponent $b$. This exponent is extracted from S-N curves that already contain statistical scatter and depend on material, geometry and failure mode. For printed circuit boards, recommended values fall within a range rather than a single number. As a result, the true exponent cannot be known with certainty and small changes in $b$ can shift the balance between broadband and narrowband contributions to fatigue damage.

Frequency domain fatigue methods introduce additional assumptions. They require the vibration environment to be sufficiently stationary and Gaussian so that power spectral densities and related metrics describe it adequately. Strongly transient or intermittent behaviour cannot be represented fully in this framework. As Farrar and colleagues @farrar1999review pointed out in their review of accelerated testing criteria, condensed spectral methods may miss dynamic effects such as impacts or other nonlinear events that sometimes occur in real operation.

Accelerated vibration tests also rely on the idea that the exaggerated environment does not create failure mechanisms that would not appear in service. If the test conditions are too severe, they can amplify boundary condition uncertainties, fixture transmissibility or modal behaviour to an extent that does not reflect real use. These effects do not make accelerated testing invalid. Instead, they define the range within which accelerated tests remain physically meaningful and where their results can be trusted.

Understanding these assumptions and their consequences is important for applying accelerated vibration methods responsibly. They provide the context for the methodology used in this thesis and guide the interpretation of the validation results that follow.

[PROBABLY ADD THE LIMITATIONS IMAGES HERE]



