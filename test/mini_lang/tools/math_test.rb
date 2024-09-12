require "test_helper"

class AssistanSum < MiniLang::Assistant
  def tools
    [
      MiniLang::Tools::Math.new
    ]
  end
end

class MiniLang::Tools::MathTest < ActiveSupport::TestCase
  def setup
    MiniLang.logger.level = Logger::WARN
  end

  def test_sum_2_plus_3
    responses = sequence("responses")
    OpenRouter::Client.any_instance.expects(:complete).in_sequence(responses).returns(JSON.parse(read_fixture("mini_lang/completion_tool_call_sum_1.json")))
    OpenRouter::Client.any_instance.expects(:complete).in_sequence(responses).returns(JSON.parse(read_fixture("mini_lang/completion_tool_call_sum_2.json")))

    client = MiniLang::Client.new(access_token: APP_CONFIG["open_router_key"])
    assistant =
      AssistanSum.new(
        client: client,
        model: "openai/gpt-4o",
      )

    message = MiniLang::Message.from_hash({ role: "user", content: "Use the math tool to calculate how much is 2 plus 3?" })
    new_messages = assistant.completion(message:)

    assert_equal(4, new_messages.length)
    assert_equal("user", new_messages[0].data[:role])
    assert_equal("assistant", new_messages[1].data[:role])
    assert_equal("tool", new_messages[2].data[:role])
    assert_equal("assistant", new_messages[3].data[:role])

    assert_nil(new_messages[1].data[:content])
    assert_equal("function", new_messages[1].data[:tool_calls][0][:type])

    assert_equal("2 plus 3 equals 5.", new_messages[3].data[:content])
  end
end
