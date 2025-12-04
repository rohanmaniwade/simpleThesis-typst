#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

#pagebreak()

= Objective

This thesis sets out to establish a robust and efficient approach for accelerating vibration endurance tests in complex electronic assemblies. Using the main backend PCB of Thermomix® TM7 as a case study, the work aims to significantly reduce the time required for product validation, while ensuring that accelerated tests faithfully reproduce the fatigue damage and dynamic behaviour seen in field operation.

The methodology is built on the foundation of cumulative fatigue damage theory. By applying Miner's rule @miner1945cumulative and the S-N curve @Suresh1998, the approach quantifies and matches the damage from both standard and accelerated tests. The FDS @lalanne2010mechanicalvol is a spectral tool used to assess the damage severity of field vibration, which is used for the design of random vibration PSD that deliver equivalent damage in a much shorter time.

To ensure that the accelerated profiles are not only mathematically equivalent but also physically meaningful, the methodology is validated through a series of dedicated shaker tests. These experiments are designed to confirm that the accelerated vibration profiles preserve the critical dynamic responses and cumulative damage observed in actual service. Shaker testing provides a direct and rigorous check on the effectiveness and reliability of the accelerated test procedure.

The process is guided by established frameworks for test tailoring and time compression, including the procedures described by Lalanne @lalanne2010mechanicalvol and the standards of MIL STD 810G @nagle2010test. This ensures that the results are not only scientifically robust but also practical and applicable in real engineering contexts.

The outcome of this thesis is an experimentally validated accelerated PSD specification for the backend PCB, along with a clear and adaptable procedure for accelerated vibration testing. This methodology is intended to be transferable to other subassemblies and to full-system validation, supporting faster, more reliable, and more representative product qualification for modern engineering challenges.

== Scope of this Thesis

This thesis develops and validates a methodology for accelerating vibration endurance tests for complex assemblies, specifically for household appliances such as the Thermomix#super[#sym.trademark.registered] TM7. To ensure depth and rigor within the available timeframe for this master's thesis, the method is implemented on a single representative subassembly, the main PCB "backend". All steps of the methodology, including data processing, spectrum synthesis, and validation, are executed on this component to produce a complete, reproducible workflow that can later be applied to the full device.

The endurance profile at Vorwerk couples mechanical (motor‑induced vibration) and thermal (heater) loads @Vorwerk2025HALT. In this work, the scope is limited to mechanical vibration. Thermal loads are discussed where relevant for context but are not modelled or accelerated.