# frozen_string_literal: true

module LangMini
  module Tools
    class Math < LangMini::Tool
      def tool_description_path
        "#{__dir__}/math.json"
      end

      def sum(num_1:, num_2:)
        num_1 + num_2
      end
    end
  end
end
