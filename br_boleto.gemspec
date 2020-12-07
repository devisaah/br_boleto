# -*- encoding: utf-8 -*-
require File.expand_path('../lib/br_boleto/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "br_boleto"
  gem.version       = BrBoleto::Version::CURRENT
  gem.licenses      = 'MIT'
  gem.summary       = %q{Emissão de Boletos Bancários em Ruby}
  gem.description   = %q{Emissão de Boletos Bancários em Ruby}
  gem.authors       = ["Bruno M. Mergen"]
  gem.email         = ["brunomergen@gmail.com"]
  
  gem.homepage      = "https://github.com/Brunomm/br_boleto"

  gem.files         = `git ls-files`.split("\n").reject{|fil| 
    fil.include?('documentacoes_boletos/') || fil.include?('gemfiles/')
  }
  gem.test_files    = `git ls-files -- test`.split("\n")
  # gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.requirements = ['GhostScript > 9.0, para gear PDF e código de Barras']

  gem.required_ruby_version = '>= 2.2.0'


  gem.add_dependency "rake", '>= 0.8.7'
  gem.add_dependency "activesupport", '>= 5.0.0'
  gem.add_dependency "activemodel",   '>= 5.0.0'
  gem.add_dependency 'unidecoder', '~> 1.1'
  gem.add_dependency 'rghost', '~> 0.9'
  gem.add_dependency 'rghost_barcode', '~> 0.9'
  gem.add_dependency 'parseline', '~> 1.0.3'
end
