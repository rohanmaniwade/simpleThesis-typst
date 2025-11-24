#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

#pagebreak()

= Objective
The main objective of this thesis is to establish a reliable and efficient methodology to reduce validation test time for complex assemblies while preserving equivalent severity. For Thermomix#super[#sym.trademark.registered] TM7, the current endurance profile lasts about 800 hours.

[ELABORATE ON THE OBJECTIVE]

The approach uses the Fatigue Damage Spectrum (FDS) as the equivalence metric between measured time histories and laboratory specifications to synthesise accelerated random vibration PSDs that deliver field‑equivalent cumulative fatigue damage in a shorter duration. The method is applied to the Thermomix#super[#sym.trademark.registered] TM7 main PCBA ("backend") and validated through experimental vibration testing and response‑spectrum checks (SRS/ERS) to preserve critical dynamic responses. The work follows Lalanne’s specification development framework @lalanne2010mechanicalvol and MIL‑STD‑810G guidance @nagle2010test on test tailoring and test‑time compression. Deliverables include an accelerated PSD specification for the backend and a documented procedure suitable for extension to the full device.

== Scope of this Thesis

This thesis develops and validates a methodology for accelerating vibration endurance tests for complex assemblies, specifically for household appliances such as the Thermomix#super[#sym.trademark.registered] TM7. To ensure depth and rigor within the available timeframe for this master's thesis, the method is implemented on a single representative subassembly, the main PCBA "backend". All steps of the methodology, including data processing, spectrum synthesis, and validation, are executed on this component to produce a complete, reproducible workflow that can later be applied to the full device.

The endurance profile at Vorwerk couples mechanical (motor‑induced vibration) and thermal (heater) loads @Vorwerk2025HALT. In this work, the scope is limited to mechanical vibration. Thermal loads are discussed where relevant for context but are not modeled or accelerated.