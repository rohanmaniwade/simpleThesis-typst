#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

#pagebreak()

= Data Acquisition

The first step of the test tailoring methodology is data acquisition. In this step, situations of differing severities are categorised and recorded. These situations that the product undergoes can occur either in series or in parallel, depending on the operational scenario.

Thermomix#super(sym.trademark.registered) TM7 operates across multiple knife rotational speeds, spanning from 40 rpm to 10,000 rpm in both clockwise and counter-clockwise directions. The endurance profile also includes a dough mode where the knife alternates between 600 rpm in CW and CCW. The complete set of rotational speeds and their contribution to the endurance load profile are detailed in @averagemotorload and @endurancemotorload. Since the endurance profile represents the device lifetime, all speed modes with their defined operational hours occur in series rather than parallelly.  

== Modal Analysis of the Backend PCB

Modal analysis reveals the dynamic behaviour of a component by identifying its natural frequencies, damping ratios, and corresponding mode shapes. These parameters govern how the structure responds to excitation and how fatigue accumulates over time.

For this reason, modal anaysis was performed on the Thermomix#super(sym.trademark.registered) TM7 backend PCB before vibration measurements were taken. The results helped act as a guide for optimum accelerometer placement.

A combination of experimental modal analysis (Impulse Hammer Test) using HEAD acoustics ArtemiS Suite and finite element modal analysis in ANSYS Workbench 2025 R1 was used to obtain a complete description of the board's modal characteristics.

=== Experimental Modal Analysis (Impulse Hammer Test)


The impulse hammer test was performed using HEAD acoustics ArtemiS Suite, which served both as the acquisition and analysis platform.

For the test, the backend PCB was suspended on a string to approximate free-free boundary conditions. Three uni-axial accelerometers were carefully glued at selected locations to capture the response, and a total of 26 measurement points were defined on both the top and bottom sides of the PCB, as depicted in @measurementpointstop and @measurementpointsbottom.

#let img1 = box(stroke: black, inset: 0.5em)[#image("../../Images/ArtemiS Suite screenshots/Impulsehammertest_3.png")]

#let img2 = box(stroke: black, inset: 0.5em)[#image("../../Images/ArtemiS Suite screenshots/Impulsehammertest_2.png")]

#subpar.grid(columns: 2, inset: 0.5em,
    figure(img1, caption: [Measurement points - top]),<measurementpointstop>,
    figure(img2, caption: [Measurement points - bottom]),<measurementpointsbottom>,
  caption: [Measurement points for impulse hammer test (roving hammer)],
)


The impulse hammer test was conducted using the roving hammer method, where the hammer is moved between measurement points while the sensors remain fixed. This approach was chosen over the roving sensor method, in which the sensor is moved and the excitation point is fixed, as it is more practical for lightweight structures like PCBs.

The roving hammer method is advantageous for lightweight or delicate structures because it avoids repeatedly attaching and detaching sensors, which can affect mass loading and measurement consistency. However, it requires careful control of the excitation force at each point. The roving sensor method, on the other hand, keeps the excitation location fixed and moves the sensor, which can be beneficial for larger or more robust structures but may introduce variability due to sensor handling and repeated mounting.

#align(
  figure(
    box(stroke: 1pt+black, inset: 1mm)[
      #image("../../Images/ArtemiS Suite screenshots/Impulsehammertest_9.png", width: 100mm)
    ], caption: "Impulse Hammer Test for the Backend PCB on HEAD acoustics ArtemiS"
  ) 
)<impulsehammer1>

@impulsehammerfrequencies summarizes the experimentally identified natural frequencies and corresponding damping ratios for each mode of the backend PCB. The mode number indicates the order of the vibration mode, the frequency column lists the measured natural frequency in hertz, and the damping percentage quantifies how quickly vibrations in each mode decay after excitation.


