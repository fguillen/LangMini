require "test_helper"

class LangMini::ConversationTest < Minitest::Test
  def test_should_create_new_messages_based_on_the_conversation
    conversation = LangMini::Conversation.new
    ai_message = LangMini::Message.from_message({ role: "user", content: "Hello Model!" })
    conversation.add_message(ai_message)

    puts ">>>> conversation.messages: #{conversation.messages}"
    puts ">>>> conversation.messages_data: #{conversation.messages_data}"
  end

  def test_should_reset_new_messages
    message = FactoryBot.create(:message)
    ai_message = LangMini::Message.from_message(message)

    conversation = LangMini::Conversation.new
    conversation.add_message(ai_message)

    puts ">>>> conversation.messages_data: #{conversation.messages_data}"
  end
end
