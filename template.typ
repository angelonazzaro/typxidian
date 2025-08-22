#let template(
  title: none,
  subtitle: none,
  description: none,
  keywords: (),
  authors: (),
  lang: "en",
  logo: none,
  figure_dir: "assets/figures",
  after-content: none,
  before-content: none,
  doc,
) = {
  // PREAMBLE: General styles and functions
  set document(title: title, description: description, author: authors, keywords: keywords)
  set text(lang: lang)

  let blue = rgb(2, 122, 255)
  let purple = rgb(120, 82, 238)

  // Links, references and citations coloring and style
  set cite(style: "alphanumeric")
  show cite: set text(fill: purple)

  // Heading & Footer
  set heading(numbering: "1.")

  // Figures & Tables
  set figure(gap: 1.25em)

  // Equations
  // TODO: custom function to set the number under the parent section
  set math.equation(numbering: "(1)")

  // Paragraphs

  // increase spacing between paragraphs and heading, figures and tables
  show heading: set block(above: 2em, below: 0.75em)
  show figure: set block(above: 1.5em, below: 2em)
  show table: set block(above: 1.5em, below: 2em)
  show block: set block(above: 1.5em, below: 1.5em)

  // increase internal spacing between paragraphs
  set par(
    first-line-indent: 0.85em,
    leading: 0.625em, // spacing between lines
    spacing: 0.60em, // spacing between paragraphs
    justify: true,
  )

  set align(center)
  set text(30pt)
  upper(title)

  linebreak()

  if subtitle != none {
    set text(22pt)
    subtitle
  }

  // TODO: find a way to use figure_dir without the need to write the full path everytime
  if logo == none {
    logo = "assets/figures/logo.svg"
  }

  image(logo, width: 50%)

  set text(20pt)
  grid(
    columns: 1fr,
    row-gutter: 15pt,
    ..authors.map(author => [#upper(author)]),
  )

  if before-content != none {
    pagebreak()
    before-content
  }

  set outline.entry(fill: grid(
    columns: 2,
    gutter: 0pt,
    repeat[~.], h(11pt),
  ))

  // from haw-hamburg 0.6.1 template
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): set text(weight: "bold")
  show outline.entry.where(level: 1): set block(above: 16pt)

  set align(left)
  set text(12pt)

  pagebreak()

  outline(
    depth: 3,
    indent: auto,
  )
  pagebreak()

  outline(
    title: [List of Figures],
    target: figure.where(kind: image),
  )

  pagebreak()

  outline(
    title: [List of Tables],
    target: figure.where(kind: table),
  )

  pagebreak()

  {
    set page(numbering: "1")
    counter(page).update(1)

    doc

    pagebreak()

    bibliography("references.bib")
  }

  if after-content != none {
    pagebreak()
    after-content
  }
}
