# frozen_string_literal: true

module LangMini
  # Represents un wrapper over an API raw message or completion
  class Message
    # @return [Hash] The raw mensage from (or to) the API
    attr_reader :raw

    # @return [LangMini::Completion] If the message is an answer from the model the data is stored here.
    attr_reader :completion

    # Creates a new instance of Message
    #
    # @param raw [Hash] The raw mensage from (or to) the API
    # @param completion [LangMini::Completion] If the message is an answer from the model. Defaults to `nil`.
    # @return [LangMini::Message]
    def initialize(raw:, completion: nil)
      @raw = raw
      @completion = completion
    end
    private_class_method :new

    # Creates a new instance of Message from a API style raw Hash
    #
    # @param hash [Hash] The raw mensage from (or to) the API
    # @return [LangMini::Message]
    def self.from_raw(hash)
      new(raw: hash)
    end

    # Creates a new instance of Message from a API style raw completion Hash
    #
    # @param hash [Hash] The raw completion from the API
    # @return [LangMini::Message]
    def self.from_completion(completion_p)
      raw = LangMini::Utils.symbolize_keys(completion_p.message)
      new(raw:, completion: completion_p)
    end

    # @return [String] The role of the message
    def role
      raw[:role]
    end

    # @return [String] The content of the message
    def content
      raw[:content]
    end

    # @return [Array<Hash>] The tool calls in the message
    def tool_calls
      raw[:tool_calls]
    end

    # @return [String] The model of the completion
    def model
      completion&.model
    end

    # @return [Hash] The raw data of the message, and the completion if it exists
    def as_json
      {
        raw:,
        completion: completion&.as_json
      }
    end
  end
end
