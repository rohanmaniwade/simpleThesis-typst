#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "@preview/rowmantic:0.4.0": rowtable
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

#pagebreak()

= Shaker Table Tests


The accelerated PSD profiles developed in the previous chapters were validated experimentally on a uniaxial electrodynamic shaker. The purpose of these tests was to reproduce the accelerated vibration environment on the PCB, measure the structural responses, and verify whether the accelerated PSDs generated in software can be stably executed in closed loop control. The shaker setup also accomodated data acquisition for response measurement, which can be used for the computation of FDS, which was essential for evaluating the damage equivalence between the analytical predictions and the physical test responses.

== Shaker System

#figure(
box(stroke: 1pt + black)[
  #image("../../Images/Shaker test pictures/shaker.jpg", width: 60mm)
],
caption: [TIRA uni-axial electrodynamic shaker],
)<tirashaker>




The experimental work was performed using a uniaxial electrodynamic shaker system, specifically the TIRA TV 55240 LS 340. This system is capable of delivering controlled broadband random excitation in the frequency range from 2 Hz to 3000 Hz, with a maximum force output of 4 kilonewtons. These capabilities are well suited for the backend printed circuit board and its supporting fixture. The shaker system is equipped with a matched power amplifier, forced air cooling, and a suite of safety features that ensure stable operation and precise control during extended vibration tests. Further details regarding the hardware and its specifications are provided in the appendix. [INSERT APPENDIX ENTRY]

The backend PCB was mounted on the custom test fixture and instrumented with three triaxial accelerometers located at `PCB_LEFT`, `PCB_CENTER`, and `PCB_TOP`.The same three triaxial accelerometers described in @accelerometertable were used for all tests, each installed at the identical locations as during data acquisition. This ensured consistency in sensor placement and allowed direct comparison between field and laboratory measurements.

Accelerated profiles were generated for both fatigue exponents, $b=8$ and $b=9$, to evaluate their influence on test specifications. However, as discussed in @limitsoftimecompression and illustrated in @testtimereduction, there are practical limits on how much a test can be compressed whilst maintaining realistic severity levels.

For the 924 hour equivalent PSD, the maximum achievable time compression differs depending on the fatigue exponent. With $b=8$, the compression factor is limited to 256, giving a minimum test duration of

$ T_(t e s t)= 924/256 = 3.6 approx 4 "hours" $ 

For $b=9$, the higher exponent allows greater compression up to a factor of 640, reducing the minimum test duration to

$ T_(t e s t)= 924/640 = 1.44 approx 1.5 "hours" $

These calculations establish the lower bounds for test duration. Attempting to compress further would require severity levels that exceed the reference shock limits, resulting in unrealistic test conditions.

#figure(
  table(
    columns: 4,
    [Acceptable\ PSD durations ($b=8$)],[X], [Y], [Z],
    [CENTER], [4 hours], [4 hours], [4 hours],
    [LEFT], [4 hours], [4 hours], [4 hours],
    [TOP], [10 hours], [4 hours], [4 hours],
  ),
  caption: [Minimum validated test durations for accelerated PSD profiles with fatigue exponent $b=8$]
)<acceptabletimecompressionb8>

#figure(
  table(
    columns: 4,
    [Acceptable \ PSD durations ($b=9$)],[X], [Y], [Z],
    [CENTER], [1.5 hours], [1.5 hours], [1.5 hours],
    [LEFT], [1.5 hours], [1.5 hours], [1.5 hours],
    [TOP], [10 hours], [1.5 hours], [1.5 hours],
  ),
  caption: [Minimum validated test durations for accelerated PSD profiles with fatigue exponent $b=9$]
)<acceptabletimecompressionb9>


The validation process reveals an important trade off between test efficiency and severity constraints. @acceptabletimecompressionb8 and @acceptabletimecompressionb9 summarise the shortest acceptable test durations for each sensor location and axis. For $b=9$, most channels can be tested in as little as 1.5 hours whilst remaining within the shock severity envelope. The higher fatigue exponent permits more aggressive acceleration, compressing the 924 hour field profile by a factor of 640. In contrast, $b=8$ requires a more conservative 4 hour minimum for most locations, corresponding to a compression factor of 256. The exception in both cases is `PCB_TOP` X-axis, where structural resonance effects restrict the minimum duration to 10 hours regardless of the fatigue exponent. These validated durations establish the baseline specifications for the subsequent shaker table tests, balancing practical test efficiency against the fundamental requirement to avoid introducing unrealistic loading conditions.


