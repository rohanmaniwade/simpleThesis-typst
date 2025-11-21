// main.typ
#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"
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
#set math.equation(numbering: "(1)")

= Introduction

== Vorwerk

Founded in 1883 in Wuppertal, Germany, Vorwerk is a family owned company that grew from carpet manufacturing into a global provider of premium household products and services @vorwerk_group_about. The group operates several brands and business units and is best known for a direct sales model that combines product expertise with personal consultation and community support. This approach relies on demonstrations, training, and genuine relationships with customers.

Vorwerk’s portfolio centers on durable, high quality products that make daily life at home easier. Its divisions include Thermomix#super[#sym.trademark.registered], a multifunctional cooking system, and Kobold, a range of home cleaning systems. The company invests in research and development, strong supply chains, and after sales service to sustain product reliability and customer satisfaction over a long service life @vorwerk_group_about.

As a family business, Vorwerk values collaboration, trust, and continuous improvement. Current priorities include innovation, digital services that complement hardware (for example, guided cooking and content for Thermomix#super[#sym.trademark.registered]), and responsible operations in quality, safety, and sustainability @vorwerk_group_about.


== Thermomix#super[#sym.trademark.registered] TM7
#align(center)[
  #figure(
    [
    #image("../../Images/TM7_wo_background.jpg", width: 80mm)],
    caption: [Thermomix#super[#sym.trademark.registered] TM7 @thermomix_tm7_image],
  ) <thermomix>
]

*Thermomix#super[#sym.trademark.registered]* is Vorwerk's flagship kitchen system and a leading example of its product and service philosophy @vorwerk_group_about. The latest generation, Thermomix#super[#sym.trademark.registered] TM7, as shown in @thermomix integrates the capabilities of many appliances into a single, compact platform, covering tasks such as chopping, blending, mixing, kneading, steaming, weighing, and precise temperature-controlled cooking. 

The device pairs a touchscreen interface with guided, step-by-step workflows and connects to the Cookidoo#super[#sym.trademark.registered] digital recipe ecosystem, which provides a large, curated library of recipes plus meal planning and shopping-list tools. Thermomix#super[#sym.trademark.registered] is distributed through Vorwerk's direct sales network, where demonstrations and coaching help users get the most from the system. In this thesis, the TM7, more precisely the backend PCB, serves as the reference product context for the application of accelerated vibration testing.

Key features and specifications,
- Dimensions: 33.6cm #sym.times 25.3cm #sym.times 40.5cm
- Speed range: 40-10700rpm
- Weight: 8.6kg
- Mixing bowl capacity: 2.2L
- Heating power: 1000W
- Motor power: 500W @vorwerk_tm7


== Problem Statement
Many engineered products operate in complex environments of loads over their service life. This can gradually lead to mechanical fatigue to the point of loss of function. To manage that risk, manufacturers validate and verify their products to meet a specified lifetime in the field. However, conventional endurance testing is lengthy and resource intensive, which makes it hard to iterate and slows down development.

Thermomix#super[#sym.trademark.registered] TM7, a product of the Vorwerk Group, is affected by vibrational, thermal, and transportational loads that originate from within and outside the product. Inside the company, a combined vibration and thermal endurance profile is used to assure 4,000 field hours of service. Running this complete profile on a complex assembly takes considerable time and effort, which motivates a more efficient approach.

This thesis formulates a methodology to derive an accelerated test profile that reproduces, in a laboratory setting, the fatigue damage and relevant operational loads observed in the field, while reducing test duration. The TM7 serves as the case study; the methodology is intended to generalise to other complex assemblies.


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

= Accelerated Testing
Accelerated testing aims to reduce test duration while preserving the same failure mechanisms as in service. Various methodologies exist, ranging from classical endurance approaches to modern vibration-based spectral methods.

== State of the Art
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

The S-N curve, or Wöhler curve, is a log-log plot of stress amplitude versus cycles to failure. It provides a clear picture of how materials behave under repeated loading, revealing the reduction in life as stress increases. For many steels and some metals, the S-N curve flattens at a fatigue limit, which is a stress below a material can, in theory, withstand infinite cycles. S-N curves are constructed experimentally and typically fitted using Basquin’s law. This approach helps engineers create test profiles that reflect real use conditions in a compressed timeframe @Juvinall2012 @Suresh1998.

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
    ], caption: [Impulse Hammer Test for the Backend PCB @SiemensFDSImage]
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

