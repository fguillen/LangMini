# frozen_string_literal: true

require "test_helper"

module LangMini
  class AssistantTest < Minitest::Test
    def setup
      LangMini.logger.level = Logger::WARN
    end

    def test_initialize_defaults
      assistant =
        LangMini::Assistant.new(
          client: LangMini::Client.new(access_token: "test"),
          model: "MODEL"
        )

      assert_equal("MODEL", assistant.model)
      assert(assistant.conversation.is_a?(LangMini::Conversation))
      assert_nil(assistant.system_directive)
      assert_nil(assistant.tools)
    end

    def test_completion # rubocop:disable Metrics/AbcSize
      OpenRouter::Client.any_instance.expects(:complete)
        .returns(JSON.parse(read_fixture("lang_mini/completion_what_is_the_color_of_the_sky.json")))

      client = LangMini::Client.new(access_token: ENV.fetch("OPEN_ROUTER_KEY", nil))
      assistant =
        LangMini::Assistant.new(
          client:,
          model: "meta-llama/llama-3.1-8b-instruct:free"
        )

      message = LangMini::Message.from_raw({ role: "user", content: "What is the color of the sky?" })
      new_messages = assistant.completion(message:)

      assert_equal(2, new_messages.length)
      assert_equal("user", new_messages[0].role)
      assert_equal("What is the color of the sky?", new_messages[0].content)
      assert_equal("assistant", new_messages[1].role)
      assert(new_messages[1].content.start_with?("The color of the sky appears to change"))
      assert_equal("gen-QdntFdRM8OezxqjUSLj7dWnUQYhs", new_messages[1].completion.raw[:id])
      assert_equal(307, new_messages[1].completion.raw[:usage][:total_tokens])
    end
  end
end
