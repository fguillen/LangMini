# frozen_string_literal: true

module LangMini
  # Represents a conversation between the user and the model.
  # The conversation is an array of `LangMini::Message`s.
  class Conversation
    # @return [Array<LangMini::Message>]
    attr_accessor :messages

    # During a call to Assistant.completion,
    # the new messages generated to complete the Completion (the Model's answer) are stored here.
    #
    # @return [Array<LangMini::Message>]
    attr_reader :new_messages

    # Creates a new instance of Conversation
    # @return [Conversation]
    def initialize
      @messages = []
      @new_messages = []
    end

    # Used by Assistant.completion to add a new message to the conversation
    # @param message [LangMini::Message]
    #
    def add_message(message)
      @messages << message
      @new_messages << message
    end

    # @return [Array<Hash>] The raw data, returned by the API, from the messages.
    # TODO: investigate why I see message.raw attribute here
    def messages_raw
      @messages.map(&:raw)
    end

    # Resets the `new_messages` array
    def reset_new_messages
      @new_messages = []
    end
  end
end
