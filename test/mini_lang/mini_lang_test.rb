require "test_helper"

class MiniLangTest < Minitest::Test
  def setup
    MiniLang.reset
  end

  def test_that_it_has_a_version_number
    refute_nil ::MiniLang::VERSION
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
