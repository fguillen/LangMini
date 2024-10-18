# frozen_string_literal: true

require "test_helper"

module LangMini
  class MessageTest < Minitest::Test
    def test_new_should_be_private
      assert_raises(NoMethodError) do
        LangMini::Message.new(raw: "RAW", completion: "COMPLETION")
      end
    end

    def test_from_raw
      message = LangMini::Message.from_raw("RAW")
      assert_equal("RAW", message.raw)
      assert_nil(message.completion)
    end

    def test_from_completion
      completion_mock = Minitest::Mock.new
      completion_mock.expect :message, { "key" => "value" }
      message = LangMini::Message.from_completion(completion_mock)
      assert_equal({ key: "value" }, message.raw)
      assert_equal(completion_mock.object_id, message.completion.object_id)
    end

    def test_role
      message = LangMini::Message.from_raw({ role: "ROLE" })
      assert_equal("ROLE", message.role)
    end

    def test_content
      message = LangMini::Message.from_raw({ content: "CONTENT" })
      assert_equal("CONTENT", message.content)
    end

    def test_tool_calls
      message = LangMini::Message.from_raw({ tool_calls: "TOOL_CALLS" })
      assert_equal("TOOL_CALLS", message.tool_calls)
    end

    def test_model
      completion_mock = Minitest::Mock.new
      completion_mock.expect :message, nil
      completion_mock.expect :model, "MODEL"
      message = LangMini::Message.from_completion(completion_mock)
      assert_equal("MODEL", message.model)
    end

    def test_model_when_no_completion
      message = LangMini::Message.from_raw({})
      assert_nil(message.model)
    end

    def test_as_json
      completion_mock = Minitest::Mock.new
      completion_mock.expect :message, { "key" => "value" }
      completion_mock.expect :as_json, "COMPLETION_HASH"
      message = LangMini::Message.from_completion(completion_mock)
      as_json = message.as_json
      assert_equal({ key: "value" }, as_json[:raw])
      assert_equal("COMPLETION_HASH", as_json[:completion])
    end

    def test_as_json_when_completion_is_nil
      message = LangMini::Message.from_raw("RAW")
      assert_equal("RAW", message.as_json[:raw])
      assert_nil(message.as_json[:completion])
    end
  end
end
