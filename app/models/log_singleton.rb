require "singleton"

class LogSingleton
    include Singleton

  attr_reader :message
  
  def initialize
    @message = "Logfile created onY::#{Time.now}"
  end

  def error(msg)
      File.open("application_log.txt", "a") { |f| f.write "#{message}#{msg}\n"}
  end

  def info(msg)
    File.open("application_log.txt", "a") { |f| f.write "#{message}#{msg}\n"}
  end
  
end