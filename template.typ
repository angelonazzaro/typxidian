#let template(
  title: none,
  subtitle: none,
  description: none,
  keywords: (),
  authors: (),
  supervisors: (),
  lang: "en",
  font: "Bitstream Charter",
  citation-style: "alphanumeric",
  bib-file: "bibliography.bib",
  before-content: none,
  after-content: none,
  is-thesis: false,
  include-credits: true,
  doc,
) = {
  set document(title: title, description: description, author: authors)
  set text(lang: lang, font: font)

  /*** PREAMBLE - General styles ***/
  import "@preview/headcount:0.1.0": *
  

  set cite(style: citation-style)

  /*** FRONT MATTER ***/

  /*** MAIN MATTER ***/

  // Customize figures and equations to make counters depend on the current chapter number
  set heading(numbering: "1.1")
  set figure(numbering: dependent-numbering("1.1", levels: 1))
  set math.equation(numbering: dependent-numbering("1.1", levels: 1))
  
  {
    doc
  }

  /*** BACK MATTER ***/

  bibliography(bib-file)

  if after-content != none {
    after-content
  }

  if include-credits != none {
    pagebreak()
  }
}
