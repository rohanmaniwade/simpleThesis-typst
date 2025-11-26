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

#pagebreak()

== Fundamental Assumptions and Limitations of Accelerated Vibration Testing

#show figure: set block(breakable: true)

#let img1 = box(stroke: black, inset: 0.5em, width: 70mm)[#image("../../Images/whatwehopewecanlearnfromanacceleratedtestprediction.png")]

#let img2 = box(stroke: black, inset: 0.5em, width: 70mm)[#image("../../Images/thebestwecanhopefor.png")]

#let img3 = box(stroke: black, inset: 0.5em, width: 70mm)[#image("../../Images/inotherwords.png")]

#subpar.grid(columns: 1, inset: 0.5em,
    figure(img1, caption: [What is expected from an accelerated test model]),<uncertainty1>,
    figure(img2, caption: [What should actually be expected]),<uncertainty2>,
    figure(img3, caption: [The best we can get]),<uncertainty3>,
caption: [Uncertainties in Life Prediction Models @caruso1998fundamental],
)

Accelerated vibration testing compresses long operational exposure into a shorter laboratory test by increasing amplitude, adjusting frequency content or editing the environment @farrar1999review. These methods are powerful, but they rest on simplifying assumptions that must be understood before interpreting any results. As noted by Caruso and Dasgupta @caruso1998fundamental, there are no magical analytical models that can predict the life of a complex assembly with complete accuracy. Each model captures only one degradation mechanism acting on one material in one set of conditions, while real assemblies contain many interacting materials and geometries. No single model can therefore describe every process that contributes to ageing and fatigue.

Fatigue estimation often uses Miner’s rule @miner1945cumulative, which treats damage as a sum of independent increments and assumes that the order of cycles does not matter. This simplifies the physics of crack initiation and growth but does not reflect nonlinear or sequence dependent behaviour that may occur in real service. The fatigue exponent $b$ introduces further uncertainty because it is taken from S-N data with inherent scatter. For printed circuit boards the exponent lies within a range rather than a precise value, and small changes can shift the balance between broadband and narrowband contributions to damage.

Frequency domain fatigue methods add their own assumptions. They require the vibration environment to be stationary and Gaussian so that power spectral densities describe it adequately. Strongly transient or intermittent events cannot be represented in this framework, and condensed spectral methods may miss dynamic effects such as impacts or other nonlinear responses @farrar1999review. Accelerated environments must also avoid creating failure mechanisms that would not appear in service. Excessive acceleration can magnify fixture transmissibility, boundary condition sensitivity or modal amplification beyond what occurs in real operation.

@uncertainty1 through @uncertainty3 from Caruso and Dasgupta @caruso1998fundamental illustrate this idea clearly. A formula that appears precise is actually built from estimated averages, material constants and assumed operating ranges. The output is therefore an informed estimate rather than an exact answer. Accelerated test models cannot deliver an exact equivalence between test cycles and service cycles because every term in the underlying physics of failure representation carries uncertainty.

These limitations do not make accelerated testing unreliable. They define the range within which accelerated methods remain physically meaningful and where their results can be trusted. Recognising these assumptions provides the context for the methodology used in this thesis and for the interpretation of the validation results that follow.