=== Limits of Time Compression 

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

= Data Acquisition

The first step of the test tailoring methodology is data acquisition. In this step, situations of differing severities are categorised and recorded. These situations that the product undergoes can occur either in series or in parallel, depending on the operational scenario.

Thermomix#super(sym.trademark.registered) TM7 operates across multiple knife rotational speeds, spanning from 40 rpm to 10,000 rpm in both clockwise and counter-clockwise directions. The endurance profile also includes a dough mode where the knife alternates between 600 rpm in CW and CCW. The complete set of rotational speeds and their contribution to the endurance load profile are detailed in @averagemotorload and @endurancemotorload. Since the endurance profile represents the device lifetime, all speed modes with their defined operational hours occur in series rather than parallelly.  

== Modal Analysis of the Backend PCB

Modal analysis reveals the dynamic behaviour of a component by identifying its natural frequencies, damping ratios, and corresponding mode shapes. These parameters govern how the structure responds to excitation and how fatigue accumulates over time.

For this reason, modal anaysis was performed on the Thermomix#super(sym.trademark.registered) TM7 backend PCB before vibration measurements were taken. The results were later used to guide accelerometer placement and to define the frequency range for subsequent fatigue analysis.

A combination of experimental modal analysis (Impulse Hammer Test) and finite element modal analysis (FEM) in ANSYS workbench was used to obtain a complete description of the board's modal characteristics.

=== Experimental Modal Analysis (Impulse Hammer Test)

#align(
  figure(
    box(stroke: 1pt+black, inset: 1mm)[
      #image("../../Images/ArtemiS Suite screenshots/Impulsehammertest_9.png", width: 100mm)
    ], caption: "Impulse Hammer Test for the Backend PCB"
  ) 
)<impulsehammer1>

The impulse hammer test was performed using HEAD acoustics ArtemiS Suite, which served both as the acquisition and analysis platform.
- The backend PCB was suspended on a string.
- Three uni-axial accelerometers were glued at suitable locations and 26 measurement points were defined on the PCB on both top and bottom sides as depicted in @measurementpointstop and @measurementpointsbottom


#let img1 = box(stroke: black, inset: 0.5em)[#image("../../Images/ArtemiS Suite screenshots/Impulsehammertest_3.png")]

#let img2 = box(stroke: black, inset: 0.5em)[#image("../../Images/ArtemiS Suite screenshots/Impulsehammertest_2.png")]

#subpar.grid(columns: 2, inset: 0.5em,
    figure(img1, caption: [Measurement points - top]),<measurementpointstop>,
    figure(img2, caption: [Measurement points - bottom]),<measurementpointsbottom>,
  caption: [Measurement points for impulse hammer test (roving hammer)],
)


=== Modal Analysis in ANSYS Workbench

To complement the experimental modal analysis and provide a predictive tool for design modifications, a finite element modal analysis was performed in ANSYS Workbench. The CAD model of the backend PCB, shown in @backendcadmodel, was imported and meshed with appropriate element types to represent the multilayer FR4 substrate and the mounted components.

#figure(
    box(stroke: 1pt+black)[
      #image("../../Images/Backend_CAD_file.png", width: 150mm)
    ], caption: "Backend PCB CAD model"
  )<backendcadmodel>

The analysis was conducted under two boundary conditions to understand how mounting affects the modal behavior. First, a free free analysis was performed with no constraints applied, representing the suspended configuration used during the impulse hammer test. The resulting mode shapes and frequencies for the first six modes are presented in @modalshapeswoconstraint1 through @modalshapeswoconstraint6.

