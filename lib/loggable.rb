require 'logger'

module Loggable
  def info(message)
    info_logger.info message
  end

  def debug(message)
    debug_logger.debug message
  end

  private

  def log_dir
    ENV['LOG_DIR'] || '/tmp/log'
  end

  def info_logger
    @info_logger ||= Logger.new("#{log_dir}/info.log")
  end

  def debug_logger
    @debug_logger ||= Logger.new("#{log_dir}/debug.log")
  end
end
