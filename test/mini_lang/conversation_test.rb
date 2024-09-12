require "test_helper"

class MiniLang::ConversationTest < Minitest::Test
  def test_should_create_new_messages_based_on_the_conversation
    conversation = MiniLang::Conversation.new
    ai_message = MiniLang::Message.from_message({ role: "user", content: "Hello Model!" })
    conversation.add_message(ai_message)

    puts ">>>> conversation.messages: #{conversation.messages}"
    puts ">>>> conversation.messages_data: #{conversation.messages_data}"
  end

  def test_should_reset_new_messages
    message = FactoryBot.create(:message)
    ai_message = MiniLang::Message.from_message(message)

    conversation = MiniLang::Conversation.new
    conversation.add_message(ai_message)

    puts ">>>> conversation.messages_data: #{conversation.messages_data}"
  end
end
