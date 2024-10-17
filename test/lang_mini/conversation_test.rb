# frozen_string_literal: true

require "test_helper"

module LangMini
  class ConversationTest < Minitest::Test
    def test_initialize_defaults
      conversation = LangMini::Conversation.new
      assert_equal([], conversation.messages)
      assert_equal([], conversation.new_messages)
    end

    def test_add_message
      conversation = LangMini::Conversation.new
      conversation.add_message("MESSAGE")

      assert_equal(["MESSAGE"], conversation.messages)
      assert_equal(["MESSAGE"], conversation.new_messages)
    end

    def test_messages_raw
      conversation = LangMini::Conversation.new
      message_1 = LangMini::Message.from_raw("RAW_MESSAGE_1")
      message_2 = LangMini::Message.from_raw("RAW_MESSAGE_2")
      conversation.add_message(message_1)
      conversation.add_message(message_2)

      assert_equal(%w[RAW_MESSAGE_1 RAW_MESSAGE_2], conversation.messages_raw)
    end

    def test_reset_new_messages
      conversation = LangMini::Conversation.new
      conversation.add_message("MESSAGE")
      assert_equal(1, conversation.messages.count)
      assert_equal(1, conversation.new_messages.count)

      conversation.reset_new_messages
      assert_equal(1, conversation.messages.count)
      assert_equal(0, conversation.new_messages.count)
    end
  end
end
