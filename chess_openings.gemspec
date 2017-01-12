# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "chess_openings"
  spec.version       = "0.0.3"
  spec.authors       = ["Simão Neves"]
  spec.email         = ["simaocostaneves@gmail.com"]

  if spec.respond_to?(:metadata)
  end

  spec.summary       = "Gem that allows you to calculate which opening was used in a chess game"
  spec.description   = "Gem that allows you to know what chess opening was used in a chess game, find chess openings by name or get all openings that start with certain moves"
  spec.homepage      = "http://www.github.com/simaoneves/chess_openings"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "pgn", '0.1.1'
  spec.add_dependency 'nokogiri', '1.6.6.2'
  spec.add_development_dependency "bundler", '~> 1.8'
  spec.add_development_dependency "rspec", '~> 3.3.0'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "pry"
end
