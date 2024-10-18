# frozen_string_literal: true

module LangMini
  module Utils
    def self.symbolize_keys(hash)
      JSON.parse(JSON.generate(hash), symbolize_names: true)
    end
  end
end
