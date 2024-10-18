# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "lang_mini"
require "minitest/autorun"
require "mocha/minitest"
require "dotenv/load"
require "webmock/minitest"

module Minitest
  class Test
    FIXTURES_PATH = "#{File.dirname(__FILE__)}/fixtures".freeze

    def fixture(fixture_path)
      File.expand_path "#{FIXTURES_PATH}/#{fixture_path}"
    end

    def read_fixture(fixture_path)
      File.read(fixture(fixture_path))
    end

    def write_fixture(fixture_path, content)
      puts "ATTENTION: fixture: '#{fixture_path}' been written"
      File.write(fixture(fixture_path), content)
    end
  end
end
