module JekyllLocalDiagram
  class PlantumlBlock < JekyllLocalDiagram::JekyllLocalDiagramBlock
    def initialize(tag_name, markup, tokens)
      super
      @ext = 'uml'
      @blockclass = 'plantuml'
    end

    def build_cmd(input, output)
      "plantuml.sh -tsvg -o #{File.dirname(output)} #{input}"
    end
  end
end

Liquid::Template.register_tag('plantuml', JekyllLocalDiagram::PlantumlBlock)
