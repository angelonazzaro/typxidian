#show outline.entry: set outline.entry(
  fill: grid(
    columns: 2,
    gutter: 0pt,
    repeat[~.], h(11pt),
  ),
)


// from haw-hamburg 0.6.1 template
#show outline.entry.where(level: 1): set outline.entry(fill: none)
#show outline.entry.where(level: 1): set text(weight: "bold")
#show outline.entry.where(level: 1): set block(above: 14pt)

#pagebreak()

#outline(depth: 3, indent: auto)

#pagebreak()

#show outline.entry: set outline.entry(
  fill: grid(
    columns: 2,
    gutter: 0pt,
    repeat[~.], h(11pt),
  ),
)


#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
  indent: auto,
)

#pagebreak()

#show outline.entry: set outline.entry(
  fill: grid(
    columns: 2,
    gutter: 0pt,
    repeat[~.], h(11pt),
  ),
)


#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
  indent: auto,
)

#pagebreak()
