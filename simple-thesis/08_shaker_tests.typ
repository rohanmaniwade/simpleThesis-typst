#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "@preview/rowmantic:0.4.0": rowtable
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

= Shaker Table Tests

With the accelerated PSD profiles calculated and validated for severity, experimental verification was needed to confirm the methodology works in practice. The backend PCB was mounted in the test fixture and subjected to the accelerated vibration profiles on an electrodynamic shaker table controlled by m+p VibControl software.

The goal was to verify that the accelerated profiles produce the same fatigue damage as the field measurements. During each test, response accelerations were recorded at the same sensor locations used during field data acquisition. The FDS was then computed from these measured responses and compared against the target FDS derived from field data. Good agreement between the two would confirm that the shaker accurately reproduces the intended fatigue conditions.

Accelerated profiles were generated for both fatigue exponents, $b=8$ and $b=9$, to evaluate their influence on test specifications. However, as discussed in @limitsoftimecompression and illustrated in @testtimereduction, there are practical limits on how much a test can be compressed whilst maintaining realistic severity levels.

For the 924-hour equivalent PSD, the maximum achievable time compression differs depending on the fatigue exponent. With $b=8$, the compression factor is limited to 256, giving a minimum test duration of,

$ T_(t e s t)= 924/256 = 3.6 approx 4 "hours" $

For $b=9$, the higher exponent allows greater compression up to a factor of 640, reducing the minimum test duration to,

$ T_(t e s t)= 924/640 = 1.44 approx 1.5 "hours" $

These calculations establish the lower bounds for test duration. Attempting to compress further would require severity levels that exceed the reference shock limits, resulting in unrealistic test conditions.

== Shaker Control

Random vibration testing demands precise control to ensure the shaker table accurately reproduces the target PSD. The m+p VibControl software achieves this through a feedback system that continuously monitors and adjusts the vibration output. A control accelerometer mounted on the backend PCB measures the actual vibration being generated, and this signal is used to regulate the drive input to the shaker table.

The software compares the measured PSD from the control accelerometer against the specified target PSD. When discrepancies arise, the system automatically adjusts the drive signal to bring the actual vibration into alignment with the target specification. This iterative adjustment process continues until the system reaches a stable state where the measured output matches the desired input.

The control accelerometer was positioned at the `PCB_LEFT` location on the backend. Initial attempts to control the shaker from `PCB_TOP` or `PCB_CENTER` resulted in poor coherence errors during the "Self Test", indicating insufficient correlation between the drive signal and the measured response. These locations are too far from the mounting points and exhibit excessive compliance, making them unsuitable for control purposes. `PCB_LEFT` proved to be the most mechanically stable position and provided reliable control signal quality. 

In vibration testing practice, one sensor location serves as the control point whilst additional accelerometers record the response at other positions of interest. This approach allows subsequent analysis to determine whether different areas of the structure experience higher or lower fatigue damage than the control location. By comparing the FDS at each response position against the control position, it becomes possible to identify regions that may be overtested or undertested relative to the specified profile.

The sensors used for data acquisition were used once again for the shaker tests. Each sensor used for data acquisition was used in the same position for the shaker tests. 3 triaxial sensors in `PCB_LEFT`, `PCB_CENTER`, and `PCB_TOP` were used. Since the shaker was uniaxial, the fixture was oriented in X, Y, and Z positions using an auxiliary fixture. 