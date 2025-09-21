#import "src/preview/typxidian.typ": *

#show: template.with(
  title: [TypXidian],
  authors: ("Angelo Nazzaro", ),
  supervisors: ("Angelo Nazzaro", ),
  subtitle: [A template for academic documents written in Typst],
  university: [University of Salerno],
  faculty: [Faculty of Science],
  degree: [Master's Degree in Machine Learning & Data Science],
  department: [Departmenent of Computer Science],
  academic-year: [2025/2026],
  abstract: lorem(20), quote: lorem(10))
= Results & Discussion
#lorem(25)~@vaswani2023attentionneed.

#lorem(20)
- First item
  -  aaa
  - bbb
  - ccc
- Second Item
- Third Item
- Fourth Item
@scardapane2024alicesadventuresdifferentiablewonderland

$ x + y = integral_0^inf x y d x $ <eq-1>
@eq-1

#lorem(10)
- First item
- Second Item
- Third Item
- Fourth Item
#acr("WTP")
== Section
#lorem(25)

== Subsection
#lorem(25)

#lorem(75)
#linebreak()
#linebreak()
#lorem(125)
#lorem(1000)
= 2nd Introduction
#lorem(50)

#info([
  #lorem(25)

  $ x + y = integral_0^inf x y d x $
  
  #lorem(10)
])

#figure(
  image("src/preview/figures/cat.jpg", width: 250pt),
  caption: [This is a cat.]
)

#definition([
  #lorem(20)

  $ x + y = 1 $
])

#theorem([
  #lorem(20)

  $ x + y = 1 $
])
<th-1>

#proof([
  #lorem(20)

  $ x + y = 1 $
], [@th-1])

#subfigure(
  columns: (1fr, 1fr),
  figure(
  image("src/preview/figures/cat.jpg"),
  caption: [This is a cat.]
),
<a>,
figure(
  image("src/preview/figures/cat.jpg"),
  caption: [This is a cat.]
),
caption: [This is a subfigure of cats.]
)
@a
