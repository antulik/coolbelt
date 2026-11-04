# frozen_string_literal: true

require_relative "lib/coolbelt/version"

Gem::Specification.new do |spec|
  spec.name = "coolbelt"
  spec.version = Coolbelt::VERSION
  spec.authors = ["Anton Katunin"]
  spec.email = ["antulik@gmail.com"]

  spec.summary = "A personal collection of useful extensions for Ruby and Rails"
  spec.description = "A personal collection of useful extensions for Ruby and Rails"
  spec.homepage = "https://github.com/antulik/coolbelt"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"
  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/antulik/coolbelt"
  spec.metadata["changelog_uri"] = "https://github.com/antulik/coolbelt/blob/main/CHANGELOG.md"

  # Uncomment the line below to require MFA for gem pushes.
  # This helps protect your gem from supply chain attacks by ensuring
  # no one can publish a new version without multi-factor authentication.
  # See: https://guides.rubygems.org/mfa-requirement-opt-in/
  # spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rails"
  spec.add_dependency "zeitwerk"

  # For more information and examples about making a new gem, check out our
  # guide at: https://guides.rubygems.org/make-your-own-gem/
end
