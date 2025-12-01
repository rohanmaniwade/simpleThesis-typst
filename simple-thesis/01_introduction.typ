#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"


// Chapter 1: Introduction

#pagebreak()

= Introduction


Founded in 1883 in Wuppertal, Germany, Vorwerk is a family owned company that grew from carpet manufacturing into a global provider of premium household products and services @vorwerk_group_about. The group operates several brands and business units and is best known for a direct sales model that combines product expertise with personal consultation and community support. This approach relies on demonstrations, training, and genuine relationships with customers.
Vorwerk's portfolio centers on durable, high quality products that make daily life at home easier. Its divisions include Thermomix#super[#sym.trademark.registered], a multifunctional cooking system, and Kobold, a range of home cleaning systems. The company invests in research and development, strong supply chains, and after sales service to sustain product reliability and customer satisfaction over a long service life @vorwerk_group_about.

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

== Backend PCB

#align(center)[
  #figure(
    box(stroke: 1pt+black)[
    #image("../../Images/Backend.jpg",width: 120mm)],
    caption: [Backend PCB],
  ) <backend>
]

The backend PCB is the central power and control module of Thermomix#super[#sym.trademark.registered] TM7. It handles mains voltage input, performs power factor correction and DC conversion, controls the motor and heater through embedded microcontrollers, and manages all sensor and actuator interfaces @CoSyBackEndPCB2025. The board brings together high voltage switching devices (IGBTs, MOSFETs, TRIACs), multiple microcontrollers for real time control and communication, and various passive components such as capacitors, inductors, and resistors that handle filtering, regulation, and signal conditioning.

The backend is a multilayer FR4 assembly measuring 220 × 165.5 mm and 1.6 mm thick. Its layout balances competing needs: high current traces and large power components generate concentrated heat that must be managed, while sensitive analog and digital circuits need careful grounding and EMI suppression. This design complexity makes the backend a good representative of modern mixed signal power electronics assemblies found in household appliances.

The backend plays a critical role in system reliability. Motor speed commands, heater regulation, and safety interlocks all depend on it working continuously. Solder joint fatigue, capacitor degradation, or any interconnect failure can cause functional loss. The board experiences mechanical vibration from motor imbalance and blade interaction with liquid, as well as thermal cycling from heater operation, which makes it an ideal test specimen for validating accelerated vibration methods. Its internal resonances, mass distribution, and mounting constraints represent the kinds of complex boundary conditions encountered in real product qualification. This means findings from testing this component can be directly applied to other assemblies within the TM7 and similar appliances.


== Problem Statement
Many engineered products operate in complex environments of loads over their service life. This can gradually lead to mechanical fatigue to the point of loss of function. To manage that risk, manufacturers validate and verify their products to meet a specified lifetime in the field. However, conventional endurance testing is lengthy and resource intensive, which makes it hard to iterate and slows down development.

Thermomix#super[#sym.trademark.registered] TM7, a product of the Vorwerk Group, is affected by vibrational, thermal, and transportational loads that originate from within and outside the product. Inside the company, a combined vibration and thermal endurance profile is used to assure 4,000 field hours of service. Running this complete profile on a complex assembly takes considerable time and effort, which motivates a more efficient approach.

This thesis formulates a methodology to derive an accelerated test profile that reproduces, in a laboratory setting, the fatigue damage and relevant operational loads observed in the field, while reducing test duration. The TM7 serves as the case study; the methodology is intended to generalise to other complex assemblies.


== Endurance profile for Thermomix#super[#sym.trademark.registered] TM7
Vorwerk has developed an endurance testing profile for the Thermomix#super[#sym.trademark.registered] TM7 based on usage patterns observed in earlier product generations @Vorwerk2025HALT. In normal household use, the appliance experiences a characteristic distribution of motor speeds and heating temperatures over a lifetime of roughly 4,000 hours. To ensure that laboratory testing remains representative of real operation, the qualification profile was designed to reproduce this same distribution.

Field data was analysed to understand how often each speed level is used, how long it typically remains active, and what temperature ranges are associated with these operating modes. Each mode was then assigned a proportional share of the total usage time so that the cumulative exposure during the test reflects actual customer behaviour.

To shorten the development cycle, an accelerated endurance profile was derived that preserves the essential combination of mechanical and thermal loads while reducing the total test duration to around 800 hours. The time and cycle allocation across the various operating modes were adjusted to maintain the same exposure to critical conditions, ensuring that the results remain relevant to field performance.

=== Development Methodology

The endurance profile was developed using a structured, data‑driven approach that ensures a realistic representation of the product's operation. The statistical distribution of speeds and heating levels observed in the field was aligned with the internal endurance requirements used for product qualification. Both operating time and the total number of revolutions were treated as governing parameters to reproduce fatigue accumulation and mechanical wear patterns.

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

In certain test segments, the bowl is intentionally left without water so that the heating element can reach temperatures above 100 °C. These dry-heating phases are intended to place the heating circuit under additional stress, providing a more complete evaluation of the system's reliability.

=== Actuator Cycles and Test Sequence

Each endurance cycle consists of 20 minutes of operation followed by a 4-minute pause. During the pause, the actuator completes 20 full movements. Three consecutive cycles form one cycle block, representing approximately one hour of total operation.

For profiles that involve heating in the standard endurance programme, the bowl is typically filled with 1.5 litres at the start of each block to compensate for evaporation and spillage through the lid opening, yielding about 1.0 litre working volume. In this thesis, heating and evaporation are not modelled, and all tests are conducted with 1.0 litre of water. This structured repetition of load, rest, and actuation creates a controlled and repeatable simulation of household use, allowing consistent evaluation of long-term durability.

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