== Control Sensor Selection

The shaker used in this work is uniaxial and can therefore excite only one direction at a time. As a result, a single point and single axis control strategy was necessary. Among the three mounted sensors, the `PCB_LEFT` location demonstrated the strongest and most stable mechanical coupling during the self test procedure, while `PCB_TOP` and `PCB_CENTER` resulted in poor coherence errors. The `PCB_LEFT` position was the most mechanically inert and consistently produced high coherence between the shaker drive and the measured response, which is essential for reliable closed loop control. For this reason, the `PCB_LEFT` accelerometer served as the control sensor for every test. @finalshakertests shows the planned shaker tests considering the limitations of time compression and shaker control positions.

#figure(
  tblr(
    columns: 4,
    align: auto,
    cells(((1,4), 0), rowspan: 3, align: (center+horizon)),
    cells(((1,4), 3), rowspan: 3, align: (center+horizon)),
    [Fatigue exponent], [Shaker control position], [Time duration (hrs)],[Total test time (hrs)],
    [$b=8$], [`PCB_LEFT` X], [4],[12],
    [], [`PCB_LEFT` Y], [4],[],
    [], [`PCB_LEFT` Z], [4],[],
    [$b=9$], [`PCB_LEFT` X], [1.5],[4.5],
    [], [`PCB_LEFT` Y], [1.5],[],
    [], [`PCB_LEFT` Z], [1.5],[],
  ),
  caption: [Shaker Tests]
)<finalshakertests>


Although the sensor at `PCB_LEFT` measures three orthogonal directions, only one of these axes was used for control during a given test. The selected axis always matched the physical direction of imposed vibration. When the fixture was oriented so that the Z axis pointed upward, the Z channel of the `PCB_LEFT` accelerometer was used as the control channel. The same principle was applied for X axis and Y axis excitation by rotating the fixture accordingly. An auxiliary mounting plate was used to orient the fixture in the required test directions, as illustrated in @shakerorientationx through @shakerorientationz. This ensured that the control channel always aligned with the correct structural degree of freedom.

#let img1 = box(stroke: 1pt+black, inset: 0.1em)[#image("../../Images/Shaker test pictures/X axis.jpeg")]
#let img2 = box(stroke: 1pt+black, inset: 0.1em)[#image("../../Images/Shaker test pictures/Y axis.jpg")]
#let img3 = box(stroke: 1pt+black, inset: 0.1em)[#image("../../Images/Shaker test pictures/Z axis.jpeg")]

#subpar.grid(columns: 3,
  figure(img1, caption: [X axis control]),<shakerorientationx>,
  figure(img2, caption: [Y axis control]),<shakerorientationy>,
  figure(img3, caption: [Z axis control]),<shakerorientationz>,
  caption: [Shaker control orientations for `PCB_LEFT`],
)



During each test, the selected axis of the `PCB_LEFT` accelerometer provided the feedback signal for closed loop control, while all axes of all sensors were recorded simultaneously. The control signal was split using a T-connector so that VibControl received the conditioned accelerometer signal for feedback, while SQuadriga recorded the same signal together with the response channels at `PCB_CENTER` and `PCB_TOP`. All measurements were collected in ArtemiS Suite and served as the basis for computing the Fatigue Damage Spectrum.


== Signal Routing and Sensor Conditioning

#figure(
box(stroke: 1pt + black, inset: 1em)[
  #image("../../Images/Shaker test pictures/shakercontrol.svg", width: 130mm)
],
caption: [Shaker test architecture],
)<shakertestarchitecture>

The selected axis from the `PCB_LEFT` triaxial accelerometer needed to support two independent functions. It had to supply the feedback required for closed loop control in VibControl and it had to provide an unmodified signal for multi channel recording in SQuadriga. To achieve this with a single physical sensor, its output signal was passed through a BNC T-connector. The T-connector produced two electrically identical branches.

@shakertestarchitecture provides a clear overview. One branch of the accelerometer signal was routed to the m+p VibControl frontend, configured in ICP mode to supply constant current and perform signal conditioning for closed loop control. The other branch was sent to the HEAD SQuadriga I, operated in AC coupled mode to read the conditioned voltage without supplying additional power, preventing conflicts between ICP excitation and the SQuadriga input. SQuadriga I and II were linked to record all sensor channels, mirroring the data acquisition setup. For response measurement, SQuadriga I (connected to the laptop) was set to "Control" mode and SQuadriga II to "Module" mode. Data acquisition was managed in HEAD acoustics ArtemiS. This setup ensured the accelerometer was powered only once while supporting both control and data recording.

