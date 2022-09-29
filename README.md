# jekyll-local-diagram

# Quickstart

## Local Jekyll 

If you're running/building your site outside of a 

For a local Jekyll host you should add the following to your `Gemfile`

    group :jekyll_plugins do
      ...
      gem "jekyll-local-diagram"
    end

It should also appear in your `_config.yml` file thus:

    plugins:
    - jekyll-local-diagram

Then either run:
    
    gem install jekyll-local-diagram
    
 Or run 
 
    bundle update

## Github Pages / Docker

Take a look at [jekyll-local-diagram-build-action](https://github.com/hackinghat/jekyll-local-diagram-build-action) for ways that you can run `jekyll-local-diagram` in a container or as part of a GitHub CI/CD build action to publish to GitHub pages.

# Documentation

# What

This is a [Jekyll](https://jekyllrb.com) Plugin that will generate SVGs as static assets that can be embedded into a Jekyll site.

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

![](https://www.plantuml.com/plantuml/png/SoWkIImgAStDuNB9JovMqBLJ2CX9p2i9zVLHi58eACeiIon9LKZ9J4mlIinLI4aiIUI2oOFKWlLOmUIBkHnIyrA0PW40)

This image is rendered just in time by hitting a service URL at www.plantuml.com where part of the URL includes a specially encoded string.

    https://www.plantuml.com/plantuml/png/SoWkIImgAStDuNB9JovMqBLJ2CX9p2i9zVLHi58eACeiIon9LKZ9J4mlIinLI4aiIUI2oOFKWlLOmUIBkHnIyrA0PW40

That encoding includes some compression and something like [base64 encoding](https://plantuml.com/text-encoding) in order to arrive at as minimal URL as possible.  The approach for Mermaid diagrams is similar.

The downsides of managing diagrams in this way are two-fold: 

1. The complexity of the diagram is limited by the length of the URL (circa 2,000 characters) 
2. The content of the diagram is leaked to a third-party by encoding the diagram text in the URL - this is over https but leaks the diagram to the server.

The first issue is the biggest deal-breaker, and indeed diagrams with lots of labels and notes are hard to create.  

The second issue is potentially less of a concern but if we're making our repo private we may not want to leak sensitive design details to multiple third parties.  Also knowing that this service could leak technical specs could make it a target for hackers.

## GitHub Pages Support

GitHub pages does not allow the inclusion of arbitrary Jekyll plugins which makes [Jekyll PlantUML](https://github.com/yegor256/jekyll-plantuml) not usable on GitHub pages without additional components.  



# How

The plugin uses the [Liquid](https://shopify.github.io/liquid/) templating tooling that is already installed as part of Jekyll. 

The plugin assumes that you have the following applications installed and in the current path that is running Jekyll.

* A Java JRE (such as [Amazon Coretto](https://aws.amazon.com/corretto/?filtered-posts.sort-by=item.additionalFields.createdDate&filtered-posts.sort-order=desc))
* Mermaid command line [mermaid.cli](https://www.npmjs.com/package/mermaid.cli)
* MathJax command line [tex2svg](https://www.npmjs.com/package/tex2svg)