#let img1 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode1_1.png")]
#let img2 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode2_1.png")]
#let img3 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode3_4.png")]
#let img4 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode4_4.png")]
#let img5 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode5_4.png")]
#let img6 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode6_4.png")]

  
    #subpar.grid(columns: 2, inset: 0.5em,
    figure(img1, caption: [Mode 1 - 66.575 Hz]),<modalshapeswoconstraint1>,
    figure(img2, caption: [Mode 2 - 84.124 Hz]),<modalshapeswoconstraint2>,
    figure(img3, caption: [Mode 3 - 114.97 Hz]),<modalshapeswoconstraint3>,
    figure(img4, caption: [Mode 4 - 148.6 Hz]),<modalshapeswoconstraint4>,
    figure(img5, caption: [Mode 5 - 172.24 Hz]),<modalshapeswoconstraint5>,
    figure(img6, caption: [Mode 6 - 179.34 Hz]),<modalshapeswoconstraint6>,
    caption: "Backend PCB mode shapes without constraint",
  )

#figure(
    box(stroke: 1pt+black)[
      #image("../../Images/ANSYS_backendmodal_screenshots/Backend with constraints/constraints.png", width: 100mm)
    ], caption: "Mounting of backend in TM7"
  )<fixingpointsofbackend>

Second, a constrained analysis was performed with fixed supports applied at the four mounting locations where the backend is bolted to the TM7 chassis, as illustrated in @fixingpointsofbackend. This configuration represents the operational mounting condition and produces mode shapes shown in @modalshapeswithconstraint1 through @modalshapeswithconstraint6.

The constrained boundary condition introduces stiffness at the mounting points, which shifts the natural frequencies and alters the mode shapes compared to the free free case. This comparison provides insight into how the mounting affects the dynamic response and helps identify which modes are most sensitive to boundary conditions.
#let img1 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_1_56.368Hz.png")]
#let img2 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_2_98.955Hz.png")]
#let img3 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_3_116.75Hz.png")]
#let img4 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_4_130.93Hz.png")]
#let img5 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_5_170.77Hz.png")]
#let img6 = box(stroke: black, inset: 0.5em)[#image("../../Images/BackendModalAnalysisPictures/Mode_6_194.35Hz.png")]

  
    #subpar.grid(columns: 2, inset: 0.5em,
    figure(img1, caption: [Mode 1 - 56.368 Hz]),<modalshapeswithconstraint1>,
    figure(img2, caption: [Mode 2 - 98.955 Hz]),<modalshapeswithconstraint2>,
    figure(img3, caption: [Mode 3 - 116.75 Hz]),<modalshapeswithconstraint3>,
    figure(img4, caption: [Mode 4 - 130.93 Hz]),<modalshapeswithconstraint4>,
    figure(img5, caption: [Mode 5 - 170.77 Hz],),<modalshapeswithconstraint5>,
    figure(img6, caption: [Mode 6 - 194.35 Hz]),<modalshapeswithconstraint6>,
    caption: "Backend PCB mode shapes with constraint",
  )

=== Modal Correlation Between Simulation and Experiment

The comparison between the experimental (impact hammer test) and numerical (ANSYS Modal) modal frequencies revealed a systematic deviation that increased with frequency as shown in @modescomparison. The FE model over-predicted the lower modes and increasingly under-predicted the higher modes.

#figure(
  box(stroke: 1pt+black, )[
    #image("../../Images/ANSYS_backendmodal_screenshots/frequencycomparison.png", width: 150mm)
  ], caption: "Frequency Comparison - Impact Hammer Test vs ANSYS Modal",
)<modescomparison>


To compensate for this systematic drift, a frequency-dependent scaling was applied directly to the simulated frequencies.
For each mode, the ratio between the experimental and simulated frequency was calculated by,

$ r_i = f_i^"IHT" / f_i^"ANSYS" $

The ratios showed a clear upward trend with frequency, as shown in @ratiovsfrequency. A linear relationship between the scaling factor and frequency was defined to progressively adjust each simulated mode. In practical implementation, the relationship took the form
$ s(f) = a + b · f $

where $a=0.6914$, $b=0.0011$, and $s(f)$ is the incremental scaling factor, as obtained from the linear trendline of the ratio plot.

#figure(
  box(stroke: 1pt+black, )[
    #image("../../Images/ANSYS_backendmodal_screenshots/ratiovsfrequency.png", width: 150mm)
  ], caption: "Ratio vs Frequency",
) <ratiovsfrequency>