All accelerometer channels from `PCB_LEFT`, `PCB_CENTER`, and `PCB_TOP` were recorded in ArtemiS Suite. Recording all nine channels for every test direction ensured that the structural response of the backend PCB was fully captured and allowed for a detailed comparison with the analytical spectra.

== Shaker PSD Control & Drive Signal

All tests were conducted under closed loop control with m+p VibControl. In this mode, the software continuously monitored the vibration measured by the control channel and automatically adjusted the drive voltage to match the target PSD. 

The accelerated PSDs were imported in VibEdit in `.csv` format. To ensure safe operation, the shaker's maximum acceleration was limited to 5G. The PSD control included ±3 dB warning limits and ±6 dB abort limits to ensure the drive signal remained within acceptable bounds during testing. The frequency resolution for all tests was set to 1 Hz. Before each test, the calibration for the relevant axis was set according to the direction being tested, using the corresponding value from the calibration sheet to ensure accurate control and measurement.

All the required tests were ran on the backend PCB as mentioned in @finalshakertests. @shakercontrolpsd1 through @shakercontrolpsd6 were printed directly from the PSD control channel windows in m+p VibControl, which illustrate the reference and control PSDs along with the warning and abort limits. The control PSDs will form the basis for calculating FDS. The control PSDs were all under limits and the tests ran without an error.

All required tests were performed on the backend printed circuit board as described in @finalshakertests. @shakercontrolpsd1 through @shakercontrolpsd6 were exported directly from the PSD control channel windows in the m+p VibControl software. These figures display both the reference and control PSDs, as well as warning and abort limits. The control PSDs and the response vibrations measured through the SQuadrigas formed basis for subsequent FDS validations. All control PSDs remained within the specified limits, and the tests were completed successfully without any errors.



#subpar.grid(
  columns: 2,
  figure(
    box(stroke: 1pt+black)[
      #muchpdf(
        read("../../Images/SHAKER_TESTS_ROHAN/Control_LEFT_X_b8_2000Hz_4h_cropped.pdf", encoding: none)
      )
    ],
    caption: [Shaker Control `PCB_LEFT` X-axis, $b=8$, $T_(t e s t)=4h$]
  ),<shakercontrolpsd1>,
  figure(
    box(stroke: 1pt+black)[
      #muchpdf(
        read("../../Images/SHAKER_TESTS_ROHAN/Control_LEFT_Y_b8_2000Hz_4h_cropped.pdf", encoding: none)
      )
    ],
    caption: [Shaker Control `PCB_LEFT` Y-axis, $b=8$, $T_(t e s t)=4h$]
  ),<shakercontrolpsd2>,
  figure(
    box(stroke: 1pt+black)[
      #muchpdf(
        read("../../Images/SHAKER_TESTS_ROHAN/Control_LEFT_Z_b8_2000Hz_4h_cropped.pdf", encoding: none)
      )
    ],
    caption: [Shaker Control `PCB_LEFT` Z-axis, $b=8$, $T_(t e s t)=4h$]
  ),<shakercontrolpsd3>,
  figure(
    box(stroke: 1pt+black)[
      #muchpdf(
        read("../../Images/SHAKER_TESTS_ROHAN/Control_LEFT_X_b9_2000Hz_1.5h_cropped.pdf", encoding: none)
      )
    ],
    caption: [Shaker Control `PCB_LEFT` X-axis, $b=9$, $T_(t e s t)=1.5h$]
  ),<shakercontrolpsd4>,
  figure(
    box(stroke: 1pt+black)[
      #muchpdf(
        read("../../Images/SHAKER_TESTS_ROHAN/Control_LEFT_Y_b9_2000Hz_1.5h_cropped.pdf", encoding: none)
      )
    ],
    caption: [Shaker Control `PCB_LEFT` Y-axis, $b=9$, $T_(t e s t)=1.5h$]
  ),<shakercontrolpsd5>,
  figure(
    box(stroke: 1pt+black)[
      #muchpdf(
        read("../../Images/SHAKER_TESTS_ROHAN/Control_LEFT_Z_b9_2000Hz_1.5h_cropped.pdf", encoding: none)
      )
    ],
    caption: [Shaker Control `PCB_LEFT` Z-axis, $b=9$, $T_(t e s t)=1.5h$]
  ),<shakercontrolpsd6>,
  caption: [Shaker control PSDs for all axes and both fatigue exponents],
)
