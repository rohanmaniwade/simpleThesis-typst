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
    b - Parameter b of basquin relationship N #sym.sigma#super[b] = C \
    PCB - Printed Circuit Board \
    IGBT - Insulated-Gate Bipolar Transistor \
    MOSFET - Metal-Oxide-Semiconductor Field-Effect Transistor \
    TRIAC - Three-Electrode Semiconductor

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
    [
    #image("../../Images/TM7_wo_background.jpg", width: 100mm)],
    caption: [Thermomix#super[#sym.trademark.registered] TM7 @thermomix_tm7_image],
  ) <thermomix>
]

*Thermomix#super[#sym.trademark.registered] TM7* is the latest generation multifunctional cooking appliance by Vorwerk, designed to integrate numerous cooking, mixing, heating, and food-preparation capabilities into a single device.

Key features and specifications,
- Dimensions: 33.6cm #sym.times 25.3cm #sym.times 40.5cm
- Speed range: 40-10700rpm
- Weight: 8.6kg
- Mixing bowl capacity: 2.2L
- Heating power: 1000W
- Motor power: 500W @vorwerk_tm7

== Backend PCB

#align(center)[
  #figure(
    box(stroke: 0.5pt+black)[
    #image("../../Images/Backend.jpg",width: 120mm)],
    caption: [Backend PCB],
  ) <backend>
]

The backend PCB is the central power and control module of Thermomix#super[#sym.trademark.registered] TM7. It handles mains voltage input, performs power factor correction and DC conversion, controls the motor and heater through embedded microcontrollers, and manages all sensor and actuator interfaces @CoSyBackEndPCB2025. The board brings together high voltage switching devices (IGBTs, MOSFETs, TRIACs), multiple microcontrollers for real time control and communication, and various passive components such as capacitors, inductors, and resistors that handle filtering, regulation, and signal conditioning.

The backend is a multilayer FR4 assembly measuring 220 × 165.5 mm and 1.6 mm thick. Its layout balances competing needs: high current traces and large power components generate concentrated heat that must be managed, while sensitive analog and digital circuits need careful grounding and EMI suppression. This design complexity makes the backend a good representative of modern mixed signal power electronics assemblies found in household appliances.

The backend plays a critical role in system reliability. Motor speed commands, heater regulation, and safety interlocks all depend on it working continuously. Solder joint fatigue, capacitor degradation, or any interconnect failure can cause functional loss. The board experiences mechanical vibration from motor imbalance and blade interaction with liquid, as well as thermal cycling from heater operation, which makes it an ideal test specimen for validating accelerated vibration methods. Its internal resonances, mass distribution, and mounting constraints represent the kinds of complex boundary conditions encountered in real product qualification. This means findings from testing this component can be directly applied to other assemblies within the TM7 and similar appliances.

== Endurance profile for Thermomix#super[#sym.trademark.registered] TM7
Vorwerk has developed an endurance testing profile for the Thermomix#super[#sym.trademark.registered] TM7 based on usage patterns observed in earlier product generations @Vorwerk2025HALT. In normal household use, the appliance experiences a characteristic distribution of motor speeds and heating temperatures over a lifetime of roughly 4,000 hours. To ensure that laboratory testing remains representative of real operation, the qualification profile was designed to reproduce this same distribution.

Field data was analysed to understand how often each speed level is used, how long it typically remains active, and what temperature ranges are associated with these operating modes. Each mode was then assigned a proportional share of the total usage time so that the cumulative exposure during the test reflects actual customer behaviour.

To shorten the development cycle, an accelerated endurance profile was derived that preserves the essential combination of mechanical and thermal loads while reducing the total test duration to around 800 hours. The time and cycle allocation across the various operating modes were adjusted to maintain the same exposure to critical conditions, ensuring that the results remain relevant to field performance.

=== Development Methodology

The endurance profile was developed using a structured, data‑driven approach that ensures a realistic representation of the product’s operation. The statistical distribution of speeds and heating levels observed in the field was aligned with the internal endurance requirements used for product qualification. Both operating time and the total number of revolutions were treated as governing parameters to reproduce fatigue accumulation and mechanical wear patterns.

This approach maintains the balance between duration and load intensity, allowing the test to simulate real‑world stress conditions within a shorter timeframe. The resulting load spectrum captures the essential dynamic characteristics of the motor, including dwell at each speed and the associated vibration behaviour. Minor refinements during physical testing may still be necessary to address effects that are difficult to model in advance.

