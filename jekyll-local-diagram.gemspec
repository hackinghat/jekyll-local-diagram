Gem::Specification.new do |s|
  s.name          = "jekyll-local-diagram"
  s.homepage      = "https://github.com/hackinghat/jekyll-local-diagram"
  s.version       = "0.0.1"
  s.summary       = "Generate local diagrams with support for non-UML diagrams, to be used with jekyll-local-diagrams-build-action"
  s.authors       = ["Steve Knight"]
  s.email         = "steve@hackinghat.com"
  s.files         = Dir["**/*.rb"]
  s.require_paths = ["lib"]
  s.license       = "MIT"
  s.add_dependency "liquid", "~> 4.0"
end
