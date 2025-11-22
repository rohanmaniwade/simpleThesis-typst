#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "@preview/rowmantic:0.4.0": rowtable
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

= Shaker Table Tests

[ADD IMAGES]

The accelerated PSD profiles developed in the previous chapters were validated experimentally on a uniaxial electrodynamic shaker. The purpose of these tests was to reproduce the accelerated vibration environment on hardware, measure the structural responses on the backend PCB, and verify whether the accelerated PSDs generated in software can be stably executed in closed loop control. The shaker tests also provided the measured data required to compute the Fatigue Damage Spectrum and the Extreme Response Spectrum directly from hardware, which was essential for evaluating the equivalence between the analytical predictions and the physical test responses.

== Shaker System

The experimental tests were carried out using a uniaxial electrodynamic shaker system, the TIRA TV 55240 LS 340, which provides controlled broadband random excitation suitable for durability of lightweight electronic assemblies. The system supports operation from 2 Hz to 3000 Hz and delivers a sinusoidal force capacity of approximately 4 KN, which is more than sufficient for exciting the backend PCB and the fixture assembly encasing it. 

The shaker is driven by a matched power amplifier and includes forced air cooling, automatic armature centering and standard vibration test safety features. These characteristics ensure stable operation during long duration random vibration tests while maintaining control accuracy. Detailed hardware specifications and dimensional data for the shaker, amplifier, and cooling unit are provided in the appendix. [INSERT APPENDIX ENTRY]



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



The shaker used in this study is uniaxial and can therefore excite only one direction at a time. As a result, a single point and single axis control strategy was necessary. Among the three installed sensors, the `PCB_LEFT` location demonstrated the strongest and most stable mechanical coupling during the self test procedure, while `PCB_TOP` and `PCB_CENTER` showed poor coherence values. The `PCB_LEFT` position consistently produced high coherence between the shaker drive and the measured response, which is essential for reliable closed loop control. For this reason, the `PCB_LEFT` accelerometer served as the control sensor for every test.

Although the sensor at `PCB_LEFT` measures three orthogonal directions, only one of these axes was used for control during a given test. The selected axis always matched the physical direction of imposed vibration. When the fixture was oriented so that the Z axis pointed upward, the Z channel of the `PCB_LEFT` accelerometer was used as the control channel. The same principle was applied for X axis and Y axis excitation by rotating the fixture accordingly. An auxiliary mounting plate was used to orient the fixture in the required test directions, as illustrated in Figure X [INSERT AUXILIARY FIXTURE IMAGE AND TAG IT HERE]. This ensured that the control channel always aligned with the correct structural degree of freedom.

During each test, the selected axis of the `PCB_LEFT` accelerometer provided the feedback signal for closed loop control, while all axes of all sensors were recorded simultaneously. The control signal was split using a T-connector so that VibControl received the conditioned accelerometer signal for feedback, while SQuadriga recorded the same signal together with the response channels at `PCB_CENTER` and `PCB_TOP`. All measurements were collected in ArtemiS Suite and served as the basis for computing the Fatigue Damage Spectrum.

== Signal Routing and Sensor Conditioning

[CHECK THIS TEXT]

The selected axis from the `PCB_LEFT` triaxial accelerometer needed to support two independent functions. It had to supply the feedback required for closed loop control in VibControl and it had to provide an unmodified signal for multi channel recording in SQuadriga. To achieve this with a single physical sensor, its output signal was passed through a BNC T connector. The T connector produced two electrically identical branches.

One branch was routed to the m+p VibControl frontend where the input was configured in ICP mode. In this mode the controller supplied the constant current required to power the accelerometer and performed the necessary signal conditioning for the closed loop algorithm. The second branch was routed to the HEAD SQuadriga III. That input was operated in AC coupled mode, allowing it to read the conditioned voltage signal without providing additional sensor power. This prevented any conflict between ICP excitation and the SQuadriga measurement input. With this architecture the accelerometer was powered only once while its signal supported both control and data acquisition.

All accelerometer channels from `PCB_LEFT`, `PCB_CENTER`, and `PCB_TOP` were recorded in ArtemiS Suite. Recording all nine channels for every test direction ensured that the structural response of the backend PCB was fully captured and allowed for a detailed comparison with the analytical spectra.

== Frequency Resolution and PSD Discretisation

[CHECK THIS TEXT]

All shaker tests were executed with a frequency resolution of one hertz in m+p VibControl. The test spectrum was therefore divided into one hertz intervals, and the controller updated the drive level in each interval independently. A one hertz resolution offers a balance between spectral detail and stable control behaviour. The backend PCB exhibits several narrow resonant modes whose bandwidths are typically a few hertz wide. A one hertz resolution allows these modes to be represented with sufficient precision. At the same time, it avoids the excessive averaging time and noise sensitivity associated with finer resolutions.

Using the same frequency resolution that was used during the computation of the Fatigue Damage Spectrum and the synthesis of the accelerated PSD ensured consistency between the analytical and experimental stages of this work.

== Closed Loop Operation in VibControl

[CHECK THIS TEXT]

The tests were performed under closed loop control using m+p VibControl. In this operating mode the software continuously compared the measured vibration of the control channel with the target PSD and adjusted the drive voltage until both matched. To estimate the measured PSD, the incoming acceleration signal was transformed into the frequency domain using repeated fast Fourier transforms. The controller averaged consecutive blocks to obtain a stable and repeatable spectrum.

The measured PSD was compared with the accelerated target PSD at every frequency band. The controller responded to deviations by increasing the drive where the vibration response was too low and decreasing it where the response was too high. This iterative adjustment process continued until the measured PSD was within the specified tolerance band around the target. During the test VibControl monitored the running root mean square acceleration and the response of all non control sensors. If any sensor approached the permissible limits, the controller reduced the drive in the corresponding frequency range. This behaviour is known as notching and it prevents local overload and unintended damage to the test item.

Before each test the control system performed a self test to verify linear behaviour and coherence. The `PCB_LEFT` location consistently produced stable coherence values, while `PCB_CENTER` and `PCB_TOP` showed reduced coherence due to more compliant local geometry. For this reason only `PCB_LEFT` was used for closed loop control and the other sensors served as response channels.

== Multi Axis Testing Through Fixture Reorientation

[CHECK THIS TEXT]

The shaker produced vibration along a single axis, so the backend PCB was tested in all three orthogonal directions by reorienting the fixture. For Z axis testing the fixture was positioned so that the PCB experienced vertical excitation. For X axis and Y axis testing the fixture was rotated so that the PCB experienced horizontal excitation in the corresponding direction. In each case the control channel was selected from the appropriate axis of the `PCB_LEFT` accelerometer. All remaining axes of all sensors were recorded during every test which provided a complete picture of the three dimensional vibration behaviour of the PCB.

This approach ensured that the accelerated PSD profiles were evaluated in all three structural directions of the backend PCB, despite the uniaxial nature of the shaker.