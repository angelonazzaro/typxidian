#import "template.typ": template

#show: template.with(
  title: [Exploring Multi-Modal Deep Learning approaches for Remote Sensing Image-Captioning and Zero-Shot Classification],
  subtitle: [In the midst of the true],
  authors: ("Angelo Nazzaro",),
  supervisors: ("Prof. Roberto Tagliaferri", "Prof. Francesco Bardozzo", "Dr. Andrea Terlizzi"),
  abstract: [#lorem(20)],
  university: [University of Salerno],
  department: [Department of Computer Science],
  faculty: [Faculty of Science],
  degree: [Master's Degree in Computer Science],
  academic-year: [2024/2025],
  citation: ["_To the black lamb in the dark sea, may you be with your fucking father_"],
  is-thesis: true,
)

= Introduction
<int>
Scriviamo qualche stronzata abbastanza grande da essere divisa in due righe, qualsiasi cosa va bene,
per testare anche il modo in cui va a capo e spezza le parole, cosa che non mi sembra che faccia.
Non capisco se è un problema di settaggio o se è semplicemente come funziona, in latex non ricordo
manco se lo fa. Mi pare di no che va a capo stesso lui come fa Typst. Vabbe, secondo me ci sta
abbastanza questo spacing. Direi che va bene così, good job! $x + y$
@int
#context counter(page).get().first()
$
  x + 1
$

#lorem(35)@vaswani2023attentionneed
@vaswani2023attentionneed1
@scardapane2024alicesadventuresdifferentiablewonderland

#figure(image("assets/figures/logo.svg", width: 35%), caption: [Test Fig])

#lorem(25)
== Test testina
#lorem(25)

aaaaa
=== XXX
#lorem(30)
==== BBBB
aaaaaaaaaaaaaaaaaa
asdsadasd
#parbreak()
= Introduction 2
= Introduction 3

#lorem(25)

$
  x + 1
$
