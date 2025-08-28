#let coverpage(
  title: none,
  subtitle: none,
  authors: (),
  supervisors: (),
  logo: none,
  academic-year: none,
) = {
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
    logo = "../assets/figures/logo.svg"
  }

  image(logo, width: 50%)

  set text(18pt)

  v(0.35em)

  if authors.len() > 0 and supervisors.len() == 0 {
    let ncols = calc.max(calc.div-euclid(authors.len(), 3), 1)

    grid(
      columns: (1fr,) * ncols,
      row-gutter: 15pt,
      ..authors.map(author => [#upper(author)])
    )
  } else {
    set text(15pt)

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
