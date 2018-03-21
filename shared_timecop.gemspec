
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shared_timecop/version"

Gem::Specification.new do |spec|
  spec.name          = "shared_timecop"
  spec.version       = SharedTimecop::VERSION
  spec.authors       = ["Masato Ikeda"]
  spec.email         = ["masato.ikeda@gmail.com"]

  spec.summary       = %q{Timecop wrapper to share timetravel in multi processes.}
  spec.description   = %q{Timecop wrapper to share timetravel in multi processes.}
  spec.homepage      = "https://github.com/a2ikm/shared_timecop"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "timecop"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
