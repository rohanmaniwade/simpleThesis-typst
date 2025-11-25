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

== Fatigue Damage equivalence comparison

The fatigue damage comparison is carried out separately for each measurement position and each axis on the backend PCB. For a given channel such as `PCB_TOP` Y-axis the analysis evaluates three fatigue damage spectra. The first is the composite FDS which is calculated from the field measurements at that specific channel and represents the target damage that must be reproduced. The second is the spectrum obtained from the mission accelerated excitation which represents the damage that is expected if the synthesised profile is delivered correctly. The third is the spectrum computed from the response that was measured at that channel during the accelerated shaker test.

All the fatigue damage spectra presented in this chapter were calculated from the PSDs that were exported directly from the PSD control channel window of the m+p VibControl software.

The mission accelerated spectrum does not match the composite spectrum exactly. This is a normal outcome of the accelerated profile synthesis procedure in @fdstopsdinversion The iterative method that creates the accelerated PSD reduces the differences between the target damage and the computed damage during the first iterations, but after a certain point the improvement becomes very small and the process reaches a practical convergence limit. The PSD smoothing that is applied to the synthesised profile also modifies the shape of the PSD slightly and therefore changes the corresponding damage spectrum.

During the tests the shaker was controlled at the `PCB_LEFT` position so the closed loop system kept the response at `PCB_LEFT` position close to the target profile [TAG IMAGES]. The spectra at `PCB_TOP` and `PCB_CENTER` were not controlled and therefore reflect the natural dynamic behaviour of the PCB and the fixture. Comparing the composite spectrum, the mission accelerated spectrum and the shaker measured spectrum at these points makes it possible to evaluate whether the accelerated excitation produces a realistic distribution of fatigue damage across the assembly and not only the control point.

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_LEFT_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` X-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_LEFT_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` Y-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_LEFT_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` Z-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_CENTER_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` X-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_CENTER_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` Y-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_CENTER_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` Z-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_TOP_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` X-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_TOP_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` Y-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/FDS_TOP_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` Z-axis, $b=8$, $T_(t e s t)=4h$]
)


#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_LEFT_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_LEFT_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_LEFT_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_LEFT` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_CENTER_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_CENTER_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_CENTER_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_CENTER` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_TOP_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_TOP_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/FDS_TOP_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [FDS comparison `PCB_TOP` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)
== Transient Response Equivalence

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_LEFT_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` X-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_LEFT_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` Y-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_LEFT_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` Z-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_CENTER_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` X-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_CENTER_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` Y-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_CENTER_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` Z-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_TOP_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` X-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_TOP_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` Y-axis, $b=8$, $T_(t e s t)=4h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b8/MRS_TOP_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` Z-axis, $b=8$, $T_(t e s t)=4h$]
)


#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_LEFT_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_LEFT_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_LEFT_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_LEFT` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_CENTER_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_CENTER_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_CENTER_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_CENTER` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_TOP_X_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` X-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_TOP_Y_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
)

#figure(
  box(stroke: 1pt+black)[
    #muchpdf(
      read("../../Images/Plots/Shakercomparisonplots/b9/MRS_TOP_Z_cropped.pdf", encoding: none)
    )
  ],
  caption: [SRS vs ERS comparison `PCB_TOP` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
)

== Time Compression Outcome

== Discussion of Deviations and Practical Considerations

== Summary
