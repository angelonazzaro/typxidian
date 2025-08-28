#import "pages/cover.typ": coverpage

#import "@preview/fontawesome:0.6.0": fa-icon

#import "@preview/cetz:0.4.1" // drawing inspired by tikz
#import "@preview/booktabs:0.0.4" // booktabs-like tables
#import "@preview/wrap-it:0.1.1" // wrap figures around text
#import "@preview/subpar:0.2.2" // create subfigures
#import "@preview/decasify:0.10.1": sentencecase
#import "@preview/headcount:0.1.0": *

// Color palette
#let info-title = rgb(48, 107, 246)
#let info-bg = rgb(234, 240, 251)

#let faq-title = rgb(221, 124, 46)
#let faq-bg = rgb(252, 242, 234)

#let tip-title = rgb(86, 188, 187)
#let tip-bg = rgb(238, 248, 248)

#let success-title = rgb(84, 182, 81)
#let success-bg = rgb(238, 248, 236)

#let danger-title = rgb(214, 64, 67)
#let danger-bg = rgb(251, 236, 238)

#let purple = rgb(120, 82, 238)
#let darkgray = rgb("#6d6e6d")
#let cyan = rgb("53dfdd")
#let red = rgb("fb464c")
#let orange = rgb("e9973f")
#let green = rgb("44cf6e")

// Font sizes
#let body-size = 13.5pt

/**** UTILITY FUNCTIONS AND CUSTOM BLOCKS ****/

// Create LaTeX-like paragraphs
// TODO: add label? In that case, I need to create a referenceable element with figure
#let paragraph(title, body, spacing: 1.35em) = block(spacing: spacing, [
  #strong(title) #h(0.35em) #body
])

// Callout boxes
// inspired from babble-bubbles package

// TODO: fix caption and numbering display issues
#let callout(
  body,
  kind: "callout",
  supplement: [Call.],
  title: "Callout",
  fill: blue,
  title-color: white,
  body-color: black,
  icon: none,
) = {
  figure(
    caption: none,
    block(below: 1em, box(
      radius: 0.2em,
      inset: (top: 0.75em, bottom: 1em, right: 0.75em, left: 0.75em),
      width: 100%,
      fill: fill,
      clip: true,
      [
        #text(fill: title-color, weight: "bold", size: 13.5pt)[
          #if icon != none {
            icon
            h(0.15em)
          }
          #title #h(0.15em) (#supplement #context counter(figure.where(kind: kind)).display(dependent-numbering("1.1")))]
        \
        #text(fill: body-color)[#body]
      ],
    )),
    supplement: supplement,
    kind: kind,
  )
}

#let info(
  body,
  title: "Info",
  icon: fa-icon("info-circle"),
  supplement: [Info.],
) = {
  callout(
    body,
    title: title,
    fill: info-bg.saturate(5%),
    title-color: info-title,
    icon: icon,
    supplement: supplement,
    kind: "info",
  )
}

#let faq(
  body,
  title: "FAQ",
  icon: fa-icon("question-circle"),
  supplement: [FAQ.],
) = {
  callout(
    body,
    title: title,
    fill: faq-bg.saturate(5%),
    title-color: faq-title,
    icon: icon,
    supplement: supplement,
    kind: "faq",
  )
}

#let tip(
  body,
  title: "Tip",
  icon: fa-icon("lightbulb"),
  supplement: [Tip.],
) = {
  callout(
    body,
    title: title,
    fill: tip-bg.saturate(5%),
    title-color: tip-title,
    icon: icon,
    supplement: supplement,
    kind: "tip",
  )
}

#let success(
  body,
  title: "Success",
  icon: fa-icon("times-circle"),
  supplement: [Succ.],
) = {
  callout(
    body,
    title: title,
    fill: success-bg.saturate(5%),
    title-color: success-title,
    icon: icon,
    supplement: [Succ.],
    kind: "success",
  )
}

#let danger(
  body,
  title: "Danger",
  icon: fa-icon("times-circle"),
  supplement: [Dang.],
) = {
  callout(
    body,
    title: title,
    fill: danger-bg.saturate(5%),
    title-color: danger-title,
    icon: icon,
    supplement: supplement,
    kind: "danger",
  )
}

