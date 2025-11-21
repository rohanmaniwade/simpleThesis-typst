// main.typ
#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "@preview/rowmantic:0.4.0": rowtable
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"
#include "../title.typ"

#muchpdf(
  read("../Sperrvermerk_prof.pdf", encoding: none)
)
#muchpdf(
  read("../Sperrvermerk_Studierende_EN_signed.pdf", encoding: none)
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
    *Mathematical Symbols* \
    #sym.zeta - Damping ratio \
    #sym.sigma - Stress \
    #sym.sigma#sub[a] - Stress amplitude \
    #sym.sigma'#sub[f] - Fatigue strength coefficient \
    b - Basquin exponent (fatigue parameter) \
    C - Material constant in Basquin's law \
    D - Cumulative fatigue damage \
    f - Frequency \
    f#sub[0] - Natural frequency \
    Q - Quality factor \
    K - Stiffness constant relating stress to displacement \
    N - Number of cycles to failure \
    N#sub[f] - Cycles to failure at given stress \
    N#sub[i] - Number of cycles at stress level i \
    n#sub[i] - Number of applied cycles at stress level i \
    m - Number of stress levels \
    z - Relative displacement \
    z#sub[p] - Peak relative displacement \
    z#sub[p,i] - Peak displacement amplitude at level i \
    T#sub[field] - Field operation duration \
    T#sub[test] - Laboratory test duration \
    T#sub[acc] - Accelerated test duration \
    T#sub[eq] - Equivalent test duration \
    G#sub[test] - PSD level in test \
    G#sub[field] - PSD level in field \
    #sym.alpha - Under-relaxation factor \
    H - SDOF transfer function \
    S#sub[aa] - Acceleration power spectral density \
    $dot.double(x)$#sub[rms] - RMS acceleration \
    k - Peak factor (Vanmarcke model) \
    #sym.gamma - Euler-Mascheroni constant \
    #sym.Gamma - Gamma function \
    #sym.epsilon - Irregularity factor (bandwidth correction) \
    #sym.nu#sub[0] - Mean zero-crossing rate \
    #sym.nu#sub[p] - Mean peak rate \
    m#sub[0], m#sub[2], m#sub[4] - Spectral moments \
    #sym.sigma#sub[rms] - RMS stress \
    r#sub[i] - Frequency ratio (experimental to simulated) \
    s(f) - Frequency-dependent scaling factor \
    a - Linear scaling coefficient \
    C - Time compression factor \
    \ 
    *Acronyms* \
    PCB - Printed Circuit Board \
    PSD - Power Spectral Density \
    FDS - Fatigue Damage Spectrum \
    ERS - Extreme Response Spectrum \
    SRS - Shock Response Spectrum \
    MRS - Maximum Response Spectrum \
    SDOF - Single Degree of Freedom \
    RMS - Root Mean Square \
    CAD - Computer-Aided Design \
    FEM - Finite Element Method \
    IHT - Impulse Hammer Test \
    IGBT - Insulated-Gate Bipolar Transistor \
    MOSFET - Metal-Oxide-Semiconductor Field-Effect Transistor \
    TRIAC - Triode for Alternating Current \
    IPL - Inverse Power Law \
    IIPL - Improved Inverse Power Law \
    EMI - Electromagnetic Interference \
    BOM - Bill of Materials \
    CW - Clockwise \
    CCW - Counter-Clockwise

  ],
  abstract: [

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

#set math.equation(numbering: "(1)")



#include "01_introduction.typ"

#include "02_objective.typ"

#include "03_accelerated_testing.typ"

#include "04_theoretical_background.typ"

#include "05_data_acquisition.typ"

#include "06_signal_processing.typ"

#include "07_experimental_setup.typ"

#include "08_shaker_tests.typ"

= Results and Discussion



== Finding Nemo

== Finding Dory
== Analysis

== Implications

= Conclusion and Outlook
== Summary

== Future Work

#pagebreak()

#include "-1_Appendix.typ"

#bibliography("references.bib", style: "ieee")