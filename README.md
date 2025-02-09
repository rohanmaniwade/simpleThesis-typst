# simple-thesis-typst

A simple thesis paper template written in [Typst](https://typst.app/).

## Overview

This repository provides a flexible thesis template that automatically updates the Table of Contents, List of Figures, and List of Tables based on your content. Built with Typst, it offers a customizable `thesis` macro that handles metadata, layout, and several optional sections.

## Contents

- **template.typ**: Contains the `thesis` macro definition, page styles, layout configurations, and custom formatting. Highlights include:
  - A custom title page displaying the institution, title, author, degree details, and submission date (formatted using Typst’s `display` method).
  - Support for optional sections such as Signatures, Dedication, Acknowledgements, and Committee.
  - Automatic generation of the Table of Contents, List of Figures, and List of Tables.
- **main.typ**: Imports the template and demonstrates its usage by supplying metadata and content. Updates to chapter titles or sections automatically refresh the table of contents and figure/table lists.

## Features

- Flexible Structure: Easily toggle optional sections (Signatures, Committee, Dedication, Acknowledgements) and add multiple chapters.
- **Automatic Content Updates**: The Table of Contents, List of Figures, and List of Tables update automatically when you modify the content.
- **Custom Date Formatting**: `datetime.display` method to format dates. ref https://typst.app/docs/reference/foundations/datetime/#definitions-display


## Thesis Structure
```
Thesis
├── Title Page
│   ├── Institution
│   ├── Thesis Title
│   ├── Author Name
│   ├── Degree Details
│   ├── School & Institution
│   ├── Submission Date (formatted as [Month Year])
│   ├── Advisor & Committee Members (optional)
│   └── Signatures (optional)
│
├── Abstract
├── Dedication (optional)
├── Acknowledgements
├── Committee (optional)
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