The scaled frequency for each mode was then calculated as
$ f_i^"scaled" = s(f_i^"ANSYS") · f_i^"ANSYS" $

#figure(
  box(stroke: 1pt+black, )[
    #image("../../Images/ANSYS_backendmodal_screenshots/frequencycomparisonafterscaling.png", width: 150mm)
  ], caption: "Frequency Comparison After Scaling",
)<scaledfrequencies>

This procedure preserves the general distribution of modal frequencies while compensating for the frequency-dependent deviation observed experimentally.

The scaled frequencies exhibit substantially improved agreement with the test data across the entire range, as illustrated in @scaledfrequencies.

#let data = from-csv(delimiter: ",", "
1,48.10,66.58,0.72,0.76,50.91,-27.75,-5.51
2,72.90,84.12,0.87,0.78,65.95,-13.34,10.54
3,79.80,114.97,0.69,0.82,94.03,-30.59,-15.13
4,121.10,148.60,0.81,0.85,127.03,-18.51,-4.67
5,145.00,172.24,0.84,0.88,151.72,-15.82,-4.43
6,197.70,179.34,1.10,0.89,159.37,10.24,24.05
7,253.20,219.88,1.15,0.93,205.21,15.15,23.39
8,270.00,240.04,1.12,0.96,229.34,12.48,17.73
9,295.60,292.27,1.01,1.01,296.04,1.14,-0.15
10,324.00,319.40,1.01,1.04,333.05,1.44,-2.72
11,330.70,328.68,1.01,1.05,346.08,0.61,-4.44
12,331.00,361.29,0.92,1.09,393.38,-8.38,-15.86
13,436.10,397.08,1.10,1.13,447.98,9.83,-2.65
14,443.10,405.62,1.09,1.14,461.43,9.24,-3.97
15,528.90,434.78,1.22,1.17,508.54,21.65,4.00
16,674.50,553.73,1.22,1.30,720.13,21.81,-6.34
17,805.20,641.49,1.26,1.40,896.19,25.52,-10.15
18,872.00,681.41,1.28,1.44,981.88,27.97,-11.19
19,1042.40,695.19,1.50,1.46,1012.27,49.94,2.98
20,1135.80,706.25,1.61,1.47,1036.97,60.82,9.53
21,1144.30,721.60,1.59,1.49,1071.69,58.58,6.78
22,1264.50,762.48,1.66,1.53,1166.69,65.84,8.38
23,1266.10,800.34,1.58,1.57,1257.95,58.20,0.65
24,1442.90,861.70,1.67,1.64,1412.56,67.45,2.15
25,1576.00,892.56,1.77,1.67,1493.45,76.57,5.53
26,1690.40,925.86,1.83,1.71,1583.08,82.58,6.78
27,1692.80,969.10,1.75,1.76,1703.11,74.68,-0.61
28,1911.00,1043.60,1.83,1.84,1919.56,83.12,-0.45
29,2032.00,1052.90,1.93,1.85,1947.43,92.99,4.34
")

#figure(kind: table, caption: [Comparison of experimental, simulated, and scaled modal frequencies])[
  #tblr(columns: (1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr),
  stroke: 0.05em,
  align: center+horizon,
  // formatting directives
  rows(within: "header", auto, fill: aqua.lighten(60%), hooks: strong),
  // content
  table.header([Mode No.],[$f_"IHT"$ (Hz)],[$f_"ANSYS"$ (Hz)],[ Ratio $r_i$],[Scale $s(f_i)$],[$f_i^"scaled"$],[Error before (%)],[Error after (%)]),
  ..data
)
]<frequencycomparison>


Applying the frequency‑dependent linear scaling reduced the mean absolute frequency error from approximately 35.9% to 7.4% across 29 modes (≈79% relative reduction). The worst‑case error decreased from 93.0% to 24.1%. Improvements were most pronounced for higher modes, where the unscaled deviations were largest. A small deterioration was observed in a few low‑order modes (e.g., Modes 6–8), which reflects the bias of a single global linear fit.



