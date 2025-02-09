#import "template.typ": thesis

#show: doc => thesis(
  title: "Yoursdfsdfsf Thesis Title",
  author: "Chanwoo Lee",
  degree: "Master of Science & Master of Arts",
  department: "Innovation Design Engineering",
  school: "Dyson School of Design Engineering & School of Design",
  institution: "Imperial College London & Royal College of Art",
  advisor: "Professor Name",
  
  date: datetime(year: 2025, month: 10, day: 4,),

  committee: ("Committee Member 1", "Committee Member 2", "Committee Member 3"),
  
  // Optional section toggles:
  showSignatures: true,      // true or false
  showCommittee: true,       // true or false
  showDedication: true,       // true or false
  showAcknowledgements: true, // true or false
  
  abstract: [
    This thesis presents... [Your abstract text here]
  ],
  
  acknowledgements: [
    I would like to thank... [Your acknowledgements here]
  ],
  
  dedication: [
    To my family... [Your dedication here]
  ],
  
  doc,
)

= Introduction
#set par(justify: true, first-line-indent: 2em)

Your introduction text goes here. The template will automatically update the table of contents as you add or modify sections.

== Background
Your background section goes here.

== Motivation

= Literature Review
Your literature review goes here.

== Subsection One
Content for subsection one.

== Subsection Two
Content for subsection two.

= Methodology
Your methodology goes here.

= Results and Discussion
Your results and discussion goes here.

// #figure(
//   image("path/to/your/figure.png", width: 80%),
//   caption: "Your figure caption here",
// ) <fig-label>

// You can reference figures like this: @fig-label

= Conclusion
Your conclusion goes here.

#bibliography("references.bib", style: "ieee")