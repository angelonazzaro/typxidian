#import "template.typ": paragraph, template

#show: template.with(
  title: "Active Inference",
  subtitle: "The Free Energy Principle in Mind, Brain and Behaviour",
  authors: ("Thomas Parr", "Giovanni Pezzullo", "Karl J. Friston"),
  supervisors: ("Prof. Roberto Tagliaferri", "Prof. Francesco Bardozzo", "Dr. Andrea F. Terlizzi"),
  academic-year: "2024/2025",
)


= Introduction

#lorem(20)

#lorem(30)

#parbreak()
\
#lorem(25)

#paragraph("Test", [let's see *aaa* _sdsasssa_ #lorem(30)])
#figure(image("assets/figures/logo.svg", width: 50%), caption: [AAAAAAAAAA]) <ga>
@ga


#lorem(20)
== Let's see

#lorem(10)
- Let's see
  - aaaaaa
  - asss
  #list(
    [o cazz],
    [o mij],
    [aaaa],
    marker: "1.",
  )
- Test test test
- AAAA

#enum([o cazz], [o mij], [aaaa])

$
  x pi y dot z cos(x)y
$

- Let's see
- Test test test
- AAAA



#lorem(15)

#figure(
  table(columns: 2)[#lorem(50)][B][C][D],
  caption: [I'm up here],
)

#lorem(15)

= AAA

=== Oh yeah
@vaswani2023attentionneed