== Accelerometer Placement

Accelerometer placement was driven by mode shapes from ANSYS together with the impulse‑hammer modal test. Two boundary conditions were reviewed: free free (unconstrained) and with mounting constraints representative of the fixture. In both, antinodes of the first bending mode were selected as primary locations to maximise signal to noise and avoid nodal lines, subject to component clearance, adhesive area, and cable routing @ci_pcb_modal_2020. The mode 1 shapes for both cases are shown in @mode1wconstraints and @mode1woconstraints.

To separate bending and torsion with a small channel count, sensors were distributed to regions with distinct modal participation. This follows information‑based optimal sensor placement principles; independence was checked pragmatically with coherence and Auto‑MAC to ensure good data quality @zacharakis2024_osp_tf @ci_pcb_modal_2020.

Instrumentation effects were minimised. Miniature sensors with short leads limited mass loading, and the PCB was suspended during hammer tests to approximate free free boundary conditions. The resulting frequency response functions did not show mass‑loading artefacts, indicating that the measured behaviour reflected the structure rather than the instrumentation @ci_pcb_modal_2020.

Placement was also aligned with reliability. Solder‑joint fatigue correlates with relative displacement and local stress near components, so measuring in component‑dense regions that coincide with dominant bending and torsion shapes links dynamics to durability. Increasing board stiffness is known to shift modes and reduce relative displacement at the joints @doranga2022_pcb_stiffening. With these considerations, two miniature triaxial accelerometers and one triaxial accelerometer were installed at antinodes of the first bending mode that persist across both boundary conditions.

#figure(
    box(stroke: 1pt+black)[
      #image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode1_2.png", width: 150mm)
    ], caption: "Mode 1 (without constraints)"
  )<mode1wconstraints>

#figure(
    box(stroke: 1pt+black)[
      #image("../../Images/ANSYS_backendmodal_screenshots/Backend with constraints/mode1_4.png", width: 150mm)
    ], caption: "Mode 1 (with constraints)"
  )<mode1woconstraints>


The sensor placement was as follows,

- PCB_LEFT was placed at the left‑front edge where Mode 1 shows an out‑of‑plane antinode and high curvature.

- PCB_TOP was bonded on top of the high voltage electrolytic capacitor designated CAP‑E in the BOM (270 µF, 450 V, ±20%, 85 °C, 30×35 mm) @CoSyBackEndPCB2025 to sample the response directly on a central component.

- PCB_CENTER, A third triaxial sensor, was positioned near the geometric centre to capture global motion and provide a reference for relative deformation. This layout maximises modal observability, separates bending and torsional participation, avoids nodal lines, and minimises mass loading.

The sensor placements are shown in @accelerometerplacement .

#figure(
box(stroke: 1pt + black)[
  #image("../../Images/acc_placement_w_axis.svg", width: 100mm)
],
caption: [Accelerometer Placement on Backend PCB],
)<accelerometerplacement>

== Vibration Data Acquisition

With the sensors positioned, vibration data was collected for all operating conditions in the endurance profile. The backend PCB was kept in its normal assembly to maintain realistic vibration coupling with the rest of the device.

Data collection used two SQuadriga units connected together to handle all nine measurement channels (three sensors × three axes each). The first unit connected to the laptop in "Control" mode, while the second acted as an extension in "Module" mode. HEAD acoustics ArtemiS Suite recorded the vibrations at a sampling frequency of 48 kHz, capturing all channels simultaneously to preserve timing relationships. This sampling rate was chosen to ensure adequate temporal resolution for subsequent FDS and SRS calculations, which require the sampling frequency to be 7 to 10 times the maximum spectrum frequency of interest. For SRS calculations, a factor of 10 is typically recommended, making 48 kHz a conservative choice that provides substantial margin for frequencies up to 4.8 kHz. @lalanne2010mechanicalvol

For each motor speed from 40 to 10,000 rpm in clockwise and counter-clockwise directions, one‑minute recordings captured the vibration patterns during steady operation. The bowl contained 1000 grams of water throughout testing, matching the endurance test setup. This water load creates realistic blade interactions and damping that affect how the structure vibrates.