The statistical distribution of motor speeds and their relative dwell times is summarised in @averagemotorload, which reports the average motor loads observed in customer use. The final row totals approximately 4,000 hours of field operation.

@endurancemotorload lists the qualification schedule derived from this distribution, with motor and heater loads rebalanced for test efficiency. The third‑last and second‑last rows correspond to dough mode (600 rpm) and egg mode (no rotation, heating only). The final row reports the total motor duration, total heater duration, and total number of cycles for the schedule.

#let data = from-csv(delimiter: ",", "
11111111,-8800,1,0.00,0,0
0,-4400,1,0.00,0,0
0,-3100,20,0.02,0.8,148800
0,-2000,25,0.03,1.2,144000
0,-1100,1,0.00,0,0
0,-800,62,0.07,2.8,134400
0,-500,418,0.47,18.8,564000
0,-350,1,0.00,0,0
0,-200,840,0.95,38,456000
0,-150,1,0.00,0,0
0,-100,11903,13.48,539.2,3235200
0,-70,421,0.48,19.2,80640
0,-40,9287,10.52,420.8,1009920
0,0,2713,3.07,122.8,0
0,40,10398,11.78,471.2,1130880
0,66,1,0.00,0,0
0,70,44,0.05,2,8400
0,80,9,0.01,0.4,1920
0,100,26574,30.10,1204,7224000
0,150,188,0.21,8.4,75600
0,200,10170,11.52,460.8,5529600
0,350,195,0.22,8.8,184800
0,500,1528,1.73,69.2,2076000
0,800,752,0.85,34,1632000
0,1100,4389,4.97,198.8,13120800
0,1550,108,0.12,4.8,446400
0,2000,5924,6.71,268.4,32208000
0,2550,163,0.18,7.2,1101600
0,3100,242,0.27,10.8,2008800
0,4000,126,0.14,5.6,1344000
0,4400,219,0.25,10,2640000
0,5100,44,0.05,2,612000
0,5800,196,0.22,8.8,3062400
0,6700,16,0.02,0.8,321600
0,7600,48,0.05,2,912000
0,8800,16,0.02,0.8,422400
0,10000,1214,1.37,54.8,32880000
0,10700,42,0.05,2,1284000
,Total,,99.98,3999.2,116000160

")

#let bar_na(y) = {
  rect(width: int(y) / 10000000 * 1.159cm, fill: gradient.linear(red,white), stroke: red, text(fill: black, y))
}

#let bar_pa(y) = {
  rect(width: float(y) / 10 * 1.03cm, fill: gradient.linear(green,white), stroke: green, text(fill: black, y))
}

#let bar_ha(y) = {
  rect(width: float(y) /  600 * 1.28cm, fill: gradient.linear(green,white), stroke: green, text(fill: black, y))
}

#let bar_ta(y) = {
  rect(width: int(y) /  5000 * 0.9cm, fill: gradient.linear(red,white), stroke: red, text(fill: black, y))
}

#let bar_ua(y) = {
  text(fill: white, y)
}

#figure(kind: table, caption: [Average Motor Load])[
#tblr(columns: 5,
  stroke: black,
  align: center,
  // formatting directives#
  cells((0, 0), colspan: 6),
  cells((1, 0), colspan: 2),
  cols(within: "body", 0, align: right, stroke: (right: 0.0em)),
  cols(within: "body", 1,3,4,5, inset: (x: 0.04em)),
  rows(within: "header", auto, fill: aqua.lighten(60%), hooks: strong),
  rows(within: "header", auto, inset: (y: 0.6em)),
  cells((span(2,-2),3), align: left, hooks: bar_pa),
  cells((span(2,-2),-1), align: left, hooks: bar_na),
  cells((span(2,-2),4), align: left, hooks: bar_ha),
  cells((span(2,-2),1), align: left, hooks: bar_ta),
  cells((span(2,-2),0), align: left, hooks: bar_ua),
  // content
  table.header([Average Motor Load],[],[],[],[],[],[Target Speed (rpm)],[],[Count],[Percentage (%)],[Duration (h)],[Number of cycles (n)]),
  ..data,
)
] <averagemotorload>


=== Heating and Thermal Load

