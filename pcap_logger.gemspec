# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pcap_logger/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brad Smith"]
  gem.email         = ["bradleydsmith@gmail.com"]
  gem.description   = %q{Capture pcap packets and send to a socket server}
  gem.summary       = %q{Capture pcap packets and send to a socket server}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "pcap_logger"
  gem.require_paths = ["lib"]
  gem.version       = PcapLogger::VERSION
  
  gem.add_dependency 'ruby-pcap'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'wirble'

end
