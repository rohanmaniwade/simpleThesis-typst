#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "@preview/rowmantic:0.4.0": rowtable
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

#pagebreak()

= Results and Validation

This thesis work proposed a methodology for developing an accelerated vibration endurance test for complex assemblies such as the backend printed circuit board of the Thermomix#super(sym.trademark.registered) TM7. The earlier chapters described the acquisition of field vibration data, the processing steps that lead to the composite damage measurements, and the creation of the accelerated vibration profile. The purpose of this chapter is to evaluate whether the final test profile reproduces the required fatigue damage and whether it remains physically realistic when it is executed on the shaker.

The discussion focuses on two essential validation steps which were already central to the development of the accelerated profile. These are the fatigue damage spectrum and the maximum response spectrum. The shaker tests were carried out with one control sensor and the responses at the other mounting positions were recorded in all three axes. The comparison of the three relevant fatigue damage curves allows a direct evaluation of whether the long duration test has been replicated successfully in a shorter period. These three curves are the composite fatigue damage spectrum obtained from the field data, the fatigue damage spectrum of the accelerated profile, and the fatigue damage spectrum derived from the shaker responses. Agreement between these curves confirms that the accelerated test profile reproduces the cumulative fatigue demands that characterise the real operating environment.

The second validation step concerns the transient behaviour of the system and uses response spectra. The shock response spectrum of a real high load cheese blending event defines the upper physical limit for the transient responses that can occur in operation. The energy response spectra derived from the synthesised excitation and from the shaker measurements must remain below this limit. This ensures that the accelerated test does not introduce transient loads that are unrealistically severe or mechanically unsafe.

Taken together, the fatigue damage comparison and the transient response comparison provide a complete evaluation of the proposed methodology. They show whether the accelerated profile is both damage equivalent and physically representative, which are the two properties required for a meaningful acceleration of vibration endurance testing.

== Fatigue Damage Equivalence Comparison

The fatigue damage comparison is carried out separately for each measurement position and each axis on the backend PCB. For a given channel the analysis evaluates three fatigue damage spectra. The first is the composite FDS which is calculated from the field measurements at that specific channel and represents the target damage that must be reproduced. The second is the spectrum obtained from the mission accelerated excitation which represents the damage that is expected if the synthesised profile is delivered correctly. The third is the spectrum computed from the response that was measured at that channel during the accelerated shaker test.

All the fatigue damage spectra presented in this chapter were calculated from the PSDs that were exported directly from the PSD control channel window of the m+p VibControl software. The mission accelerated spectrum does not match the composite spectrum exactly. This is a normal outcome of the accelerated profile synthesis procedure in @fdstopsdinversion The iterative method that creates the accelerated PSD reduces the differences between the target damage and the computed damage during the first iterations, but after a certain point the improvement becomes very small and the process reaches a practical convergence limit. The PSD smoothing that is applied to the synthesised profile also modifies the shape of the PSD slightly and therefore changes the corresponding damage spectrum.

During the tests the shaker was controlled at the `PCB_LEFT` position so the closed loop system kept the response at `PCB_LEFT` position close to the target profile as shown in @fdscompb8leftx through @fdscompb8leftz for $b=8$ and @fdscompb9leftx through @fdscompb9leftz for $b=9$. The spectra at `PCB_TOP` and `PCB_CENTER` were not controlled and therefore reflect the natural dynamic behaviour of the PCB and the fixture. This is shown in @fdscompb8centerx through @fdscompb8topz for $b=8$ and @fdscompb9centerx through @fdscompb9topz. Comparing the composite spectrum, the mission accelerated spectrum and the shaker measured spectrum at these points makes it possible to evaluate whether the accelerated excitation produces a realistic distribution of fatigue damage across the assembly and not only the control point.

The behaviour at the `PCB_LEFT` position is expected because the controller continuously adjusts the drive signal to keep the response at `PCB_LEFT` close to the target profile. The FDS at that location therefore follows the composite and the mission acceleration curves very closely. The `PCB_CENTER` and `PCB_TOP` positions, however, are not controlled and their response depends on the natural dynamic properties of the PCB and the fixture. The FDS reveal how the accelerated profile propagates across the assembly rather than only at the control point.

Although the shaker measured spectra at the `PCB_CENTER` and `PCB_TOP` positions do not match the composite FDS exactly, the differences follow a pattern that is typical for flexible PCBs. Some frequency bands show slightly lower damage than the composite curve while others show a small amplification. These variations arise naturally from the modal behaviour of the structure and from the transmissibility of the fixture. Locations that lie near modal anti-nodes tend to experience higher damage and locations that lie close to nodes tend to experience lower damage. Since only the `PCB_LEFT` position is controlled during the test, the spectra the other positions represent free responses and therefore show both attenuation and amplification relative to the target curve. 