The heating element follows a complementary load profile designed to introduce representative and demanding thermal conditions. Heating is primarily applied at low rotational speeds since high-speed operation already produces significant frictional heating through the interaction of the blades with the water. This targeted strategy increases the load on the heating system while avoiding excessive stress on the motor.

In certain test segments, the bowl is intentionally left without water so that the heating element can reach temperatures above 100 °C. These dry-heating phases are intended to place the heating circuit under additional stress, providing a more complete evaluation of the system’s reliability.

=== Actuator Cycles and Test Sequence

Each endurance cycle consists of 20 minutes of operation followed by a 4-minute pause. During the pause, the actuator completes 20 full movements. Three consecutive cycles form one cycle block, representing approximately one hour of total operation.

For profiles that involve heating in the standard endurance program, the bowl is typically filled with 1.5 litres at the start of each block to compensate for evaporation and spillage through the lid opening, yielding about 1.0 litre working volume. In this thesis, heating and evaporation are not modelled, and all tests are conducted with 1.0 litre of water. This structured repetition of load, rest, and actuation creates a controlled and repeatable simulation of household use, allowing consistent evaluation of long-term durability.

=== Water Evaporation and Energy Considerations

The thermal energy required to evaporate one litre of water is about 2.25 megajoules, which equals roughly 0.625 kilowatt-hours. Most test profiles consume more than this amount of energy per cycle block, meaning that the water is typically fully evaporated within each sequence. This process ensures that a wide range of harmonic and damping effects are present during the endurance test.

In certain configurations, the bowl remains empty and no heating target is applied. These stages are designed to achieve the maximum number of motor revolutions in the given period, placing additional stress on the bearings and rotating components.

In this thesis, heating and evaporation are not modelled, and therefore, the preceding discussion is provided for context only. All measurements are conducted with 1.0 litre of water in the bowl.

#let data = from-csv(delimiter: ",", "
1111000000,-8800,4.00,32,16896000,0,0,0,0
0,-4400,2.50,20,5280000,0,0,0,1
0,-3100,0.50,4,744000,1,4,120,1
0,-2000,0.50,4,480000,1,4,120,1
0,-1100,0.50,4,264000,1,4,120,1
0,-800,0.50,4,192000,1,4,120,1
0,-500,0.50,4,120000,1,4,120,1
0,-350,0.50,4,84000,1,4,120,1
0,-200,1.00,8,96000,1,8,120,1
0,-150,0.50,4,36000,1,4,120,1
0,-100,6.00,48,288000,1,48,120,0
0,-70,1.00,8,33600,1,8,120,1
0,-40,5.00,40,96000,1,40,120,1
0,0,3.00,24,0,1,24,120,1
0,40,6.00,48,115200,1,48,120,1
0,66,2.00,16,63360,1,16,120,1
0,70,2.00,16,67200,1,16,120,1
0,80,2.00,16,76800,1,16,120,1
0,100,7.00,56,336000,1,56,120,1
0,150,2.00,16,144000,1,16,120,1
0,200,4.00,32,384000,1,32,120,1
0,350,2.00,16,336000,1,16,120,1
0,500,2.00,16,480000,1,16,120,1
0,800,2.00,16,768000,1,16,120,1
0,1100,4.00,32,2112000,1,32,120,1
0,1550,2.00,16,1488000,1,16,120,1
0,2000,6.00,48,5760000,1,48,120,1
0,2550,2.00,16,2448000,1,16,160,0
00,3100,2.00,16,2976000,1,16,120,1
0,4000,2.00,16,3840000,0,0,0,1
0,4400,2.00,16,4224000,0,0,0,1
0,5100,2.00,16,4896000,0,0,0,1
0,5800,3.00,24,8352000,0,0,0,1
0,6700,2.00,16,6432000,0,0,0,1
0,7600,2.00,16,7296000,0,0,0,1
0,8800,2.00,16,8448000,0,0,0,0
0,10000,6.00,48,28800000,0,0,0,0
0,10700,0.00,0,0,0,0,0,0
dough mode:,600,5.00,40,1440000,0,0,0,1
egg mode:,0,1.00,8,0,1,8,100,1
,Total,100.0,800,115892160,,540,,



")

#let bar_ne(x) = {
  rect(width: int(x) / 9000000 * 0.54cm, fill: gradient.linear(red,white), stroke: red,text(fill: black, x))
}

