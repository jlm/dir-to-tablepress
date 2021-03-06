
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dirtp/version"

Gem::Specification.new do |spec|
  spec.name          = "dirtp"
  spec.version       = Dirtp::VERSION
  spec.authors       = ["John Messenger"]
  spec.email         = ["j.l.messenger@ieee.org"]

  spec.summary       = %q{Parse an Apache-generated auto-index directory listing and make a TablePress table from it.}
  #spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/jlm/dir-to-tablepress"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency 'nokogiri', '~> 1.8'
  spec.add_runtime_dependency 'rest-client', '~> 2.0'
  spec.add_runtime_dependency 'slop', '~> 4.6'
  spec.add_runtime_dependency 'logger', '~> 1.2'
end