#figure(kind: table, caption: [Experimentally identified natural frequencies and damping ratios for the backend PCB])[ 
  #tblr(
    columns: (auto, auto, auto),
    align: (center, center, center),
    stroke: 0.05em,
    table.header([*Mode No.*], [*Frequency (Hz)*], [*Damping (%)*]),
    [1], [48.1], [11.06],
    [2], [72.9], [7.36],
    [3], [79.8], [5.05],
    [4], [121.1], [4.01],
    [5], [145.0], [3.38],
    [6], [197.7], [3.61],
    [7], [253.2], [2.66],
    [8], [270.0], [2.76],
    [9], [295.6], [2.28],
    [10], [324.0], [2.51],
    [11], [330.7], [2.78],
    [12], [331.0], [2.50],
    [13], [436.1], [2.89],
    [14], [443.1], [3.25],
    [15], [528.9], [3.36],
    [16], [674.5], [4.57],
    [17], [805.2], [1.42],
    [18], [872.0], [2.46],
    [19], [1042.4], [2.85],
    [20], [1135.8], [2.24],
    [21], [1144.3], [2.38],
    [22], [1264.5], [0.65],
    [23], [1266.1], [1.57],
    [24], [1442.9], [1.11],
    [25], [1564.1], [2.29],
    [26], [1576.0], [4.01],
    [27], [1690.4], [1.75],
    [28], [1692.8], [2.92],
    [29], [1911.0], [2.04],
    [30], [2032.0], [2.17],
    [31], [2078.7], [1.79],
    [32], [2178.1], [2.09],
    [33], [2208.7], [0.20],
  )
]<impulsehammerfrequencies>





=== Modal Analysis in ANSYS Workbench

To complement the experimental modal analysis and provide a predictive tool for design modifications, a finite element modal analysis was performed in ANSYS Workbench.

#figure(
    box(stroke: 1pt+black)[
      #image("../../Images/Backend_CAD_file.png", width: 120mm)
    ], caption: "Backend PCB CAD model"
  )<backendcadmodel>

The CAD model of the backend PCB, shown in @backendcadmodel, was imported in ANSYS Workbench 2025 R1. The mesh was generated with an element size of 1 mm, and adaptive sizing was used to ensure adequate resolution of local features and mode shapes while maintaining computational efficiency. Appropriate element designations were assigned to all components, each with their respective material properties @CoSyBackEndPCB2025. The total mass of the model was adjusted so that the simulated PCB weight was approximately 550 grams, matching the actual measured weight of the physical PCB.

#show figure: set block(breakable: true)

#let img1 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend_mesh/mesh_1.png")]
#let img2 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend_mesh/mesh_2.png")]
#let img3 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend_mesh/mesh_3.png")]
#let img4 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend_mesh/mesh_4.png")]

  
    #subpar.grid(columns: 2, inset: 0.5em,
    figure(img1, caption: [Mesh - Side view (1)]),<backendmesh1>,
    figure(img2, caption: [Mesh - Side view (2)]),<backendmesh2>,
    figure(img3, caption: [Mesh - Top view]),<backendmesh3>,
    figure(img4, caption: [Mesh - Isometric view]),<backendmesh4>,
    caption: "Backend PCB CAD-model discretisation",
  )<backendmesh>


The analysis was conducted under two boundary conditions to understand how mounting affects the modal behavior. First, a free free analysis was performed with no constraints applied, representing the suspended configuration used during the impulse hammer test. The resulting mode shapes and frequencies for the first six modes are presented in @modalshapeswoconstraint1 through @modalshapeswoconstraint6.

#let img1 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode1_1.png")]
#let img2 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode2_1.png")]
#let img3 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode3_4.png")]
#let img4 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode4_4.png")]
#let img5 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode5_4.png")]
#let img6 = box(stroke: black, inset: 0.5em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode6_4.png")]

  #show figure: set block(breakable: true)

    #subpar.grid(columns: 2, inset: 0.5em,
    figure(img1, caption: [Mode 1 - 66.575 Hz]),<modalshapeswoconstraint1>,
    figure(img2, caption: [Mode 2 - 84.124 Hz]),<modalshapeswoconstraint2>,
    figure(img3, caption: [Mode 3 - 114.97 Hz]),<modalshapeswoconstraint3>,
    figure(img4, caption: [Mode 4 - 148.6 Hz]),<modalshapeswoconstraint4>,
    figure(img5, caption: [Mode 5 - 172.24 Hz]),<modalshapeswoconstraint5>,
    figure(img6, caption: [Mode 6 - 179.34 Hz]),<modalshapeswoconstraint6>,
    caption: "Backend PCB mode shapes without constraint",
  )


