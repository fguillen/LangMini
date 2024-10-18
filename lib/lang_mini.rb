# frozen_string_literal: true

require "logger"

require_relative "lang_mini/version"
require_relative "lang_mini/assistant"
require_relative "lang_mini/client"
require_relative "lang_mini/completion"
require_relative "lang_mini/config"
require_relative "lang_mini/conversation"
require_relative "lang_mini/logger"
require_relative "lang_mini/message"
require_relative "lang_mini/tool"
require_relative "lang_mini/utils"
require_relative "lang_mini/tools/database"
require_relative "lang_mini/tools/math"

# Small library for large language models
module LangMini
  DEFAULT_MODEL = "openai/gpt-4o"

  def self.reset
    @@logger = nil
  end

  def self.logger=(p_logger)
    @@logger = p_logger
  end

  def self.logger
    @@logger ||= Logger.new($stdout)
  end
end
