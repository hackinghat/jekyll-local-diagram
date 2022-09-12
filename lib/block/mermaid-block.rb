module JekyllLocalDiagram
  class MermaidBlock < JekyllLocalDiagram::JekyllLocalDiagramBlock
    def initialize(tag_name, markup, tokens)
      super
      @ext = 'mmd'
      @blockclass = 'mermaid'
    end

    def build_cmd(input, output)
      "mmdc.sh #{input} #{output}"
    end
  end
end

Liquid::Template.register_tag('mermaid', JekyllLocalDiagram::MermaidBlock)