Second, a constrained analysis was performed with fixed supports applied at the four mounting locations where the backend is held to the TM7 chassis, as illustrated in @fixingpointsofbackend. This configuration represents the operational mounting condition and produces mode shapes shown in @modalshapeswithconstraint1 through @modalshapeswithconstraint6.

#figure(
    box(stroke: 1pt+black)[
      #image("../../Images/ANSYS_backendmodal_screenshots/Backend with constraints/constraintswlabel.png", width: 100mm)
    ], caption: "Mounting of backend in TM7"
  )<fixingpointsofbackend>

The constrained boundary condition introduces stiffness at the mounting points, which shifts the natural frequencies and alters the mode shapes compared to the free free case. This comparison provides insight into how the mounting affects the dynamic response and helps identify which modes are most sensitive to boundary conditions. For all the natural frequencies with and without constraints, see Appendix. 

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
    #image("../../Images/ANSYS_backendmodal_screenshots/ratiovsfrequency.png", width: 120mm)
  ], caption: "Ratio vs Frequency",
) <ratiovsfrequency>

The scaled frequency for each mode was then calculated as
$ f_i^"scaled" = s(f_i^"ANSYS") · f_i^"ANSYS" $

#figure(
  box(stroke: 1pt+black, )[
    #image("../../Images/ANSYS_backendmodal_screenshots/frequencycomparisonafterscaling.png", width: 120mm)
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

#let img1 = box(stroke: 1pt+black, inset: 0em)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend without constraints/mode1_2.png")]
#let img2 = box(stroke: 1pt+black)[#image("../../Images/ANSYS_backendmodal_screenshots/Backend with constraints/mode1_4.png")]

#subpar.grid(columns: 2, inset: 0.5em,
  figure(img1, caption: [Mode 1 - without constraints]),<mode1wconstraints>,
  figure(img2, caption: [Mode 1 - with constraints]),<mode1woconstraints>,
  caption: "Comparison of Mode 1 with and without constraints",
)


Three triaxial accelerometers were installed to capture the full three dimensional vibration response of the backend PCB. The sensor specifications and placement details are summarised in @accelerometertable.

#figure(
box(stroke: 1pt + black)[
  #image("../../Images/acc_placement_w_axis.svg", width: 80mm)
],
caption: [Accelerometer Placement on Backend PCB],
)<accelerometerplacement>


#figure(kind: table, caption: [Accelerometer placement and specifications])[
  #table(
    columns: (auto, auto, auto, auto, auto),
    align: (left, left, left, center, left),
    stroke: 0.05em,
    table.header([*Sensor ID*], [*Model*], [*Type*], [*Mounting Location*], [*Modal Justification*]),
    [`PCB_LEFT`], [PCB 356A06/NC], [Triaxial], [#image("../../Images/Pictures/PCB_LEFT_closeup.png", width: 30mm)], [Mode 1 out of plane antinode with high curvature],
    [`PCB_TOP`], [PCB 356A06/NC], [Triaxial], [#image("../../Images/Pictures/PCB_TOP_closeup.png", width: 30mm)], [Direct response measurement on central component],
    [`PCB_CENTER`], [4524-B-001], [Triaxial], [#image("../../Images/Pictures/PCB_CENTER_closeup.png", width: 30mm)], [Global motion capture and reference for relative deformation],
  )
]<accelerometertable>

`PCB_LEFT` was placed at the left front edge where Mode 1 shows an out of plane antinode and high curvature. `PCB_TOP` was bonded on top of the high voltage capacitor CAP-E @CoSyBackEndPCB2025 to sample the response directly on a central component. `PCB_CENTER`, a cubic triaxial sensor, was positioned near the geometric centre to capture global motion and provide a reference for relative deformation. This layout maximises modal observability, separates bending and torsional participation, avoids nodal lines, and minimises mass loading.

[ADD A LINE THAT SAYS SPECIFICATIONS MENTIONED IN APPENDIX WHERE YOU MENTION EVERYTHING ABOUT THE SENSORS]

The sensor placements are shown in @accelerometerplacement .



== Vibration Data Acquisition

With the sensors positioned, vibration data was collected for all operating conditions in the endurance profile. The backend PCB was kept in its normal assembly to maintain realistic vibration coupling with the rest of the device.

#let img1 = box(stroke: 1pt+black, inset: 0em)[#image("../../Images/Pictures/dataacqsetup.jpg")]
#let img2 = box(stroke: 1pt+black)[#image("../../Images/Pictures/squadrigaimage2.jpg")]

#subpar.grid(columns: 2, inset: 0.5em,
  figure(img1, caption: [Data Acquisition setup (1)]),
  figure(img2, caption: [Data Acquisition setup (2)]),
  caption: "Data Acquisition setup with HEAD acoustics ArtemiS",
)<dataacquisitionsetup>

