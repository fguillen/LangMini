require "open_router"

module LangMini
  # Client to make requests to the Open Router API
  # @see https://openrouter.ai/docs
  # @see https://github.com/OlympiaAI/open_router
  #
  # @example Create a new client
  #   client = LangMini::Client.new(access_token: ENV["OPEN_ROUTER_KEY"])
  #
  class Client
    # Creates a new instance of the LangMini::Client
    #
    # @param access_token [String] The token to use when making requests to the
    #   Open Router API.
    def initialize(access_token:)
      @open_router_client = OpenRouter::Client.new(access_token: access_token)
    end

    # Get the list of models from [the Open Router API](https://openrouter.ai/models)
    #
    # @return [Array<String>] a sorted list of model IDs
    def models
      @models ||= @open_router_client.models.map { |e| e["id"] }.sort
    end

    # Request a completion from the model. A completion is basically an 'answer' from the model.
    #
    # @example Request a completion from the model
    #   messages_hash = [
    #     {
    #       "role": "system",
    #       "content": "You are a gentel assistant."
    #     },
    #     {
    #       "role": "user",
    #       "content": "hello"
    #     }
    #   ]
    #
    #   client = LangMini::Client.new(access_token: "TOKEN") 
    #
    #   response = 
    #     client.complete(
    #       messages_hash, 
    #       model: "openrouter/auto",
    #       extras: {
    #         temperature: 0.8
    #       }
    #     )
    #
    #   response["choices"][0]["message"]["content"] # => "Good day to you ..."
    #
    #
    # @param messages_hash [Array<Hash>] The list of messages to be used as context and prompt
    #   for the model.
    # @param model [String] The name of the model from the [OpenRouter available](https://openrouter.ai/models)
    #   to be used.
    # @param extras [Hash] Extras information that will be sent to the model. @see https://openrouter.ai/docs/requests
    # @return [Hash<LangMini::Message>] The response from the model.
    #   
    def complete(messages_hash, model: "openrouter/auto", extras: {})
      log("LangMini::Client.complete")
      log("model: #{model}")
      log("extras:")
      log(JSON.pretty_generate(extras))
      log("messages_hash:")
      log(JSON.pretty_generate(messages_hash))

      response =
        @open_router_client.complete(
          messages_hash,
          model:,
          extras:
        )

      log("Response:")
      log(JSON.pretty_generate(response))

      response
    end

    private

    def log(message)
      ::LangMini.logger.debug("LangMini::Client: #{message}")
    end
  end
end
