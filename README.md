# simple-thesis-typst
Simple thesis paper template written in [Typst](https://typst.app/).

- **template.typ**: Contains the thesis macro definition, page styles, and layout configurations.
- **main.typ**: Imports the template and demonstrates how to use it by supplying metadata and content. Changes made here (e.g., updating chapter titles or sections) automatically update the table of contents and lists of figures/tables.

## Features

- **Interactive Content Updates**: Automatically updates the Table of Contents, List of Figures, and List of Tables when you modify the content.
- **Flexible Structure**: Supports sections for Abstract, Dedication, Acknowledgements, and multiple chapters.
- **Consistent Formatting**: Predefined page layout and text styling for a professional thesis appearance.

## Thesis Structure
```
Thesis
├── Title Page
│   ├── Thesis Title
│   ├── Author Name
│   ├── Degree, Department, School, Institution
│   ├── Submission Date
│   ├── Advisor & Committee Members
│   └── Signatures (optional)
│
├── Abstract
├── Dedication (optional)
├── Acknowledgements
├── Table of Contents (auto-generated)
├── List of Figures (auto-generated)
├── List of Tables (auto-generated)
│
├── Chapters
│   ├── Introduction
│   │   ├── Background
│   │   └── Motivation
│   ├── Literature Review
│   │   ├── Subsection One
│   │   └── Subsection Two
│   ├── Methodology
│   ├── Results and Discussion
│   └── Conclusion
│
└── References / Bibliography
```
