# frozen_string_literal: true

require 'bundler/setup'
require 'coveralls'
require 'json'
require 'simplecov'
require 'webmock/rspec'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
)

SimpleCov.start do
  refuse_coverage_drop

  add_filter('/spec/')

  minimum_coverage(95)
  coverage_dir('out/coverage')
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

##
# Read in a file from spec/texts/
#
# @param name [String] file name
# @param extension [String] file extensio
#
# @return [String] file's contents
def read_text(name, extension = '.json')
  File.read(
    [
      __FILE__.gsub(%r{(?<=/spec/).*}, ''),
      'texts/',
      name,
      extension
    ].join
  )
end

##
# Parses a JSON string from a file
def json_from_text(name)
  JSON.parse(read_text(name))
end
