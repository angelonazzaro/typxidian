#import "pages/cover.typ": coverpage

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

  // TODO: resolve logo not displaying
  coverpage(
    title: title,
    subtitle: subtitle,
    authors: authors,
    supervisors: supervisors,
    logo: logo,
    academic-year: academic-year,
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
    // TODO: filter out front matter headings and make the header appear after and up until a
    // first level heading
    set page(numbering: "1", header: [
      #context counter(page).at(here()).at(0)
      #h(1fr)
      #context query(selector(heading).before(here())).last().body
      #box(line(length: 100%, stroke: 0.2pt))
    ])

    counter(page).update(1)

    {
      // Headings, Header & Footer
      // imitate heading style from Alice in a differentiable wonderland by S.Scardapane
      set heading(numbering: "1.")
      show heading: it => block([
        #if it.level == 1 {
          // TODO: handle blank pages
          colbreak()
          text(28pt)[
            #counter(heading).display("1")
            #h(0.4em)
            #box(line(length: 0.6em, angle: 90deg))
            #h(0.4em)
            #it.body
          ]
          v(0.75em)
        } else {
          it
        }
      ])


      doc
    }


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
