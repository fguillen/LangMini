# frozen_string_literal: true

require "test_helper"

class AssistanSum < LangMini::Assistant
  def tools
    [
      LangMini::Tools::Math.new
    ]
  end
end

module LangMini
  module Tools
    class MathTest < Minitest::Test
      def setup
        LangMini.logger.level = Logger::WARN
      end

      def test_sum_2_plus_3 # rubocop:disable Metrics/AbcSize
        responses = sequence("responses")

        OpenRouter::Client.any_instance.expects(:complete)
          .in_sequence(responses).returns(JSON.parse(read_fixture("lang_mini/completion_tool_call_sum_1.json")))

        OpenRouter::Client.any_instance.expects(:complete)
          .in_sequence(responses).returns(JSON.parse(read_fixture("lang_mini/completion_tool_call_sum_2.json")))

        client = LangMini::Client.new(access_token: ENV.fetch("OPEN_ROUTER_KEY", nil))
        assistant =
          AssistanSum.new(
            client:,
            model: "openai/gpt-4o"
          )

        message = LangMini::Message.from_raw({ role: "user",
                                               content: "Use the math tool to calculate how much is 2 plus 3?" })
        new_messages = assistant.completion(message:)

        assert_equal(4, new_messages.length)
        assert_equal("user", new_messages[0].role)
        assert_equal("assistant", new_messages[1].role)
        assert_equal("tool", new_messages[2].role)
        assert_equal("assistant", new_messages[3].role)

        assert_nil(new_messages[1].content)
        assert_equal("function", new_messages[1].tool_calls[0][:type])

        assert_equal("2 plus 3 equals 5.", new_messages[3].content)
      end
    end
  end
end
