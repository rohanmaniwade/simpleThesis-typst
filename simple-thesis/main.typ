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
    #lorem(100),
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
In many engineering applications, products are routinely exposed to complex vibration environments throughout their operational lifetime. These include components in automobiles, aerospace systems, and consumer electronics, where mechanical fatigue due to vibration can be a crucial factor affecting reliability and safety. To ensure durability, manufacturers commonly perform environmental.


== Objective
#lorem(100)

= Literature Review

= Theoretical Backround

== Mission Synthesis


== Fatigue Damage Spectrum (FDS)



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