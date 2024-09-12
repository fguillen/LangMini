# frozen_string_literal: true

require_relative "lib/mini_lang/version"

Gem::Specification.new do |spec|
  spec.name = "mini_lang"
  spec.version = MiniLang::VERSION
  spec.authors = ["Fernando Guillen"]
  spec.email = ["fguillen.mail@gmail.com"]

  spec.summary = "Because not all LLM wrappers should be complicated"
  spec.description = "Simple toolbox to interact with LLMs in a simple and easy way"
  spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

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

  spec.add_dependency "open_router", "~> 0.3.3"
end