In addition to these recordings, a "dough mode" was also recorded which is mentioned in the endurance profile in @endurancemotorload. For this mode, instead of 1000 gms of water, 800 grams of pizza dough was used. The dough was kneaded for 30 seconds using the "Pizzateig" recipe from Cookidoo#super(sym.trademark.registered) @cookidoo_pizzateig_recipe. In this mode, the blade alternates between clockwise and counter-clockwise rotations with one-second stops between direction changes. This creates strong, low frequency forces when the blade encounters dough resistance.

One shock event was recorded to set reference limits for validating the accelerated test profiles later. This event represents a severe operating condition that creates transient impact loads:

- Cheese block blending: Two 200‑gram Grana Padano blocks processed for 30 seconds in "Blend" mode at Speed 8, from the "Rosmarin‑Parmesan Waffeln" recipe. This generates high‑frequency vibrations from blade strikes on hard cheese.

These recordings define the life cycle of the device by capturing the full range of operational vibration environments. They form the basis for calculating fatigue damage and deriving accelerated test profiles. The shock event is used to ensure that accelerated test conditions stay within realistic limits.



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
  caption: "Time history signal for PCB_CENTER Z-axis"
)<timehistory_center_z>

@timehistory_center_z presents the vibration time histories recorded at sensor PCB_CENTER along the Z axis for all operating modes and shock events. Most speed modes exhibit stationary random behaviour, with relatively stable amplitude distributions over time. The dough mode introduces transient variations due to the alternating blade direction and dough resistance. The signal in black corresponds to the cheese block blending event, where two 200-gram blocks of Grana Padano were processed at Speed 8. This event produced significantly higher amplitude peaks and broader frequency content compared to normal operation, making it suitable as a reference shock for validating that accelerated profiles do not exceed realistic severity limits.

The RMS value quantifies the overall intensity of a vibration signal and serves as a fundamental damage metric @BruelKjaer1982_MeasuringVibration @ISO2041_2018. For time domain signals,

$ x_(R M S)= sqrt(1/T)integral^T_0 x^2(t) d t approx sqrt(1/N) sum^N_(i=1) x^2_i $  <rmstimecalculation>

For frequency domain analysis, RMS is computed from the PSD using Parseval's theorem @BendatPiersol2010,

$ x_(R M S)= sqrt(integral^infinity_0 S_(x x)(f)d f) $ <rmspsdcalculation>

where $S_(x x)(f)$ is the power spectral density. VibeAccelKit implements using the trapezoidal rule for improved accuracy over discrete frequency grids.

== Power Spectral Density estimation

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
  caption: "PSDs of all motor speed modes for PCB_CENTER Z-axis"
)<PSDinspect>

@PSDinspect presents the power spectral densities computed from 1-minute recordings for all motor speeds at sensor PCB_CENTER along the Z axis. Each colored trace corresponds to a different operating speed, spanning the frequency range from 0 to 2000 Hz. The spectral shapes vary noticeably across operating conditions. At lower speeds, energy concentrates in narrow peaks around blade pass frequencies and their harmonics. As speed increases, the vibration energy spreads more broadly across the spectrum, reflecting the more complex excitation from faster blade motion and fluid interaction. Elevated spectral content appears consistently between 50 and 200 Hz across multiple modes, coinciding with the first few structural resonances identified during modal analysis. This concentration of energy near natural frequencies indicates resonant amplification, which directly influences fatigue accumulation. The PSDs form the input for fatigue damage spectrum calculations, where the spectral energy at each frequency is weighted according to how effectively that frequency excites structural oscillators across a range of natural frequencies.

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
  caption: [Composite FDS of all motor speeds for PCB_CENTER Z-axis ($b=9$, $zeta=0.05$)]
)<compositefdsb9centerz>

The FDS methodology has an important mathematical property: when the same fatigue exponent $b$ and damping ratio $zeta$ are used consistently for both the forward calculation (PSD to FDS) and inverse transformation (FDS back to PSD), these values cancel out in the final accelerated profile. Accurate material specific values should be used when available from testing or supplier data. When such data is unavailable, established default values provide reasonable approximations. Following Lalanne's recommendations for electronic assemblies, calculations were performed with $b = 8$ and $b = 9$ (typical for solder joints) and $zeta = 0.05$ (Q = 10, representing lightly damped PCB behavior) @lalanne2010_fatigue_damage @LalanneSummary. Both exponent values were evaluated to examine their influence on the resulting test specifications.

