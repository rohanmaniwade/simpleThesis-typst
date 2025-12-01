#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

#pagebreak()


#set heading(numbering: none, supplement: [Appendix])

= Appendix A: Modal Analysis of PCB in ANSYS Workbench

#show figure: set block(breakable: true)

#figure(
  table(
    columns: 3,
    align: center,
    stroke: 1pt + black,
    [*Mode*], [*Natural frequencies with constraints (Hz)*], [*Natural frequencies without constraints (Hz)*],
    [Mode 1], [56.37], [66.58],
    [Mode 2], [98.96], [84.12],
    [Mode 3], [116.75], [114.97],
    [Mode 4], [130.93], [148.60],
    [Mode 5], [170.77], [172.24],
    [Mode 6], [194.35], [179.34],
    [Mode 7], [227.08], [219.88],
    [Mode 8], [284.86], [240.04],
    [Mode 9], [312.07], [292.27],
    [Mode 10], [332.66], [319.40],
    [Mode 11], [364.55], [328.68],
    [Mode 12], [371.32], [361.29],
    [Mode 13], [405.65], [397.08],
    [Mode 14], [530.61], [405.62],
    [Mode 15], [536.23], [434.78],
    [Mode 16], [556.94], [553.73],
    [Mode 17], [584.81], [622.75],
    [Mode 18], [637.45], [641.49],
    [Mode 19], [671.40], [681.41],
    [Mode 20], [696.77], [695.19],
    [Mode 21], [728.05], [706.25],
    [Mode 22], [771.73], [721.60],
    [Mode 23], [800.04], [762.48],
    [Mode 24], [811.90], [800.34],
    [Mode 25], [847.95], [861.70],
    [Mode 26], [904.84], [892.56],
    [Mode 27], [943.75], [925.86],
    [Mode 28], [976.78], [969.10],
    [Mode 29], [1061.40], [1043.60],
    [Mode 30], [1126.20], [1052.90],
  ),
  caption: [Modes of Backend PCB from ANSYS Workbench 2025 R1],
)

= Appendix B: Data Acquisition Hardware

== SQuadriga II Data Acquisition System
- Manufacturer: HEAD acoustics GmbH
- Model: SQuadriga II
- Configuration: Two units connected (Control + Module mode)
- Total Channels: 8 channels
- Purpose: Simultaneous multi-channel vibration data acquisition 

#pagebreak()

= Appendix C: Software and Analysis Tools

== ANSYS Workbench
- Manufacturer: ANSYS, Inc.
- Version: 2025 R1
- Application: Finite Element Modal Analysis, Design
- Modules Used: Mechanical, Modal Analysis, SpaceClaim

== HEAD acoustics ArtemiS SUITE
- Manufacturer: HEAD acoustics GmbH
- Version: 16.7
- Application: Data acquisition and signal analysis, Impulse Hammer Test
- Modules Used: Modal Analysis Project, Data Acquisition, Pool Project
- Sampling Frequency: 48 kHz

== m+p VibControl 

- Manufacturer: m+p international
- Version: 2.16.12.1
- Application: Vibration control and data acquisition for shaker testing
- Modules Used: Random

#pagebreak()
= Appendix D: Shaker System Specifications

This thesis used the TIRA Schwingprüfanlage TV 55240 LS 340 electromagnetic shaker system to execute the accelerated vibration profiles. The technical specifications reproduced here are taken from the manufacturer’s datasheet @tira2018tv55240 and are provided for reference and completeness.

== Shaker System Overview

The TV 55240 LS 340 is a uniaxial vibration test system with a nominal sinusoidal force capacity of 4 kN. The system consists of a shaker head, an 11 kVA power amplifier and a forced air cooling unit. It is mounted on a pivoting frame that allows operation in vertical and horizontal orientations.

== Main Technical Parameters

Shaker (S 55240 LS 340)
- Nominal force sinusoidal RMS and shock - 4000 N, 3600 N and 12000 N
- Frequency range - 2 Hz to 3000 Hz
- Maximum displacement peak to peak -  50.8 mm
- Maximum velocity sinusoidal and random -  2.0 m/s
- Maximum acceleration sinusoidal and random - 49 g and 40 g
- Axial suspension stiffness -  50 N/mm
- Moving mass - 8.3 kg
- Maximum payload - 250 kg
- Armature diameter - 340 mm
- Required air pressure - 600 kPa

These parameters are taken from the technical table on page one of the datasheet @tira2018tv55240.

== Amplifier

The A 1 01 11 010 power amplifier supplies the required drive current and field current for the shaker system.
Key specifications from page two of the datasheet @tira2018tv55240 include:

- Continuous output power - 11 kVA
- Frequency range - DC - 5 kHz
- Maximum RMS voltage - ±105 V
- Maximum RMS current - 100 A
- Signal to noise ratio - $<=$ 80 dB
- Integrated field supply and mains filtering

== Cooling System

The TB 0310 forced air cooling unit provides the airflow required to maintain safe operating temperature.
Specifications from page two include:

- Maximum volume flow - 315 m³/hr
- Total pressure difference - 290 mbar
- Power consumption - 4 kW
- Acoustic level - 69 dB(A)
- Supplied air hose diameter - 60 mm
- Optional noise reduction attachments such as the TB 0310 SI muffler and TB 0310 AE acoustic enclosure can reduce noise by 6 to 23 dB(A).

== Accessories and Safety

According to the manufacturer’s list on page one , the system includes an automatic armature centring system, a pneumatic load compensation system and a magnetic stray field reduction coil. Safety features include over temperature, over travel, under cooling and over current protection.








