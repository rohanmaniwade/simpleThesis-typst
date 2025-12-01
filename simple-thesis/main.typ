// main.typ
#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "@preview/rowmantic:0.4.0": rowtable
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"
#include "../title.typ"

#page[ #set page(numbering: none)]

#muchpdf(
  read("../Sperrvermerk_updated_prof_signed.pdf", encoding: none)
)

#page[ #set page(numbering: none)]

#muchpdf(
  read("../Sperrvermerk_Studierende_EN_signed.pdf", encoding: none)
)

#page[ #set page(numbering: none)]


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
  showDedication: true,        // true or false
  showAcknowledgements: true,  // true or false
  showPublications: false,       // true or false
  publications: (
    [This thesis includes the following publications:],
    [Publication 1. (Year). Title. Journal/Conference. DOI/URL],
    [Publication 2. Authors. "Title." *Venue*, Location, Date.],
  ),
  dedication: [
    #set text(font: "Times New Roman", size: 12pt)
    
    _To humanity and its everlong pursuit of understanding vibration, to every creature born from entropy that shapes our universe, and to white monsters for fueling me along the way._

  ],
  acronyms: [

*Symbols*

#show figure: set block(breakable: true)

#set table(stroke: none)
#tblr(
    rows(0, stroke: (bottom: 1pt), hooks: strong),
    align: (center),
    column-gutter: 1em,
    row-gutter: 1em,
    content-hook: rowtable.with(table: arguments),
    [Symbol & Meaning & Unit],
    [$a$ & Linear scaling coefficient & -],
    [$a_{abs}(t)$ & Absolute acceleration & $m/s^2$],
    [$b$ & Basquin exponent & -],
    [$C$ & Material constant in Basquin's law & -],
    [$D$ & Cumulative fatigue damage & -],
    [$F$ & Time Compression Factor & -],
    [$dot.double(x)_(r m s)$ & RMS acceleration & $m/s^2$],
    [$dot.double(x)_(r m s, f i e l d)$ & RMS acceleration (field) & $m/s^2$],
    [$dot.double(x)_(r m s, t e s t)$ & RMS acceleration (test) & $m/s^2$],
    [$f$ & Frequency & $H z$],
    [$f_0$ & Natural frequency & $H z$],
    [$G_(f i e l d)$ & PSD level in field & $(m/s^2)^2/(H z)$],
    [$G_(t e s t)$ & PSD level in test & $(m/s^2)^2/(H z)$],
    [$H$ & SDOF transfer function & -],
    [$K$ & Stiffness constant relating stress to displacement & $N/m$],
    [$k$ & Peak factor (Vanmarcke model) & -],
    [$m$ & Number of stress levels & -],
    [$m_0$ & Spectral moments (orders 0) & $(m/s^2)^2$],
    [$m_2$ & Spectral moment (order 2) & $(m/s^2)^2·(H z)^2$],
    [$m_4$ & Spectral moment (order 4) &  $(m/s^2)^2·(H z)^4$],
    [$N$ & Number of cycles to failure & cycles],
    [$N_f$ & Cycles to failure at given stress & cycles],
    [$N_i$ & Number of cycles at stress level i & cycles],
    [$n_i$ & Number of applied cycles at stress level i & cycles],
    [$Q$ & Quality factor & -],
    [$r_i$ & Frequency ratio (experimental to simulated) & -],
    [$S_(a a)$ & Acceleration power spectral density & $(m/s^2)^2/(H z)$],
    [$s(f)$ & Frequency-dependent scaling factor & -],
    [$T_(e q)$ & Equivalent test duration & hours],
    [$T_(f i e l d)$ & Field operation duration & hours],
    [$T_(t e s t)$ & Laboratory/test duration & hours],
    [$v_p$ & Peak frequency (from spectral moments) & $H z$],
    [$z$ & Relative displacement & $m$],
    [$z_p$ & Peak relative displacement & $m$],
    [$z_(p,i)$ & Peak displacement amplitude at level i & $m$],
    [$alpha$ & Under-relaxation factor & -],
    [$gamma$ & Euler–Mascheroni constant & -],
    [$Gamma$ & Gamma function & -],
    [$epsilon$ & Irregularity factor (bandwidth correction) & -],
    [$zeta$ & Damping ratio & -],
    [$nu_0$ & Mean zero-crossing rate & $1/s$],
    [$nu_p$ & Mean peak rate & $1/s$],
    [$sigma$ & Stress & $P a$],
    [$sigma_a$ & Stress amplitude & $P a$],
    [$sigma_f$ & Fatigue strength coefficient & $P a$],
    [$sigma_p$ & Peak stress & $P a$],
    [$sigma_(r m s)$ & RMS stress & $P a$],
  )

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
    WAFO - Wave Analysis for Fatigue and Ocean \
    MIL-STD-810 - Military standard \
    ICP - Integrated Circuit Piezoelectric \
  ],
  abstract: [

This thesis presents a method for accelerating vibration endurance testing by creating a laboratory Power Spectral Density, or PSD, that reflects the vibration loads experienced during real operation. The approach begins with time-domain measurements taken from the Thermomix#super(sym.trademark.registered) TM7 backend printed circuit board during normal use. These measurements are converted into individual and combined Fatigue Damage Spectra, which describe how different frequencies contribute to material fatigue. The combined spectrum is then used to generate an accelerated PSD that produces the same level of damage in a shorter time.

A Python library VibeAccelKit was developed to calculate the spectra, construct the combined fatigue profile, and create the accelerated test PSD. The workflow also includes validation through fatigue damage comparison and through shock and energy response spectra. The final PSD was tested on a uniaxial shaker to evaluate how well the laboratory environment reproduced the critical vibration content found in the real machine.

The results show that the method can recreate the important damaging frequencies while significantly reducing total test duration. The presented workflow offers a practical and repeatable way to translate operational vibration into a meaningful endurance test for complex electronic assemblies.
  ],
  acknowledgements: [
    _First and foremost, I would like to thank my supervisor and mentor, *Clément Corselli*, for his invaluable teachings, for believing in me, and for consistently bringing out the best in me. I would also like to thank *Dr.-Ing. Philipp Ingelath* and *Dr. Roland Kraus* for the wisdom and guidance that made it possible to carry out my thesis as smoothly and efficiently as I did, and *Chris Sensor* from Siemens US for his helpful discussions and technical input, which helped steer this work in the right direction._

    _My deepest gratitude to *Prof. Dr.-Ing. Bettar Ould el Moctar* for supervising the academic side of this work, and to *Dr.-Ing. Galal Galal* for his insights and encouragement throughout the project._

    _I thank my mother, sister, and grandparents for their unwavering support. I could not have come to Germany or been blessed with the opportunities I’ve had without them. Last but not least, I would like to thank my friends and *Diana*, my love, all of whom listened to my incessant rambling about Fatigue Damage Spectrum and vibration when they really didn’t have to._

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

#include "09_resultsanddiscussion.typ"

#include "10_conclusion.typ"

#include "11_futurework.typ"

#include "-1_Appendix.typ"


#pagebreak()

#bibliography("references.bib", style: "ieee")