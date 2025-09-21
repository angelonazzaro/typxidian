# TypXidian Template

**TypXidian** is a Typst template for academic documents, such as theses, dissertations, and reports.  


---

## ✨ Features

- Predefined title page with support for:
  - Title, subtitle, authors, supervisors
  - University, faculty, department, degree
  - Academic year, abstract, and keywords
- Configurable citation and reference styles
- Customizable colors for citations, references, and links
- Built-in support for **bibliographies** and **abbreviations**
- Callout boxes inspired by [Obsidian](https://obsidian.md/) for notes, tips, and warnings
- Configurable fonts, paper sizes, and languages

---

## 📂 Project Structure

```
.
├── main.typ          # Example document using the template
├── typxidian.typ     # The template definition
├── abbreviations.typ # Example list of abbreviations
├── bibliography.bib  # Example bibliography file
```

---

## 🚀 Usage

### 1. Import the Template

In your `.typ` file, import the template:

```typst
#import "@preview/typxidian:0.1.1": *
```

or locally:

```typst
#import "typxidian.typ": *
```

---

### 2. Apply the Template

Use the `template` function with your metadata:

```typst
#show: template.with(
  title: [TypXidian],
  authors: ("Giuseppe Verdi", ),
  supervisors: ("Prof. Mario Rossi", "Prof. Mario Bianchi"),
  subtitle: [A template for academic documents written in Typst],
  university: [University of Salerno],
  faculty: [Faculty of Science],
  degree: [Master's Degree in Machine Learning & Data Science],
  department: [Department of Computer Science],
  academic-year: [2025/2026],
  abstract: lorem(150),
  quote: [
    #lorem(20)
    \ \ #align(right, [-- John Doe])
  ],
  bib: bibliography("bibliography.bib"),
  abbreviations: abbreviations,
)
```

---

### 3. Write Your Content

Add sections after the template definition:

```typst
= Introduction

*TypXidian* is a template designed for academic writing, suitable for theses and reports.

== Example Callout
> [!note]  
> This is a note box, similar to Obsidian callouts.
```

---

## 📖 Example Output

When compiled, the example (`main.typ`) generates a thesis-style document with:

- A formatted title page
- Abstract and quote
- Automatic bibliography management
- Styled sections and headings

---

## 🛠 Requirements

- [Typst](https://typst.app/) v0.11.0 or later
- Optional: A `.bib` file for bibliography
- Optional: An `abbreviations.typ` file for acronyms

---

## 📚 Example Files

- `main.typ` → Example document
- `abbreviations.typ` → Example abbreviations list
- `bibliography.bib` → Example BibTeX file

You can compile the example with:

```bash
typst compile main.typ
```

---

## 🎨 Illustration

Here is a sample illustration of the title page produced:

![Example Title Page](docs/titlepage.png)

---

## 📜 License

This project is distributed under the MIT License.
