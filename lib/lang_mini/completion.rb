# frozen_string_literal: true

module LangMini
  # Represents an answer from the model
  # The `raw` is a hash with the following structure:
  #   {
  #     "id": "gen-65tQ5SrtTo1B5WN73LTkn3c9DDal",
  #     "model": "meta-llama/llama-3.1-8b-instruct:free",
  #     "object": "chat.completion",
  #     "created": 1722289059,
  #     "choices": [
  #       {
  #         "index": 0,
  #         "message": {
  #           "role": "assistant",
  #           "content": "The color of the sky can look different depending on the time of day and atmospheric conditions.\n\nDuring the day, when the sun is overhead, the sky typically appears blue. This is because the Earth's atmosphere scatters the sunlight in all directions, with shorter (blue) wavelengths being scattered more than longer (red) wavelengths. This phenomenon is known as Rayleigh scattering.\n\nHowever, the color of the sky can change under different conditions:\n\n* During sunrise and sunset, the sky can appear red, orange, pink, or purple due to the scattering of light by atmospheric particles.\n* On overcast days, the sky may appear gray or white due to the clouds blocking direct sunlight.\n* At night, the sky can appear dark, with stars and constellations visible due to the absence of direct sunlight.\n\nSo, to answer your question, the color of the sky is often blue, but it can change depending on the time of day and atmospheric conditions!"
  #         },
  #         "finish_reason": "stop",
  #         "logprobs": null
  #       }
  #     ],
  #     "usage": {
  #       "prompt_tokens": 29,
  #       "completion_tokens": 191,
  #       "total_tokens": 220
  #     }
  #   }
  class Completion
    attr_reader :raw

    # Create a new completion instance.
    # @param raw [Hash] The data returned from the model. The hash keys will be converted to symbols
    # @return [Completion]
    def initialize(raw)
      @raw = LangMini::Utils.symbolize_keys(raw)
    end

    # Extracts the message from the completion.
    # It selects automatically the first one into the `choices` array.
    # The rest will be ignored. (TODO: check if this is right in all cases)
    #
    # @return [LangMini::Message]
    def message
      raw[:choices][0][:message]
    end

    # Extracts the tool calls from the completion.
    # It selects automatically the `tool_calls` into the first `choice` in the array.
    # The rest will be ignored. (TODO: check if this is right in all cases)
    #
    # @return [Array<Hash>]
    def tool_calls
      raw[:choices][0][:message][:tool_calls]
    end

    # @return [Boolean] true if the completion has tool calls
    def tools?
      tool_calls.present?
    end

    # @return [String] the model name
    def model
      raw[:model]
    end
  end
end
