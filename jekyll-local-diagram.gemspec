require 'open-uri'
require 'net/http'
require 'fileutils'

# Retrieve the latest PlantUML jar file from Github
PLANTUML_LOCAL_INSTALL_PATH = File.join(File.dirname(__FILE__), "/ext/plantuml.jar")
FileUtils.mkdir_p(File.dirname(PLANTUML_LOCAL_INSTALL_PATH))

if !File.exists? PLANTUML_LOCAL_INSTALL_PATH 
  redirect = Net::HTTP.get_response(URI.parse("https://github.com/plantuml/plantuml/releases/latest"))["location"]
  puts "Downloading from release: #{redirect}"
  v_tag=redirect.split('/')[-1]
  v_number=v_tag[1..]
  v_uri=URI.parse("https://github.com/plantuml/plantuml/releases/download/#{v_tag}/plantuml-#{v_number}.jar")
  IO.copy_stream(URI.open(v_uri), PLANTUML_LOCAL_INSTALL_PATH)
else
  puts "PlantUML jar already in place: #{PLANTUML_LOCAL_INSTALL_PATH}"
end

Gem::Specification.new do |s|
  s.name          = "jekyll-local-diagram"
  s.homepage      = "https://github.com/hackinghat/jekyll-local-diagram"
  s.version       = "0.1.3"
  s.summary       = "Generate local diagrams with support for non-UML diagrams, to be used with jekyll-local-diagrams-build-action inculdes PPlantUML #{v_number}"

  s.authors       = ["Steve Knight"]
  s.email         = "steve@hackinghat.com"
  s.files         = Dir["lib/**/*.rb"]+Dir["ext/**/*.jar"]+Dir["cfg/*"]

  s.require_paths = ["lib"]
  s.license       = "MIT"
  s.add_dependency "jekyll", "~> 4.2.2"
  s.add_dependency "liquid", "~> 4.0"
end