Data collection used two SQuadriga units connected together to handle all nine measurement channels (three sensors × three axes each). The first unit connected to the laptop in "Control" mode, while the second acted as an extension in "Module" mode. HEAD acoustics ArtemiS Suite recorded the vibrations at a sampling frequency of 48 kHz, capturing all channels simultaneously to preserve timing relationships. This sampling rate was chosen to ensure adequate temporal resolution for subsequent FDS and SRS calculations, which require the sampling frequency to be 7 to 10 times the maximum spectrum frequency of interest. For SRS calculations, a factor of 10 is typically recommended, making 48 kHz a conservative choice that provides substantial margin for frequencies up to 4.8 kHz. @lalanne2010mechanicalvol

For each motor speed from 40 to 10,000 rpm in clockwise and counter-clockwise directions, one‑minute recordings captured the vibration patterns during steady operation. The bowl contained 1000 grams of water throughout testing, matching the endurance test setup. This water load creates realistic blade interactions and damping that affect how the structure vibrates.


In addition to these recordings, a "dough mode" was also recorded which is mentioned in the endurance profile in @endurancemotorload. For this mode, instead of 1000 gms of water, 800 grams of pizza dough was used. The dough was kneaded for 30 seconds using the "Pizzateig" recipe from Cookidoo#super(sym.trademark.registered) @cookidoo_pizzateig_recipe. In this mode, the blade alternates between clockwise and counter-clockwise rotations with one-second stops between direction changes. This creates strong, low frequency forces when the blade encounters dough resistance.

#let img1 = box(stroke: 1pt+black, inset: 0em)[#image("../../Images/Pictures/cheeseblendingtop.jpg")]
#let img2 = box(stroke: 1pt+black)[#image("../../Images/Pictures/blendedcheese.jpg")]

#subpar.grid(columns: 2, inset: 01em,
  figure(img1, caption: [Blending of Grana Padano (1)]),<blendingofgranapadano1>,
  figure(img2, caption: [Blending of Grana Padano (2)]),<blendingofgranapadano2>,
  caption: "Shock event - Blending of 400 grams of Grana Padano blocks",
)

One shock event was recorded to set reference limits for validating the accelerated test profiles later. This event, shown in @blendingofgranapadano1 and @blendingofgranapadano2 represents a severe operating condition that creates transient impact loads,

- Cheese block blending: Two 200‑gram Grana Padano blocks processed for 30 seconds in "Blend" mode at Speed 8, from the "Rosmarin‑Parmesan Waffeln" recipe. This generates high‑frequency vibrations from blade strikes on hard cheese.

These recordings define the life cycle of the device by capturing the full range of operational vibration environments. They form the basis for calculating fatigue damage and deriving accelerated test profiles. The shock event is used to ensure that accelerated test conditions stay within realistic limits.