// TODO: handle numbering and referencing
#let math-callout(body, title, supplement, kind, stroke-fill) = {
  figure(
    block(
      inset: (top: 0.75em - 0.7em, bottom: 0.75em - 0.45em, right: 0.75em, left: 0.75em),
      width: 100%,
      clip: true,
      stroke: (left: 2.5pt + stroke-fill),
      [
        #strong([
          #sentencecase(supplement)
          #context counter(figure.where(kind: kind)).display(dependent-numbering("1.1"))
          (#title)]) #h(
          0.15em,
        ) #emph(body)
      ],
    ),
    kind: kind,
    supplement: supplement,
  )
}

#let definition(
  body,
  title: "Definition",
  supplement: [Definition],
) = {
  math-callout(
    body,
    title,
    supplement,
    "definition",
    purple,
  )
}

#let theorem(
  body,
  title: "Theorem",
  supplement: "Theorem",
) = {
  math-callout(
    body,
    title,
    "Theorem",
    "theorem",
    blue,
  )
}



/**** TEMPLATE ****/

#let template(
  title: none,
  subtitle: none,
  description: none,
  abstract: none,
  keywords: (),
  authors: (),
  supervisors: (),
  academic-year: none,
  font: "Bitstream Charter",
  lang: "en",
  logo: none,
  figure-dir: "assets/figures",
  after-content: none,
  before-content: none,
  include-credits: true,
  doc,
) = {
  // PREAMBLE: General styles and functions
  set document(title: title, description: description, author: authors, keywords: keywords)
  set text(lang: lang, font: font)

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
  show figure.caption: it => [
    #strong(it.supplement)~#strong(context it.counter.display(it.numbering))#it.separator~#it.body
  ]

  show figure: set figure(numbering: dependent-numbering("1.1"))
  show figure.where(kind: image): set figure(
    supplement: [Fig.],
  )
  show figure.where(kind: table): set figure(
    supplement: [Tab.],
  )

  let envs = ("callout", "info", "faq", "success", "tip", "danger", "theorem", "definition")

  show figure: it => {
    if it.kind in envs {
      align(left)[#it.body]
    } else {
      it
    }
  }

  set math.equation(
    numbering: dependent-numbering("(1.1)"),
    supplement: [Eq.],
  )
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

  // COVER PAGE
  coverpage(
    title: title,
    subtitle: subtitle,
    authors: authors,
    supervisors: supervisors,
    logo: logo,
    academic-year: academic-year,
  )

  set page(numbering: "i", margin: (inside: 50pt, outside: 80pt))
  set text(body-size)

  counter(page).update(1)
  // FRONT MATTER
  if before-content != none {
    pagebreak()
    before-content
  }

  if abstract != none {
    align(center, text(22pt)[= Abstract])
    abstract
  }

  include "pages/toc.typ"

  // MAIN MATTER
  {
    {
      set page(
        numbering: "1",
        header-ascent: 45% + 0pt,
        header: context {
          let curr-page = counter(page).get().first()
          // check if there is a one-level heading on the same page, if so dont's display the
          // header
          let next-h1 = query(selector(heading.where(level: 1)).after(here())).first()
          let next-h1-page = counter(page).at(next-h1.location()).first()

          if curr-page > 1 and next-h1-page > 1 and next-h1-page != curr-page [
            #set text(fill: darkgray)

            #let body = block(inset: 0pt, spacing: 0pt, [
              #if calc.even(curr-page) {
                let header-title = query(selector(heading).before(here())).last().body
                [#curr-page #h(1fr) #header-title]
              } else {
                let header = query(selector(heading.where(level: 1)).before(here())).last()
                [Chapter #counter(heading).at(header.location()).at(0): #header.body #h(1fr) #curr-page]
              }
              #box(line(length: 100%, stroke: 0.2pt))
            ])
            #let alignment = if calc.even(curr-page) { right } else { left }
            #align(alignment, body)
          ]
        },
      )

      // Headings, Header & Footer
      // imitate heading style from Alice's Adventures in a Differentiable Wonderland by S.Scardapane
      set heading(numbering: "1.")
      show heading.where(level: 1): it => block([
        // reset sub-counters at each new section
        #context counter(figure.where(kind: image)).update(0)
        #context counter(figure.where(kind: table)).update(0)
        #context counter(math.equation).update(0)

        #text(30pt)[
          #counter(heading).display("1")
          #h(0.8em)
          #box(line(length: 1em, stroke: 1.65pt + gray, angle: 90deg), baseline: 6pt)
          #h(0.8em)
          #it.body
        ]
        #v(0.75em)
      ])

      counter(page).update(1)
      doc
    }

    pagebreak()

    set page(header: none)
    bibliography("references.bib")
  }

  // BACK MATTER
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
