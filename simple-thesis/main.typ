// main.typ
#import "template.typ": thesis
#show: doc => thesis(
  title: "Your Thesis Title:
  Optional Subtitle Here",
  author: "Your Full Name",
  degree1: "Your First Degree",
  degree2: "Your Second Degree",
  department: "Your Department",
  school1: "Your First School",
  school2: "Your Second School",
  institution1: "Your First Institution",
  institution2: "Your Second Institution",
  advisor: "Your Advisor's Name",
  date: datetime(year: 2024, month: 1, day: 1,),
  committee: ("Committee Member 1", "Committee Member 2", "Committee Member 3"),
  // Optional section toggles:
  showSignatures: false,        // true or false
  showCommittee: false,         // true or false
  showDedication: false,        // true or false
  showAcknowledgements: false,  // true or false
  showPublications: true,       // true or false
  publications: (
    [This thesis includes the following publications:],
    [Publication 1. (Year). Title. Journal/Conference. DOI/URL],
    [Publication 2. Authors. "Title." *Venue*, Location, Date.],
  ),
  abstract: [
    #lorem(200)
  ],
  acknowledgements: [
    [Your acknowledgements text here]
  ],
  dedication: [
    [Your dedication text here]
  ],
  doc,
)

= Introduction
== Background
#lorem(150)

== Research Question
#lorem(100)

= Literature Review
== Topic Area 1
#lorem(200)

== Topic Area 2
#lorem(200)

= Methodology
== Research Design
#lorem(150)

== Data Collection
#lorem(150)

= Results
== Finding 1
#lorem(200)

== Finding 2
#lorem(200)

= Discussion
== Analysis
#lorem(250)

== Implications
#lorem(250)

= Conclusion
== Summary
#lorem(150)

== Future Work
#lorem(150)

#bibliography("references.bib", style: "ieee")