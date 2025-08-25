#import "pages/cover.typ": coverpage

#import "@preview/fontawesome:0.6.0": fa-icon

#import "@preview/cetz:0.4.1" // drawing inspired by tikz
#import "@preview/booktabs:0.0.4" // booktabs-like tables
#import "@preview/wrap-it:0.1.1" // wrap figures around text
#import "@preview/subpar:0.2.2" // create subfigures

// Color palette
#let blue = rgb(2, 122, 255)
#let purple = rgb(120, 82, 238)
#let darkgray = rgb("#6d6e6d")
#let cyan = rgb("53dfdd")
#let red = rgb("fb464c")
#let orange = rgb("e9973f")
#let green = rgb("44cf6e")

// Font sizes
#let body-size = 12.5pt

/**** UTILITY FUNCTIONS AND CUSTOM BLOCKS ****/

// Create LaTeX-like paragraphs
// TODO: add label? In that case, I need to create a referenceable element with figure
#let paragraph(title, body, spacing: 1.35em) = block(spacing: spacing, [
  #strong(title) #h(0.35em) #body
])

// Callout boxes
// inspired from babble-bubbles package
//
// TODO: make them breakable across pages
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
        #title]
      \
      #text(fill: body-color)[#body]
    ],
  ))
}

#let info(
  body,
  title: "Info",
  icon: fa-icon("info-circle"),
) = {
  callout(
    body,
    title: title,
    fill: blue.lighten(15%),
    title-color: blue.darken(50%),
    icon: icon,
  )
}

#let faq(
  body,
  title: "FAQ",
  icon: fa-icon("question-circle"),
) = {
  callout(
    body,
    title: title,
    fill: orange.lighten(15%),
    title-color: orange.darken(50%),
    icon: icon,
  )
}

#let tip(
  body,
  title: "Tip",
  icon: fa-icon("lightbulb"),
) = {
  callout(
    body,
    title: title,
    fill: cyan.lighten(15%),
    title-color: cyan.darken(50%),
    icon: icon,
  )
}

#let success(
  body,
  title: "Success",
  icon: fa-icon("times-circle"),
) = {
  callout(
    body,
    title: title,
    fill: green.lighten(15%),
    title-color: green.darken(50%),
    icon: icon,
  )
}

#let danger(
  body,
  title: "Danger",
  icon: fa-icon("times-circle"),
) = {
  callout(
    body,
    title: title,
    fill: red.lighten(15%),
    title-color: red.darken(50%),
    icon: icon,
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
  set text(lang: lang)

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

  // customize numbering so that it is dependent on section
  // for instance, under section 1., each figure/table/equation will be numbered as (1.X)
  let items-heading-numbering = (..args, kind: "generic") => {
    let curr-sec-num = context counter(heading).get().first()
    // first argument is the current element counter
    let local-num = args.at(0)

    if kind == "equation" {
      [(#curr-sec-num.#local-num)]
    } else {
      [#curr-sec-num.#local-num]
    }
  }

  show figure.where(kind: image): set figure(numbering: items-heading-numbering, supplement: [Fig.])
  show figure.where(kind: table): set figure(numbering: items-heading-numbering, supplement: [Tab.])
  set math.equation(
    numbering: (..args) => items-heading-numbering(..args, kind: "equation"),
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

  set page(numbering: "i")
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
    counter(page).update(1)
    set page(
      numbering: "1",
      margin: (inside: 80pt, outside: 50pt),
      // binding: "left",
      header-ascent: 55% + 0pt,
      header: context {
        let curr-page = counter(page).get().first()
        // check if there is a one-level heading on the same page, if so dont's display the
        // header
        let next-h1 = query(selector(heading.where(level: 1)).after(here())).first()
        let next-h1-page = counter(page).at(next-h1.location()).first()

        if curr-page > 1 and next-h1-page != curr-page [
          #set text(fill: darkgray)
          #let header-title = query(selector(heading).before(here())).last().body

          #let body = block(inset: 0pt, spacing: 0pt, [
            #if calc.even(curr-page) {
              [#curr-page #h(1fr) #header-title]
            } else {
              [#header-title #h(1fr) #curr-page]
            }
            #box(line(length: 100%, stroke: 0.2pt))
          ])
          #let alignment = if calc.even(curr-page) { right } else { left }
          #align(alignment, body)
        ]
      },
    )

    {
      // Headings, Header & Footer
      // imitate heading style from Alice's Adventures in a Differentiable Wonderland by S.Scardapane
      set heading(numbering: "1.")
      show heading.where(level: 1): it => block([
        #text(28pt)[
          #counter(heading).display("1")
          #h(0.8em)
          #box(line(length: 0.8em, stroke: 1.65pt, angle: 90deg), baseline: 2.5pt)
          #h(0.8em)
          #it.body
        ]
        #v(0.75em)
        // reset sub-counters at each new section
        #context counter(figure.where(kind: image)).update(0)
        #context counter(figure.where(kind: table)).update(0)
        #context counter(math.equation).update(0)
      ])

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
