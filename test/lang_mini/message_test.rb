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
      message = LangMini::Message.from_completion("COMPLETION")
      assert_nil(message.raw)
      assert_equal("COMPLETION", message.completion.raw)
    end
  end
end