#let bar_pe(x) = {
  rect(width: float(x) / 5 * 1.22cm, fill: gradient.linear(green,white), stroke: green, text(fill: black, x))
}

#let bar_te(x) = {
  rect(width: int(x) /  5000 * 0.7cm, fill: gradient.linear(red,white), stroke: red, text(fill: black, x))
}

#let bar_ue(x) = {
text(fill: white, x)
}

#let bar_he(x) = {
  rect(width: int(x) / 40 * 1.23cm, fill: gradient.linear(purple,white), stroke: purple, text(fill: black, x))
}

#figure(kind: table, caption: [Endurance Motor Loads and Heater Loads])[
#tblr(columns: 9, header-rows: 2,
  stroke: black,
  align: center,
  // formatting directives#
  cells((0, 0), colspan: 5),
  cells((0, 5), colspan: 4),
  cells((1, 0), colspan: 2),
  cols(within: "body", 0, align: right, stroke: (right: 0.0em)),
  rows(within: "header", auto, fill: aqua.lighten(60%), hooks: strong),
  rows(within: "header", auto, inset: (x: 0.05em)),
  cols(within: "body", 1,4,2,6, inset: (x: 0.04em)),

  //cols(within: "body", 5, fill: green.lighten(30%)),
  //cols(within: "body", 7, fill: green.lighten(30%)),
  //cols(within: "body", 8, fill: green.lighten(30%)),
  cells((span(2,-2),-4),(span(2,-2),-2),(span(2,-2),-1), fill:green.lighten(30%)),
  cells((span(4, 30),-2), (-2,-2),fill: yellow.lighten(30%)),
  cells((span(2,3),5),(span(-12,-3),5),(-14,(7,8)),((2,12,-4,-5,-6),8), fill: red.lighten(30%)),
  //cols(within: "body", 2, align: left, hooks: bar_pe),
  //cols(within: "body", 4, align: left, hooks: bar_ne),
  //cols(within: "body", -3, align: left, hooks: bar_he),
  cells((span(2,-2),2), align: left, hooks: bar_pe),
  cells((span(2,-2),-5), align: left, hooks: bar_ne),
  cells((span(2,-2),-3), align: left, hooks: bar_he),
  cells((span(2,-4),0), align: left, hooks: bar_ue),
  cells((span(2,-4),1), align: left, hooks: bar_te),
  cells((span(-3,-2),0), align: center, fill: gradient.linear(gray,white)),


    // content
  table.header([Endurance Motor Load],[],[],[],[],[Heater Load],[],[],[],[Target Speed (rpm)],[],[Percentage (%)],[Duration (h)],[Number of cycles (n)],[Heater Status], [Heating Duration (h)],[Target temperature (°C)],[Water]),
  ..data,
)
] <endurancemotorload>

=== Limitations and Motivation for Further Acceleration

The endurance profile described above integrates mechanical, thermal, and actuator loads into a unified framework that closely represents real‑world operating conditions. The resulting parameters used for testing are summarised in @averagemotorload and @endurancemotorload. @averagemotorload lists average motor loads obtained from field usage data, while @endurancemotorload presents the endurance motor loads and heater loads used during qualification @Vorwerk2025HALT. These datasets form the quantitative foundation for the endurance test and ensure that the laboratory campaign maintains a realistic balance between mechanical and thermal exposure.

Despite this careful design, several limitations remain. Even with the 800‑hour acceleration, the test campaign is still extremely time‑consuming and resource‑demanding once the mandatory pauses, handling time, and supervision are considered. The mechanical and thermal loads, while statistically representative, are simplified models that do not fully capture transient variations, coupled vibrational effects, or the influence of nonlinear system responses. Furthermore, since the profile relies on a prescribed schedule rather than a continuously varying mission history, certain dynamic interactions between components may not be exercised to the same extent as in the field. These constraints underline the need for advanced methods that can achieve further acceleration without compromising representativeness. In particular, approaches based on vibration fatigue equivalence, mission synthesis, and Power Spectral Density (PSD) or Fatigue Damage Spectrum (FDS) methodologies offer the potential to replace long endurance runs with analytically and experimentally validated accelerated tests. Such approaches aim to condense thousands of operational hours into manageable test durations while preserving the cumulative damage and dynamic characteristics of real‑world operation.

