// Define variables
#let whatIsIt = "Master's Thesis"
#let title = "Development of a Methodology for Accelerating Vibration Endurance Tests on Complex Assemblies"
#let faculty = "Institude for Sustainable and Autonomous Maritime Systems (INAM)"
#let author = "Rohan Maniwade"
#let addrLineEins = "Kammerstraße 206"
#let addrLineZwei = "47057, Duisburg, Germany"
#let matrikelNr = "3157316"
#let betreuerEins = "Clément Gorges Corselli"
#let betreuerZwei = "Dr.-Ing. Philipp Ingenlath" 
#let ersterGutachter = "Prof. Dr.-Ing. Bettar Ould el Moctar"
#let zweiterGutachter = ""
#let fach = "M.Sc. Mechanical Engineering (Mechatronics)"
#let semester = "Summer Semester 2025"
#let date = "31.10.2025"

// Set the page layout
#set page(
  paper: "a4",
  margin: (1in),
)

// Title page content
 #align(right)[
  #image("logo_uni_due.svg", width: 40%)
]

#set align(horizon+center)
#set par(justify: true)
#text(size: 20pt)[
  #whatIsIt
]

#text(size: 20pt)[
  *#title*
]


#text(12pt)[
  Presented to the #faculty\
in the University of Duisburg Essen &\
Performed at Vorwerk Elektrowerke GmbH & Co. KG Wuppertal
]
#v(5mm)

#text(12pt)[
  by
]

#text(15pt)[
#author\
Matriculation No.: #matrikelNr\
#v(20mm)


#text(size: 12pt)[
#grid(
  columns: 2,
  rows: 7,
  column-gutter: 5mm,
  row-gutter: 3mm,
  align: (left, left),
 
 [Examiner], [#ersterGutachter],
 [Supervisors:], [#betreuerEins],
 [], [#betreuerZwei],
 [Degree Program:], [#fach],
 [Academic Semester:], [#semester],
 [Date:], [#date]
)
]
]
#v(10mm)

#align(center)[
  #image("Vorwerk_VW_Original_green_RGB.svg", width: 15%)
]




