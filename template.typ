#let thesis(
  title: "",
  author: "",
  degree: "",
  department: "",
  school: "",
  institution: "",
  date: datetime(year: 2020, month: 10, day: 4,),
  advisor: "",
  committee: (),
  abstract: [],
  signature: [],
  acknowledgements: [],
  dedication: none,
  // Optional section flags with default values
  showSignatures: true,
  showCommittee: true,
  showDedication: true,
  showAcknowledgements: true,
  body,
) = {
  // Document metadata
  set document(author: author, title: title)
  
  // Page setup for A4
  set page(
    paper: "a4",
    margin: (left: 30mm, right: 30mm, top: 30mm, bottom: 30mm),
    numbering: none,
  )

  // Text formatting
  set text(
    font: "times", 
    size: 12pt,
    weight: "regular"
  )
  
  // Double spacing
  set par(
    leading: 2em,
    justify: false,
  )

  // Heading styles
  show heading: it => {
    set block(spacing: 2em)
    set text(weight: "bold")
    align(center)[
      #block(it)
      #v(1em)
    ]
  }

  // Title page
  align(center)[
    #institution
    #v(2em)
    
    #text(size: 18pt, weight: "bold")[#title]
    #v(2em)
    by
    #v(1em)
    #author
    
    #v(12em)
    
    Submitted
    
    in partial fulfillment of the
    
    requirements for the degree of 
    
    #degree
    
    
    #v(12em)



    #school
    
    #institution

    #v(2em)

    #date.display("[month repr:long] [year]")
    
  ]
  
  // Abstract
  page[
    #heading(level: 1, "Abstract")
    #abstract
  ]

  // Optional: Signatures section
  if ((showSignatures) and (signature != [])) {
    pagebreak()
    align(left)[
      #v(8em)
      #signature
    ]
  }

  // Optional: Dedication section
  if ((showDedication) and (dedication != none)) {
    pagebreak()
    align(center)[
      #v(8em)
      #dedication
    ]
  }

  // Optional: Acknowledgements section
  if ((showAcknowledgements) and (acknowledgements != [])) {
    page[
      #heading(level: 1, "Acknowledgements")
      #acknowledgements
    ]
  }

  // Optional: Committee section
  if ((showCommittee) and (committee != ())) {
    page[
      #heading(level: 1, "Committee"),
      #for member in committee {
        member
        v(0.5em)
      }
    ]
  }

  // Table of Contents (automatically updated)
  page[
    #heading(level: 1, "Table of Contents")
    #outline(
      title: none,
      indent: true,
      depth: 3,
    )
  ]

  // List of Figures (automatically updated)
  page[
    #heading(level: 1, "List of Figures")
    #outline(
      title: none,
      target: figure.where(kind: image),
    )
  ]

  // List of Tables (automatically updated)
  page[
    #heading(level: 1, "List of Tables")
    #outline(
      title: none,
      target: figure.where(kind: table),
    )
  ]

  // Main content
  set page(numbering: "1")
  counter(page).update(1)
  
  // Show the main content
  body
}