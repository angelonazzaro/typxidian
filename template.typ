/**** UTILITY FUNCTIONS AND CUSTOM BLOCKS ******/

// create LaTeX-like paragraphs
// TODO: add label? In that case, I need to create a referenceable element with figure
#let paragraph(title, body, spacing: 1.35em) = block(spacing: spacing, [
  #strong(title) #h(0.35em) #body
])


/**** TEMPLATE ******/

#let template(
  title: none,
  subtitle: none,
  description: none,
  keywords: (),
  authors: (),
  supervisors: (),
  academic-year: none,
  lang: "en",
  logo: none,
  figure_dir: "assets/figures",
  after-content: none,
  before-content: none,
  include-credits: true,
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
  // TODO: find internal color
  show ref: set text()

  show link: it => {
    if type(it.dest) == str {
      // external link
      text(fill: blue)[#it.body]
    } else {
      // internal reference
      it.body
    }
  }

  // Heading & Footer
  set heading(numbering: "1.")

  // Figures, Tables & Equations
  set figure(gap: 1.25em)

  // TODO: customize numbering so that it is dependent on section
  // for instance, under section 1., each figure/table/equation will be numbered as (1.X)

  // reset sub-counters at each new section
  show heading.where(level: 1): it => {
    counter(figure).update(1)
    counter(math.equation).update(1)
    it
  }

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

  // Lists
  set list(spacing: 0.75em)
  set enum(spacing: 0.75em)

  // Cover page
  {
    set page(margin: (top: 4em, bottom: 1em))
    set align(center)
    set text(32pt, weight: "bold")
    upper(title)

    linebreak()

    set text(weight: "regular")

    if subtitle != none {
      v(0.25em)
      set text(22pt)
      subtitle
    }

    // TODO: find a way to use figure_dir without the need to write the full path everytime
    if logo == none {
      logo = "assets/figures/logo.svg"
    }

    image(logo, width: 50%)

    set text(20pt)

    v(0.35em)

    if authors.len() > 0 and supervisors.len() == 0 {
      let ncols = calc.max(calc.div-euclid(authors.len(), 3), 1)

      grid(
        columns: (1fr,) * ncols,
        row-gutter: 15pt,
        ..authors.map(author => [#upper(author)])
      )
    } else {
      set text(16pt)

      grid(
        columns: (1fr, 1fr),
        gutter: 20pt,
        row-gutter: 15pt,
        grid(
          columns: 1fr,
          row-gutter: 15pt,
          [
            *SUPERVISORS* \

            #stack(
              dir: ttb,
              spacing: 15pt,
              ..supervisors.map(s => [#upper(s)]),
            )
          ],
        ),
        grid(
          columns: 1fr,
          row-gutter: 15pt,
          [
            *AUTHORS* \

            #stack(
              dir: ttb,
              spacing: 15pt,
              ..authors.map(a => [#upper(a)]),
            )
          ],
        ),
      )
    }

    if academic-year != none {
      v(4em)
      set text(13pt)
      [Academic year: #academic-year]
    }
  }

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
  set text(11.5pt)

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

  if include-credits == true {
    {
      set page(margin: (top: 15em))

      align(center + horizon, [
        *This document was written using _TypXidian_*,
        a Typst template inspired by Obsidian. \ If you'd
        like to contribute to the project, please open
        an issue or a pull request on our github repository.

        #v(0.75em)
        #link("https://github.com/angelonazzaro/typxidian")[Github Repository.]
      ])
    }
  }
}
