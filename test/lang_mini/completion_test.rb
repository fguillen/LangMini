# frozen_string_literal: true

require "test_helper"

module LangMini
  class CompletionTest < Minitest::Test
    def test_new_should_symbolize_keys
      completion = LangMini::Completion.new({ "key" => "value" })

      assert_equal("value", completion.raw[:key])
    end

    def test_methods
      raw = JSON.parse(read_fixture("/lang_mini/completion_tool_call_sum_1.json"))
      completion = LangMini::Completion.new(raw)

      assert_equal("assistant", completion.message[:role])
      assert_equal("call_Z79bsWuK4twmLNx9smS7M1bI", completion.tool_calls[0][:id])
      assert(completion.tools?)
      assert_equal("openai/gpt-4o", completion.model)
    end

    def test_as_json
      completion = LangMini::Completion.new({ "key" => "value" })
      as_json = completion.as_json
      assert_equal({ key: "value" }, as_json)
    end
  end
end
