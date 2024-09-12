require "test_helper"

class MiniLang::AssistantTest < Minitest::Test
  def setup
    MiniLang.logger.level = Logger::WARN
  end

  def test_initialize_defaults
    client = "CLIENT"
    assistant =
      MiniLang::Assistant.new(
        client: MiniLang::Client.new(access_token: "test"),
        model: "MODEL"
      )

    assert_equal("MODEL", assistant.model)
    assert(assistant.conversation.is_a?(MiniLang::Conversation))
    assert_nil(assistant.system_directive)
    assert_nil(assistant.tools)
  end

  def test_completion
    OpenRouter::Client.any_instance.expects(:complete).returns(JSON.parse(read_fixture("mini_lang/completion_what_is_the_color_of_the_sky.json")))

    client = MiniLang::Client.new(access_token: ENV["OPEN_ROUTER_KEY"])
    assistant =
      MiniLang::Assistant.new(
        client: client,
        model: "meta-llama/llama-3.1-8b-instruct:free"
      )

    message = MiniLang::Message.from_hash({ role: "user", content: "What is the color of the sky?" })
    new_messages = assistant.completion(message:)

    assert_equal(2, new_messages.length)
    assert_equal("user", new_messages[0].data[:role])
    assert_equal("What is the color of the sky?", new_messages[0].data[:content])
    assert_equal("assistant", new_messages[1].data[:role])
    assert(new_messages[1].data[:content].start_with?("The color of the sky appears to change"))
    assert_equal("gen-QdntFdRM8OezxqjUSLj7dWnUQYhs", new_messages[1].completion.data[:id])
    assert_equal(307, new_messages[1].completion.data[:usage][:total_tokens])
  end
end
