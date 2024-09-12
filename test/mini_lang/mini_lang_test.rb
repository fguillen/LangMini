require "test_helper"

class MiniLangTest < ActiveSupport::TestCase
  def setup
    MiniLang.reset
  end

  def test_get_default_logger
    assert_equal("Logger", MiniLang.logger.class.name)
  end

  def test_set_logger
    MiniLang.logger = "LOGGER"
    assert_equal("LOGGER", MiniLang.logger)
  end

  def test_logger_debug
    logger_mock = mock
    logger_mock.expects(:debug).with("TEST")
    MiniLang.logger = logger_mock
    MiniLang.logger.debug("TEST")
  end
end
