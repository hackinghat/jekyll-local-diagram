# From https://gist.github.com/phaer/1020852

module JekyllLocalDiagram
  class RawBlock < JekyllLocalDiagramBlock
    def parse(tokens)
      @nodelist ||= []
      @nodelist.clear
      
      while token = tokens.shift
        if token =~ FullToken
          if block_delimiter == $1
            end_tag
            return
          end
        end
        @nodelist << token if not token.empty?
      end
    end
  end
end

Liquid::Template.register_tag('raw', JekyllLocalDiagram::RawBlock)
