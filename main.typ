#import "template.typ": (
  danger, definition, faq, gls, glspl, info, paragraph, success, template, theorem, tip,
)

#show: template.with(
  title: "Active Inference",
  subtitle: "The Free Energy Principle in Mind, Brain and Behaviour",
  authors: ("Thomas Parr", "Giovanni Pezzullo", "Karl J. Friston"),
  supervisors: ("Prof. Roberto Tagliaferri", "Prof. Francesco Bardozzo", "Dr. Andrea F. Terlizzi"),
  academic-year: "2024/2025",
  abstract: [#lorem(80)],
)


= Introduction
#lorem(20)
@unisa

#info(
  [#lorem(20)
    #figure(image("assets/figures/logo.svg", width: 50%), caption: [AAAAAAAAAA]) <ga3>
  ],
  title: "AAAA",
)
#faq([#lorem(20)], title: "AAAA")
#tip([#lorem(20)], title: "AAAA")
#success([#lorem(20)], title: "AAAA")
#danger([#lorem(20)], title: "AAAA")
<c>
@c
#definition(
  [#lorem(20)],
  title: "KTM",
)
<a>
@a
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
== BBBBB
#theorem(
  [#lorem(20)],
  title: "KTM",
)
<b1>
@b1
#parbreak()
\
#lorem(25)

#paragraph("Test", [let's see *aaa* _sdsasssa_ #lorem(30)])
#figure(image("assets/figures/logo.svg", width: 50%), caption: [AAAAAAAAAA]) <ga>


#lorem(20)
== Let's see
#context counter(page).get()
#context counter(heading).get()
#context counter(math.equation).get()
#context counter(figure).get()

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
#context counter(page).get()
#context counter(heading).get().len()

#enum([o cazz], [o mij], [aaaa])

$
  x pi y dot z cos(x)y
$
<eq>
@eq
$
  x pi y dot z cos(x)y
$
#context counter(math.equation).get()
#context counter(figure).get()


- Let's see
- Test test test
- AAAA



#lorem(15)

#figure(
  table(columns: 2)[#lorem(50)][B][C][D],
  caption: [I'm up here],
)
<b>
@b

#let x = context query(selector(heading.where(level: 1)).before(here())).last()
#context counter(heading).get()


#lorem(15)
#pagebreak()
= AAA
// #context query(selector(heading).before(here())).last().level
// #context counter(math.equation).get()
// #context counter(math.equation).update(0)
// #context counter(figure.where(kind: table)).update(0)
aaaa
#figure(
  table(columns: 2)[#lorem(50)][B][C][D],
  caption: [I'm up here],
)


== aaaaa
#context counter(heading).get().first()
$
  x pi y dot z cos(x)
$
=== Oh yeah
@vaswani2023attentionneed

#context counter(heading).get()

#lorem(250)
