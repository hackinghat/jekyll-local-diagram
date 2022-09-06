require 'digest'
require 'fileutils'
require 'logger'

module Jekyll::LocalDiagram
  class PlantumlBlock < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
      @html = (markup or '').strip
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG
    end

    def render(context)
      site = context.registers[:site]
      name = Digest::MD5.hexdigest(super)
      path = File.join('assets', 'images', 'uml')
      type = 'svg'
      mimetype = 'svg+xml'
      imgfile = "#{name}.#{type}"
      imgpath = File.join(site.source, path)
      if !File.exists?(File.join(imgpath, imgfile))
        uml = File.join(imgpath, "#{name}.uml")
        img = File.join(imgpath, imgfile)
        if File.exists?(img)
          @logger.debug("File #{imgfile} already exists (#{File.size(img)} bytes)")
        else
          FileUtils.mkdir_p(File.dirname(uml))
          File.open(uml, 'w') { |f|
            f.write(super)
          }
          cmd = "plantuml.sh -t#{type} -o #{imgpath} #{uml}"
          @logger.debug("Executing plantuml command: #{cmd}")
          system(cmd) or raise "PlantUML error: #{super}"
          site.static_files << Jekyll::StaticFile.new(
            site, site.source, path, imgfile
          )
          @logger.debug("File #{imgfile} created (#{File.size(img)} bytes)")
        end
      end
      "<p><object data='#{site.baseurl}/#{path}/#{imgfile}' type='image/#{mimetype}' #{@html} class='plantuml'></object></p>"
    end
  end
end

Liquid::Template.register_tag('plantuml', Jekyll::PlantumlBlock)
