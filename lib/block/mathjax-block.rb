module JekyllLocalDiagram
  class MathJaxBlock < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
      @html = (markup or '').strip
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG
    end

    def render(context)
      site = context.registers[:site]
      name = Digest::MD5.hexdigest(super)
      path = File.join('assets', 'images', 'tex')
      type = 'svg'
      mimetype = 'svg+xml'
      imgfile = "#{name}.#{type}"
      imgpath = File.join(site.source, path)
      if !File.exists?(File.join(imgpath, imgfile))
        img = File.join(imgpath, imgfile)
        if File.exists?(img)
          @logger.debug("File #{imgfile} already exists (#{File.size(img)} bytes)")
        else
          FileUtils.mkdir_p(imgpath)
          cmd = "tex2svg \"#{super}\"> #{img}"
          @logger.debug("Executing mathjax command: #{cmd}")
          system(cmd) or raise "MathJax error: #{super}"
          site.static_files << Jekyll::StaticFile.new(
            site, site.source, path, imgfile
          )
          @logger.debug("File #{imgfile} created (#{File.size(img)} bytes)")
        end
      end
      "<p><object data='#{site.baseurl}/#{path}/#{imgfile}' type='image/#{mimetype}' #{@html} class='mathjax'></object></p>"
    end
  end
end

Liquid::Template.register_tag('mathjax', JekyllLocalDiagram::MathJaxBlock)
