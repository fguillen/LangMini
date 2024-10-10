# frozen_string_literal: true

require_relative "lib/lang_mini/version"

Gem::Specification.new do |spec|
  spec.name = "lang_mini"
  spec.version = LangMini::VERSION
  spec.authors = ["Fernando Guillen"]
  spec.email = ["fguillen.mail@gmail.com"]

  spec.summary = "Because not all LLM wrappers should be complicated"
  spec.description = "Simple toolbox to interact with LLMs in a simple and easy way"
  spec.homepage = "https://github.com/fguillen/LangMini"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/fguillen/LangMini"
  spec.metadata["changelog_uri"] = "https://github.com/fguillen/LangMini/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "logger", "~> 1.6.1"
  spec.add_dependency "open_router", "~> 0.3.3"
  spec.add_dependency "sequel", "~> 5.84.0"

  spec.add_development_dependency "yard"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "mocha", "~> 2.4.5"
end
