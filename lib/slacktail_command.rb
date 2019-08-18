require 'pry'
require 'daemons'
require 'thor'
require 'tco'
require 'parallel'
require_relative './slacktail.rb'

####################
# signal trap
# https://tmtms.hatenablog.com/entry/2014/09/23/ruby-signal
mutex = Mutex.new
$sigint = false

Thread.new do
  loop do
    if $sigint
      $sigint = false
      mutex.synchronize do
        puts "\n"
        puts 'interrupted!'.fg('#FFFF00')
        sleep 1
        exit 0
      end
    end
    sleep 0.1
  end
end

trap :INT do
  $sigint = true
end
trap :TERM do
  $sigint = true
end
####################

class SlacktailCommand < Thor
  include Loggable

  desc 'start', 'Startup the App'
  method_option :daemonize, aliases: '-d', default: false, contents: :boolean, banner: 'Run as daemon'
  def start
    run_app(options[:daemonize])
  end

  desc 'stop', 'Stop the daemon'
  def stop
    stop_app
  end

  no_commands do
    def run_app(run_as_daemon)
      write_pid

      Daemons.daemonize if run_as_daemon

      main
    end

    def stop_app; end

    def main
      puts 'slacktail start!!'.fg('#FFFF00')

      ::Slacktail::Tailer.fetch_and_print_with_parallel
    rescue StandardError => e
      puts 'Exception!'.fg('#FF0000')
      pp e.class
      pp e.message
      pp e.backtrace
      $sigint = true
    end

    def write_pid
      File.open("#{ENV['PID_DIR'] || '/tmp'}/slacktail.pid", 'w') { |f| f.puts(Process.pid) }
    end
  end
end