The frequency-domain approach was chosen for computational efficiency. While time-domain and frequency-domain methods produce equivalent results for stationary Gaussian vibration, the frequency-domain calculation runs substantially faster when processing multiple channels across many operating modes. Preliminary comparisons confirmed negligible differences between the two approaches, validating the frequency-domain method for this application.

@compositefdsb9centerz shows the FDS for each motor speed at sensor PCB_CENTER Z-axis from 0 to 2000 Hz, computed with $b = 9$ and $zeta = 0.05$. Each colored trace represents one operating speed, revealing how that mode contributes to damage at different natural frequencies. The bold composite FDS, calculated by time-weighted summation per @seriesfds, sums up all individual contributions. This composite represents the total accumulated fatigue damage over the complete endurance profile and directly determines the accelerated test specification.

== FDS to PSD inversion 

The FDS to PSD inversion is a critical step in developing accelerated vibration test specifications from field data. After the composite FDS is calculated that bounds all measured vibration environments, this method converts it into a PSD profile that can be programmed into vibration testing equipment. The equivalent PSD is derived from the composite FDS using Lalanne’s analytical relationship @lalanne2010mechanicalvol,

$ P S D_(e q) (f)= (8 pi f)/Q [(F D S_(c o m p) (f))/f.T_(e q). Gamma(1+b/2)]^(1/b) $ <fdstopsdinit>

where $ Q=1/(2 zeta) $ is the quality factor, $Gamma$ is the gamma function, and $T_(e q)$ is the equivalent test duration. This inversion assumes narrow-band response (Rayleigh damage model) and provides a lower-bound PSD estimate.

=== Implementation of an Iterative Method
While the Lalanne formula provides an excellent initial estimate, it assumes narrow-band response. In practice, structural vibration may have broad-band characteristics. Therefore, an iterative refinement process is employed.

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
  caption: [Initial equivalent PSD derived from Lalanne's formula for PCB_CENTER Z-axis ($b=9$, $zeta=0.05$, $T_(e q)=924$ hours)]
)<psdinit>

@psdinit shows the initial equivalent PSD obtained by directly applying Lalanne's analytical inversion formula per @fdstopsdinit to the composite FDS. This initial estimate assumes narrow-band Rayleigh response characteristics and provides the starting point for the iterative refinement process. While this analytical solution offers a computationally efficient first approximation, the assumption of narrow-band behavior may not fully capture the broadband nature of the actual structural response.

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/psd_match_cropped.pdf", encoding: none)
    )
  ],
  caption: [Comparison of initial and converged equivalent PSDs for PCB_CENTER Z-axis]
)<psdmatch>

The iterative refinement process adjusts the initial PSD to account for broadband response characteristics using Rice's more general damage formulation. @psdmatch compares the initial PSD from Lalanne's formula with the converged PSD after iterative correction. At each iteration, the multiplicative correction factor from @corr is applied frequency-by-frequency to adjust the PSD based on the ratio of target to computed FDS values. The refined profile shows localized adjustments, particularly in frequency regions where the narrow-band assumption deviates from the actual broadband damage accumulation. Under-relaxation and gain limiting ensure stable convergence without oscillation.

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/fds_match_cropped.pdf", encoding: none)
    )
  ],
  caption: [Target composite FDS and recomputed FDS from converged equivalent PSD for PCB_CENTER Z-axis]
)<fdsmatch>

@fdsmatch validates the inversion process by comparing the target composite FDS with the FDS recomputed from the final converged PSD using Rice's broadband damage model. The close agreement between the two curves confirms that the iterative method successfully produces an equivalent PSD that reproduces the desired fatigue damage spectrum. The convergence criterion of less than 0.1 dB error ensures that the resulting test specification will deliver fatigue damage equivalent to the field profile across the entire frequency range of interest.

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
  caption: [Accelerated PSD profiles for PCB_CENTER Z-axis ($b=9$, $zeta=0.05$)]
)<acceleratedpsds>

