
# frozen_string_literal: true

require "logger"

require_relative "mini_lang/version"
require_relative "mini_lang/assistant"
require_relative "mini_lang/client"
require_relative "mini_lang/completion"
require_relative "mini_lang/config"
require_relative "mini_lang/conversation"
require_relative "mini_lang/logger"
require_relative "mini_lang/message"
require_relative "mini_lang/tool"
require_relative "mini_lang/utils"
require_relative "mini_lang/tools/database"
require_relative "mini_lang/tools/math"


module MiniLang
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
