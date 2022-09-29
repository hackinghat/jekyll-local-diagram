# jekyll-local-diagram

# What

This is a [Jekyll](https://jekyllrb.com) Plugin that will generate SVGs as static assets for a Jekyll site.

# Why?

If you have a private repository on GitHub and are using [GitHub Pages](https://pages.github.com) to host your documentation but also want to make use of text based diagramming tools to inline diagrams (within your markdown) then you will likely be drawn to using something like [Jekyll Spaceship](https://github.com/jeffreytse/jekyll-spaceship) or[Jekyll PlantUML](https://github.com/yegor256/jekyll-plantuml).

## Diagrammatic support

However not all diagramming tools are created equal, some have broad support for different diagrams (i.e. [Jekyll Spaceship](https://github.com/jeffreytse/jekyll-spaceship)) and some support just one (i.e. [Jekyll PlantUML](https://github.com/yegor256/jekyll-plantuml)).  For my use case I needed:

* [PlantUML](https://plantuml.com)
* [GraphViz](https://graphviz.org/documentation/)
* [Mermaid](https://mermaid-js.github.io/mermaid/#/)
* [LaTeX maths expressions](https://en.wikibooks.org/wiki/LaTeX/Mathematics).

## Local assets

Not withstanding this not all diagramming tools produce image assets that are local to the repo.  [Jekyll Spaceship](https://github.com/jeffreytse/jekyll-spaceship) leverages this method pretty much exclusively for [PlantUML](https://plantuml.com) and [Mermaid](https://mermaid-js.github.io/mermaid/#/) diagrams.

To illustrate this consider the following diagram:

![](//www.plantuml.com/plantuml/png/SoWkIImgAStDuNB9JovMqBLJ2CX9p2i9zVLHi58eACeiIon9LKZ9J4mlIinLI4aiIUI2oOFKWlLOmUIBkHnIyrA0PW40)

The downsides of this are two-fold: 

1. The complexity of the diagram is limited by the length of the URL (circa 2,000 characters) - this limits the complexity of the diagrams that can be supported.
2. The content of the diagram is leaked to a third-party by mime encoding the diagram text in the URL - this leaks the diagram to the server.

The first issue is the biggest deal-breaker, and indeed diagrams with lots of labels and notes are hard to create.  The second issue is potentially less of a concern but if we're making our repo private we may not want to leak sensitive design details to multiple third parties.

## GitHub Pages Support

GitHub pages does not allow the inclusion of arbitrary Jekyll plugins which makes [Jekyll PlantUML](https://github.com/yegor256/jekyll-plantuml) not usable on GitHub pages without additional components.  

# How

The plugin uses the [Liquid](https://shopify.github.io/liquid/) templating tooling that is already installed as part of Jekyll. 

The plugin assumes that you have the following applications installed and in the current path that is running Jekyll.

* A Java JRE (such as [Amazon Coretto](https://aws.amazon.com/corretto/?filtered-posts.sort-by=item.additionalFields.createdDate&filtered-posts.sort-order=desc))
* Mermaid command line [mermaid.cli](https://www.npmjs.com/package/mermaid.cli)
* MathJax command line [tex2svg](https://www.npmjs.com/package/tex2svg)



