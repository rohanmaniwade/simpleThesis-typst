#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/tblr:0.4.1": *
#import "@preview/rowmantic:0.4.0": rowtable
#import "template.typ": thesis
#import "@preview/subpar:0.2.2"

#pagebreak()

= Test Fixture for the Backend PCB

Reliable vibration testing requires a fixture that accurately replicates real mounting conditions. This section outlines the design and validation of the custom test fixture used for the _backend PCB_.




== Design of test fixture

To conduct the accelerated shaker table tests, a custom fixture was required to securely mount the _backend PCB_. The fixture design prioritises replicating the mounting conditions experienced by the _backend_ during actual device operation, which is illustrated by @fixingpointsofbackend, ensuring that the boundary conditions remain consistent with field use.

#let img1 = box(stroke: 1pt+black, inset: 0.1em)[#image("../../Images/fixture/fixturecadwlabels.png")]
#let img2 = box(stroke: 1pt+black, inset: 0.1em)[#image("../../Images/fixture/screw_mounts.png")]

#subpar.grid(columns: 2, inset: 0em,
  figure(img1, caption: [CAD model of fixture]),<fixturecad>,
  figure(img2, caption: [Screw mounting points]),<screwmounts>,
  caption: [_Backend PCB_ test fixture design],
)

The CAD model of the manufactured test fixture was designed in _ANSYS SpaceClaim_, and is shown in @fixturecad and @screwmounts. The bottom plate features _H7/m6_ press fit holes that permanently secure the _m6_ pins in place, whilst the upper plate incorporates _H7/g6_ clearance fit holes. This arrangement allows the upper plate to be guided through the pins, ensuring repeatable positioning and preventing lateral movement during testing.  As illustrated in @screwmounts, the assembly is secured using 8 _M5_ screws to bolt the upper plate to the lower plate, whilst 20 _M5_ screws fasten the bottom plate to the ground plate on the shaker table. Precise alignment between the plates is achieved through m6 tolerance locating pins with carefully selected hole tolerances.

#let img1 = box(stroke: 1pt+black, inset: 0.1em)[#image("../../Images/fixture/fixpoint1.png")]
#let img2 = box(stroke: 1pt+black, inset: 0.1em)[#image("../../Images/fixture/fixpoint2.png")]
#let img3 = box(stroke: 1pt+black, inset: 0.1em)[#image("../../Images/fixture/fixpoint3.png")]
#let img4 = box(stroke: 1pt+black, inset: 0.1em)[#image("../../Images/fixture/fixpoint4.png")]

#subpar.grid(columns: 4,
  figure(img1, caption: [Fix point 1]),<fixpoint1>,
  figure(img2, caption: [Fix point 2]),<fixpoint2>,
  figure(img3, caption: [Fix point 3]),<fixpoint3>,
  figure(img4, caption: [Fix point 4]),<fixpoint4>,
  caption: [Fastening points for the backend fixture],
)

The fixture secures the _backend_ at the same locations used in _Thermomix#super[#sym.trademark.registered] TM7_. These points are demonstrated in @fixpoint1 through @fixpoint4. This approach ensures that the mechanical boundary conditions during testing accurately represent those experienced during normal field operation, allowing for valid correlation between test results and real world performance.

== Modal analysis of test fixture

Before running the accelerated vibration tests, it was essential to understand how the fixture itself behaves dynamically. A modal analysis was performed to identify the fixture's natural frequencies and ensure it would not introduce unwanted vibrations that could interfere with the test results or potentially damage the _backend PCB_.

#let img1 = box(stroke: 1pt+black, inset: 0em)[#image("../../Images/fixture/fixturemesh.png")]
#let img2 = box(stroke: 1pt+black, inset: 0em)[#image("../../Images/fixture/mode1.png")]

#subpar.grid(columns: 2,
  figure(img1, caption: [Fixture mesh]),<fixturemesh>,
  figure(img2, caption: [Mode 1 - 7088.7 Hz]),<fixturemode1>,
  caption: [_ANSYS_ modal analysis of the test fixture],
)

_ANSYS_ finite element analysis was used to conduct the modal analysis. The fixture model included the aluminium material properties and boundary conditions that represent how it mounts to the shaker table. @fixturemesh shows a adaptively sized tetrahedral mesh with element size 1 mm. The first mode shape is visualised in @fixturemode1, showing how the fixture deforms at its fundamental natural frequency.

The key requirement for this analysis was ensuring the first natural frequency of the fixture is at least twice the maximum test frequency of 2000 Hz. This criterion is important because it guarantees the fixture acts as a rigid body throughout the test frequency range, faithfully transmitting vibrations from the shaker table to the _PCB_ without introducing any modal interactions or unwanted amplifications.



#figure(
  table(
    columns: 2,
    align: center,
    stroke: 1pt + black,
    [*Mode*], [*Natural Frequency (Hz)*],
    [Mode 1], [7088.7],
    [Mode 2], [7175.8],
    [Mode 3], [7242.0],
    [Mode 4], [7652.7],
    [Mode 5], [7652.7],
  ),
  caption: [Natural frequencies of the test fixture from _ANSYS_ modal analysis],
)<fixturemodalfreqs>

The results in @fixturemodalfreqs show that the first natural frequency is 7088.7 Hz, which is significantly higher than the 2000 Hz maximum test frequency. This gives a ratio of approximately 3.5, comfortably exceeding the required factor of two. All subsequent modes also sit above 7 kHz, well clear of the test frequency range. These results validate the fixture design, confirming it will behave as a rigid mounting platform throughout the vibration tests and maintain the integrity of the test conditions.


