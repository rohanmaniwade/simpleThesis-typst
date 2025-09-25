// main.typ
#import "@preview/muchpdf:0.1.1": muchpdf
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

= Introduction

== Problem Statement
Many engineered products operate in complex vibration environments over their service life. This can gradually lead to mechanical fatigue that threatens reliability and safety. To manage that risk, manufacturers run endurance tests to show that a product meets a specified lifetime in the field. The challenge is that traditional endurance testing is lengthy and resource intensive, which makes it hard to iterate and slows down development.

The Thermomix#super[#sym.trademark.registered] TM7, a product of the Vorwerk Group, is affected by vibrational and thermal loads that originate within the device itself. Inside the company, a combined vibration and thermal endurance profile is used to assure 4,000 field hours of service. Running this complete profile on a complex assembly takes considerable time and effort, which motivates a more efficient approach.

This thesis formulates a methodology to derive an accelerated test profile that reproduces, in a laboratory setting, the fatigue damage and relevant operational loads observed in the field, while reducing test duration. The TM7 serves as the case study; the methodology is intended to generalise to other complex assemblies.

== Thermomix#super[#sym.trademark.registered] TM7
#align(center)[
  #figure(
    image("../../Images/Thermomix_TM7_Product_Photo_MainDeviceSide-scaled.jpeg", width: 120mm),
    caption: [Thermomix#super[#sym.trademark.registered] TM7 @thermomix_tm7_image],
  )
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
Vorwerk has developed an endurance testing profile for the Thermomix#super[#sym.trademark.registered] TM7 based on usage patterns observed in earlier product generations. If the appliance experiences a characteristic distribution of knife speeds and heating temperatures over 4,000 hours in the field, the qualification test should reproduce that distribution. Accordingly, field data captures how frequently each speed mode is engaged, its average dwell time, and associated temperature ranges. Each mode is therefore assigned a percentage share of the cumulative operating interval.

To shorten development cycles, the same workload is transformed into an accelerated profile. Time and cycle allocations across modes are rebalanced so that essential exposure to critical combinations of speed and temperature is retained while the total laboratory duration is reduced to roughly 800 hours. The resulting schedule still exercises representative operating segments but in a more concentrated form that preserves relevance to real field use.

Even in this accelerated form, the campaign remains lengthy and resource demanding once pauses, handling, and supervision are included. This residual duration highlights a clear need for methods that can achieve additional reduction without sacrificing representativeness.


== Objective
The main objective of this thesis is to establish a reliable and efficient methodology for accelerating vibration endurance testing of complex assemblies. By leveraging the Fatigue Damage Spectrum (FDS) as the link between measured time histories of different modes of the test subject and laboratory test specifications, the study aims to generate equivalent and accelerated Power Spectral Densities (PSDs) that reproduce real operational fatigue damage within a reduced test duration. The methodology will be applied to Thermomix#super[#sym.trademark.registered] TM7  backend as a representative case study validated through experimental vibration testing and response spectrum criteria following the MIL-STD-810 for test tailoring specification and the works of Christian Lalanne on Specification Development. 

= Literature Review

= Theoretical Backround

== Mission Synthesis


== Fatigue Damage Spectrum (FDS)

*Fatigue Damage Spectrum (FDS)* describes how a single-degree-of-freedom system accumulates fatigue damage when subjected to a specific vibration input, as a function of its natural frequency f#sub[0] and a chosen damping ratio #sym.zeta.

The calculation of the FDS is based on several assumptions:
- The system is modeled as a single-degree-of-freedom linear oscillator.
- The S-N curve follows Basquin’s relation ($N#sym.sigma _p^b = C$).
- The peak stress is assumed proportional to the maximum relative displacement ($#sym.sigma _p = K z_p$).
- the rainflow counting method is used to count the response peaks.
- Miner's Damage accumulation rule is assumed. 


@lalanne2010mechanicalvol 



== Extreme Response Spectrum (ERS)

== Shock Response Spectrum (SRS)

= Endurance profile

= Methodology

== Research Design
#lorem(150) 

== Data Acquisition

=== Vibration Data Acquisition
For the synthesis of an accelerated PSD that provides equivalent damage as all the rotational speeds of the Thermomix according to the endurance profile, we need to first measure the vibration signals acting on the Thermomix, more precisely, the backend.

=== Accelerometer Placement
Since in our case we are focusing only on the backend circuit board of the TM7, we need to figure out which places are the most important for the placement of accelerometers.
For that purpose, a modal analysis of the backend is conducted to find out the various mode shapes. This was conducted both in ANSYS and experimentally using impulse hammer test.
From the mode shapes, the points of maximum deformation are noted and accelerometer placement is determined likewise.

[Insert images of Modal Analysis to make justifications]

Through a compromise, the sensors were placed as shown in the figure taking into account the restrictions but still making sure the critical areas are covered. 2 minitriaxial accelerometers and 1 triaxial accelerometer was used for the data acquisition.

=== Squadriga - Frontend

== Signal Processing Pipeline
== Accelerated PSD Generation
== Time History Synthesis from PSD
== Validation Procedure

= Experimental Setup

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