#let coverpage(
  title: none,
  subtitle: none,
  department: none,
  faculty: none,
  university: none,
  academic-year: none,
  degree: none,
  logo: none,
  authors: (),
  supervisors: (),
  is-thesis: false,
) = {
  set page(numbering: none)
  set align(center)

  text(30pt, weight: "bold")[#title]

  if subtitle != none {
    linebreak()
    v(0.75em)
    text(21pt)[#subtitle]
  }

  if logo == none {
    logo = image("../assets/figures/logo.svg", width: 32.5%)
  }

  block(above: 3em, below: 3em, logo)

  set text(16pt)

  if supervisors.len() == 0 and authors.len() > 0 {
    let ncols = calc.max(calc.div-euclid(authors.len(), 3), 1)

    grid(
      columns: (1fr,) * ncols,
      row-gutter: 15pt,
      ..authors.map(author => [#upper(author)])
    )
  } else {
    let authors-title = if is-thesis {
      if authors.len() > 1 { text("CANDIDATES") } else { text("CANDIDATE") }
    } else {
      if authors.len() > 1 { text("AUTHORS") } else { text("AUTHOR") }
    }

    let sups-title = if supervisors.len() > 1 { text("SUPERVISORS") } else {
      text("SUPERVISOR")
    }
    grid(
      columns: (1fr, 1fr),
      grid(
        columns: 1fr,
        row-gutter: 15pt,
        align(left, [
          #strong(sups-title)
          #linebreak()

          #stack(
            dir: ttb,
            spacing: 12pt,
            ..supervisors.map(s => [#s]),
          )
        ]),
      ),
      grid(
        columns: 1fr,
        align(right, [
          #strong(authors-title)
          #linebreak()

          #stack(
            dir: ttb,
            spacing: 12pt,
            ..authors.map(a => [#a]),
          )
        ]),
      ),
    )
  }
  set text(14pt)
  v(3em)
  strong(faculty)
  linebreak()
  strong(department)
  linebreak()
  strong(degree)
  v(3em)
  [Academic year #academic-year]
}
