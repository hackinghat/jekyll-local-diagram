module JekyllLocalDiagram
  class MermaidBlock < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
      @html = (markup or '').strip
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG
    end

    def render(context)
      site = context.registers[:site]
      name = Digest::MD5.hexdigest(super)
      path = File.join('assets', 'images', 'mmd')
      type = 'svg'
      mimetype = 'svg+xml'
      imgfile = "#{name}.#{type}"
      imgpath = File.join(site.source, path)
      if !File.exists?(File.join(imgpath, imgfile))
        mmd = File.join(imgpath, "#{name}.mmd")
        img = File.join(imgpath, imgfile)
        if File.exists?(img)
          @logger.debug("File #{imgfile} already exists (#{File.size(img)} bytes)")
        else
          FileUtils.mkdir_p(imgpath)
          File.open(mmd, 'w') { |f|
            f.write(super)
          }
          cmd = "mmdc.sh #{mmd} #{img}"
          @logger.debug("Executing mermaid command: #{cmd}")
          system(cmd) or raise "mermaid-cli error: #{super}"
          site.static_files << Jekyll::StaticFile.new(
            site, site.source, path, imgfile
          )
          @logger.debug("File #{imgfile} created (#{File.size(img)} bytes)")
        end
      end
      "<p><object data='#{site.baseurl}/#{path}/#{imgfile}' type='image/#{mimetype}' #{@html} class='mermaid'></object></p>"
    end
  end
end

Liquid::Template.register_tag('mermaid', JekyllLocalDiagram::MermaidBlock)