= Objective
The main objective of this thesis is to establish a reliable and efficient methodology to reduce validation test time for complex assemblies while preserving equivalent severity. For Thermomix#super[#sym.trademark.registered] TM7, the current endurance profile lasts about 800 hours.

The approach uses the Fatigue Damage Spectrum (FDS) as the equivalence metric between measured time histories and laboratory specifications to synthesise accelerated random vibration PSDs that deliver field‑equivalent cumulative fatigue damage in a shorter duration. The method is applied to the Thermomix#super[#sym.trademark.registered] TM7 main PCBA ("backend") and validated through experimental vibration testing and response‑spectrum checks (SRS/ERS) to preserve critical dynamic responses. The work follows Lalanne’s specification development framework @lalanne2010mechanicalvol and MIL‑STD‑810G guidance @nagle2010test on test tailoring and test‑time compression. Deliverables include an accelerated PSD specification for the backend and a documented procedure suitable for extension to the full device.

== Scope of this Thesis

This thesis develops and validates a methodology for accelerating vibration endurance tests for complex assemblies, specifically for household appliances such as the Thermomix#super[#sym.trademark.registered] TM7. To ensure depth and rigor within the available timeframe for this master's thesis, the method is implemented on a single representative subassembly, the main PCBA "backend". All steps of the methodology, including data processing, spectrum synthesis, and validation, are executed on this component to produce a complete, reproducible workflow that can later be applied to the full device.

The endurance profile at Vorwerk couples mechanical (motor‑induced vibration) and thermal (heater) loads @Vorwerk2025HALT. In this work, the scope is limited to mechanical vibration. Thermal loads are discussed where relevant for context but are not modeled or accelerated.

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

The concept of mission synthesis originates from the need to reproduce the fatigue damage experienced by structures in real operational environments within shorter laboratory tests. After World War II, engineers in aerospace and defense realised that many standardised tests defined by conservative envelopes either undertested or overtested components. Early studies on fatigue, such as Basquin’s stress-life relationship (1910) @oh1910exponential or Miner’s linear cumulative damage hypothesis (1945), provided a mathematical foundation to link cyclic loading with fatigue life @miner1945cumulative.

== Test Tailoring Procedure

Lalanne @lalanne2010mechanicalvol defines _test tailoring_ as the structured process of creating test specifications directly from a product's life cycle profile and its real environment data, rather than from fixed standard envelopes. This approach is consistent with modern standards such as GAM.EG13 and MIL-STD-810F/G, and STANAG 4370 (AECTP 400), which all require that mechanical and climatic tests reflect measured service conditions rather than arbitrary limits.

#align(center)[
#figure(
box(stroke: 1pt + black, inset: 25pt, radius: 3pt)[
  #image("../../Images/general_tailoring_procedure.svg", width: 100mm)
],
caption: [General Tailoring Procedure @lalanne2010mechanicalvol],
) <general_tailoring_procedure>
] 

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

== Synopsis of a situation

The synopsis step transforms raw field data from each situation to statistically validated spectra. Lalanne @lalanne2010mechanicalvol distinguishes between stationary and non-stationary signals,
- For stationary random vibrations, PSDs are calculated from each measurement, from which ERS and FDS curves are derived. Statistical descriptors (mean, standard deviation, variation coefficient $V_e$) are then computed.
- For non-stationary signals (where RMS or spectral content varies with time), ERS and FDS are calculated directly from the time domain data instead of PSDs.

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

== Data Acquisition

The first step of the test tailoring methodology is data acquisition. In this step, situations of differing severities are categorised and recorded. These situations, that the product undergoes, can be either in series or parallel, depending on the event.

Thermomix#super(sym.trademark.registered) TM7 has differing knife rotational speeds, spanning from 40 rpm to 10,000 rpm, both in clockwise and counter-clockwise directions. There is also a dough mode as a part of the endurance profile where the knife alternates between a rotational speed of 600 rpm in CW and CCW. The rest of the rotational speeds and their contribution to the endurance load profile are mentioned in @averagemotorload and @endurancemotorload. 

=== Modal Analysis of the Backend PCB

Modal analysis reveals the dynamic behaviour of a component by identifying its natural frequencies, damping ratios, and corresponding mode shapes. These parameters govern how the structure responds to excitation and how fatigue accumulates over time.