@acceleratedpsds presents the equivalent PSD corresponding to the full 924-hour endurance profile along with a series of accelerated profiles spanning 1, 1.5, 2, 4, 5, 10, 20, 50, and 100 hours. Each accelerated curve represents the same fatigue damage as the baseline but compressed into a shorter duration. Shorter test times require higher spectral amplitudes to maintain damage equivalence, illustrating the trade-off between test efficiency and severity. This complete set of accelerated profiles was generated for both $b = 8$ and $b = 9$ across all three sensors (PCB_LEFT, PCB_CENTER, PCB_TOP) and all three axes (X, Y, Z), yielding nine independent test specifications to evaluate the influence of the fatigue exponent and capture the full vibrational behavior of the backend PCB.

== Response Spectrum Validation

To ensure that the accelerated PSD does not introduce unrealistically high dynamic responses, the profile is validated using response spectra computed from single-degree-of-freedom (SDOF) oscillators across the frequency of interest. Two complementary metrics are used, the Shock Response Spectrum (SRS) and the Extreme Response Spectrum (ERS).

=== Shock Response Spectrum Calculation

The SRS represents the maximum absolute acceleration response of an SDOF oscillator subjected to the excitation. The calculation of SRS is explained in @srs. The maximax SRS convention is adopted in this work, meaning the peak of peak values across events @lalanne2014_mechanical_shock. For numerical implementation, the well established recursive algorithm of Smallwood (1981) @smallwood1981_improved_srs is used, which provides an efficient and stable way to compute the SRS for arbitrary time histories. @srsenvelopecheese shows the SRS of all the channels and axes of the shock event, which is the blending of 400 grams of Grana Padano cheese in Thermomix#super(sym.trademark.registered) TM7.

=== Extreme Response Spectrum Calculation

The calculation of ERS is explained in @ers. However, for a stationary random Gaussian vibration signal defined by a PSD $S_(a a)(f)$, the ERS at natural frequency $f_0$ is given by,

$ E R S(f_0)= T_(a c c) integral^infinity_0 |H(f,f_0)|^2 S_(a a)(f)d f $

where, $H(f,f_0)$ is the SDOF transfer function for base excitation, and $T_(a c c)$ is the duration of the accelerated test. This definition follows directly from response PSD theory and Parseval @BendatPiersol2010 and is consistent with standard practice in vibration fatigue assessment.

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

= Validation Procedure

= Experimental Setup

== Test Fixture for the Backend PCB

For running the accelerated PSD profiles on the shaker table, the need for a fixture mounting was necessary. This fixture would have to hold the backend just like it is held in the device.



== Modal Analysis of Test Fixture

#lorem(200)

== Shaker Table Tests

#muchpdf(
  read("..\..\Images\SHAKER_TESTS_ROHAN\Control_LEFT_X_b8_2000Hz_4h.pdf", encoding: none)
)

#muchpdf(
  read("..\..\Images\SHAKER_TESTS_ROHAN\Control_LEFT_X_b9_2000Hz_1.5h.pdf", encoding: none)
)

#muchpdf(
  read("..\..\Images\SHAKER_TESTS_ROHAN\Control_LEFT_Y_b8_2000Hz_4h.pdf", encoding: none)
)

#muchpdf(
  read("..\..\Images\SHAKER_TESTS_ROHAN\Control_LEFT_Y_b9_2000Hz_1.5h.pdf", encoding: none)
)

#muchpdf(
  read("..\..\Images\SHAKER_TESTS_ROHAN\Control_LEFT_Z_b8_2000Hz_4h.pdf", encoding: none)
)

#muchpdf(
  read("..\..\Images\SHAKER_TESTS_ROHAN\Control_LEFT_Z_b9_2000Hz_1.5h.pdf", encoding: none)
)

= Results and Discussion
== Finding Nemo

== Finding Dory
== Analysis

== Implications

= Conclusion and Outlook
== Summary

== Future Work

#bibliography("references.bib", style: "ieee")