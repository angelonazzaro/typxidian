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

  // Color palette
  let purple = rgb("7952ee")
  let darkgray = rgb("#6d6e6d")
  let cyan = rgb("53dfdd")
  let red = rgb("fb464c")
  let orange = rgb("e9973f")
  let green = rgb("44cf6e")

  // Font sizes

  set cite(style: citation-style)
  show cite: set text(fill: purple)

  show link: it => {
    if type(it.dest) == str {
      // ext link
      text(fill: blue)[#underline(it.body)]
    } else {
      it.body
    }
  }

  /*** FRONT MATTER ***/

  /*** MAIN MATTER ***/

  // Customize figures and equations to make counters depend on the current chapter number
  set heading(numbering: "1.1")
  set figure(numbering: dependent-numbering("1.1", levels: 1))
  set math.equation(numbering: dependent-numbering("(1.1)", levels: 1))

  show heading: reset-counter(counter(figure))
  show heading: reset-counter(counter(math.equation))

  {
    set page(
      numbering: "1",
      header-ascent: 40%,
      header: context {
        // mimic header style from 'Alice in a Differentiable Wonderland' by S.Scardapane
        let curr-page = counter(page).get().first()
        // check if there is a one-level heading on the same page, if so dont's display the
        // header
        let next-h1 = query(
          selector(heading.where(level: 1)).after(here()),
        ).first()
        let next-h1-page = counter(page).at(next-h1.location()).first()

        if curr-page > 1 and next-h1-page > 1 and next-h1-page != curr-page {
          set text(fill: darkgray)

          let body = block(inset: 0pt, spacing: 0pt, [
            #if calc.even(curr-page) {
              let header-title = query(selector(heading).before(here()))
                .last()
                .body
              [#curr-page #h(1fr) #header-title]
            } else {
              let header = query(
                selector(heading.where(level: 1)).before(here()),
              ).last()

              [Chapter #counter(heading).at(header.location()).at(0): #header.body #h(1fr) #curr-page]
            }

            #box(line(length: 100%, stroke: 0.2pt))
          ])

          let alignment = if calc.even(curr-page) { right } else { left }
          align(alignment, body)
        }
      },
    )
    counter(page).update(1)

    doc
  }

  /*** BACK MATTER ***/

  show bibliography: bib => {
    show grid: g => {
      let rows = g
        .children
        .chunks(2) // each row = 2 cells (key + body)
        .map(row => block(
          width: 100%,
          [
            // key in a fixed-width box
            #box(width: 4.5em, baseline: -14.5pt, align(left)[#row.at(0).body])
            #h(0.75em)
            // body stretches and wraps
            #box(width: 1fr, align(left)[#row.at(1).body])
            #v(0.35em)
          ],
        ))
      rows.join()
    }
    bib
  }

  bibliography(bib-file)

  if after-content != none {
    after-content
  }

  if include-credits != none {
    pagebreak()
  }
}