For this reason, modal anaysis was performed on the Thermomix#super(sym.trademark.registered) TM7 backend PCB before vibration measurements were taken. The results were later used to guide accelerometer placement and to define the frequency range for subsequent fatigue analysis.

A combination of experimental modal analysis (Impulse Hammer Test) and finite element modal analysis (FEM) in ANSYS workbench was used to obtain a complete description of the board's modal characteristics.

=== Experimental Modal Analysis (Impulse Hammer Test)

The Impulse Hammer Test was performed using HEAD acoustics ArtemiS Suite, which served both as the acquisition and analysis platform.
- The backend PCB was mounted on a 

=== Modal Analysis in ANSYS Workbench

#align(
  figure(
    box(stroke: 1pt+black)[
      #image("../../Images/Backend_CAD_file.png", width: 150mm)
    ], caption: "Backend PCB CAD model"
  ) 
)<backend_cad_model>


#let img1 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_1_56.368Hz.png")]
#let img2 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_2_98.955Hz.png")]
#let img3 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_3_116.75Hz.png")]
#let img4 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_4_130.93Hz.png")]
#let img5 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_5_170.77Hz.png")]
#let img6 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_6_194.35Hz.png")]

  #grid(columns: 2, inset: 0.5em,
    figure(img1, caption: [Mode 1 - 56.368 Hz]),
    figure(img2, caption: [Mode 2 - 98.955 Hz]),
    figure(img3, caption: [Mode 3 - 116.75 Hz]),
    figure(img4, caption: [Mode 4 - 130.93 Hz]),
    figure(img5, caption: [Mode 5 - 170.77 Hz]),
    figure(img6, caption: [Mode 6 - 194.35 Hz]),
  )

=== Accelerometer Placement

#align(
  figure(
    box(stroke: 1pt+black)[
      #image("../../Images/accelerometer_placement.jpg", width: 150mm)
    ], caption: "Accelerometer Placement on the Backend PCB"
  ) 
)<accelerometer_placement>



We instrument the backend PCB at dynamically critical points. Candidate locations were selected through a modal analysis performed in ANSYS and verified experimentally with an impulse‑hammer test. Based on the resulting mode shapes, we placed accelerometers near antinodes (regions of maximum deformation) while respecting packaging, cable routing, and mass‑loading constraints. This ensures the measured signals are sensitive to resonant amplification yet representative of in‑service response.

To balance constraints with coverage, two mini‑triaxial accelerometers and one triaxial accelerometer were installed at locations that collectively capture the dominant bending and torsional responses of the board.

=== Vibration Data Acquisition

#align(
  figure(
    box(stroke: 1pt+black)[
      #image("../../Images/data_acquisition_setup.jpg", width: 150mm)
    ], caption: "Data acquisition of different motor rotation modes of TM7"
  ) 
)<data_acquisition_setup>

We begin by measuring vibration at the Thermomix backend printed‑circuit board (PCB). These measurements anchor the accelerated PSDs to real operational responses. For each representative operating mode in the endurance profile (motor speed and thermal state), we record time histories that capture the structural input the backend experiences in service.


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

#lorem(200)

== Time History Synthesis from PSD

#lorem(200)

== Validation Procedure

#lorem(200)

= Experimental Setup
#lorem(200)

== Test Fixture for the Backend PCB

#lorem(200)

== Modal Analysis of Test Fixture

#lorem(200)

== Shaker Table Tests

#muchpdf(
  read("..\..\Shaker_Tests\PCBTest_4_b9_LEFT_Z_1.5h\Control_b9_LEFT_Z_2000Hz_1.5h.pdf", encoding: none)
)
#muchpdf(
  read("..\..\Shaker_Tests\PCBTest_4_b9_LEFT_Z_1.5h\Drive_b9_LEFT_Z_3200Hz_1.5h.pdf", encoding: none)
)

#muchpdf(
  read("..\..\Shaker_Tests\PCBTest_2_b8_LEFT_Z_4h\Control_LEFT_Z_b8_2000Hz_4h.pdf", encoding: none)
)
#muchpdf(
  read("..\..\Shaker_Tests\PCBTest_2_b8_LEFT_Z_4h\Drive_LEFT_Z_b8_3200Hz_4h.pdf", encoding: none)
)
= Results and Discussion
== 
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