The important point is that these variations remain within a narrow and acceptable range and the dominant fatigue carrying frequencies are reproduced correctly. The overall shape of the damage distribution is preserved and the cumulative demands of the mission are matched. This behaviour indicates that the accelerated excitation excites the correct structural modes and that the test remains representative across the entire PCB board, even at the positions that are not part of the control loop.


#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_LEFT_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` X-axis, $b=8$, $T_(t e s t)=4h$]
)<fdscompb8leftx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_LEFT_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` Y-axis, $b=8$, $T_(t e s t)=4h$]
)<fdscompb8lefty>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_LEFT_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` Z-axis, $b=8$, $T_(t e s t)=4h$]
)<fdscompb8leftz>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_CENTER_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` X-axis, $b=8$, $T_(t e s t)=4h$]
)<fdscompb8centerx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_CENTER_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` Y-axis, $b=8$, $T_(t e s t)=4h$]
)<fdscompb8centery>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_CENTER_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` Z-axis, $b=8$, $T_(t e s t)=4h$]
)<fdscompb8centerz>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_TOP_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` X-axis, $b=8$, $T_(t e s t)=4h$]
)<fdscompb8topx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_TOP_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` Y-axis, $b=8$, $T_(t e s t)=4h$]
)<fdscompb8topy>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_TOP_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` Z-axis, $b=8$, $T_(t e s t)=4h$]
)<fdscompb8topz>


#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_LEFT_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)<fdscompb9leftx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_LEFT_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)<fdscompb9lefty>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_LEFT_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)<fdscompb9leftz>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_CENTER_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)<fdscompb9centerx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_CENTER_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)<fdscompb9centery>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_CENTER_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)<fdscompb9centerz>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_TOP_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)<fdscompb9topx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_TOP_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)<fdscompb9topy>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_TOP_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)<fdscompb9topz>

== Transient Response Equivalence

The transient behaviour of the backend PCB must remain physically realistic when the accelerated profile is executed on the shaker. This is important because random vibration tests can occassionally produce isolated peaks that exceed transient loads present in real operation. To ensure that this does not occur, the maximum response of the system is evaluated using response spectra.

The reference for this comparison is the shock response spectrum of a high load blending event as shown in @srsenvelopecheese. This event represents the most severe transient excitation that the PCB experiences during normal use and therefore defines the upper limit that the accelerated test is allowed to reach. The response spectrum of the accelerated excitation is computed from the synthesised profile and the response spectrum of the shaker test is computed from the measured accelerations. Both are then compared with the real shock envelope.

The ERS for `PCB_LEFT` position agree very closely with the ERS of the synthesised accelerated profiles and lies beneath the SRS envelope. This behaviour is expected because the test is controlled at this location. The ERS at most of the other response channels also fall beneath the shock envelope, even though their accelerated profile counterparts do not always show the same level of agreement. 

Some response channels, however, show narrow frequency bands in which the ERS exceeds the real shock envelope. This behavior was observed at the `PCB_CENTER` Z-axis and at the `PCB_TOP` X and Z axes for both values of $b=8$ and $b=9$. These exceedances occur close to the principal modes of the backend PCB where the structure has high dynamic amplification. The resulting responses therefore rise above what would normally be considered accceptable for a perfect agreement with the real shock envelope. Enen though they do not fall within the ideal limits, the deviations are narrow in bandwidth, limited in magnitude and fully explain modal amplification and fixture transmissibility. They do not indicate unsafe loading and do not affect overall physical representativeness of the accelerated test.

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_LEFT_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` X-axis, $b=8$, $T_(t e s t)=4h$]
)<mrscompb8leftx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_LEFT_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` Y-axis, $b=8$, $T_(t e s t)=4h$]
)<mrscompb8lefty>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_LEFT_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` Z-axis, $b=8$, $T_(t e s t)=4h$]
)<mrscompb8leftz>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_CENTER_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` X-axis, $b=8$, $T_(t e s t)=4h$]
)<mrscompb8centerx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_CENTER_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` Y-axis, $b=8$, $T_(t e s t)=4h$]
)<mrscompb8centery>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_CENTER_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` Z-axis, $b=8$, $T_(t e s t)=4h$]
)<mrscompb8centerz>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_TOP_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` X-axis, $b=8$, $T_(t e s t)=4h$]
)<mrscompb8topx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_TOP_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` Y-axis, $b=8$, $T_(t e s t)=4h$]
)<mrscompb8topy>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_TOP_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` Z-axis, $b=8$, $T_(t e s t)=4h$]
)<mrscompb8topz>


#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_LEFT_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)<mrscompb9leftx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_LEFT_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)<mrscompb9lefty>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_LEFT_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)<mrscompb9leftz>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_CENTER_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)<mrscompb9centerx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_CENTER_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)<mrscompb9centery>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_CENTER_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)<mrscompb9centerz>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_TOP_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)<mrscompb9topx>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_TOP_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)<mrscompb9topy>

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_TOP_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)<mrscomp9topz>

== Time Compression Outcome

== Discussion of Deviations and Practical Considerations

== Summary
