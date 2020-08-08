require 'tco'
require_relative '../haml.rb'

module Operation
  class Presenter
    attr_accessor :history

    def self.call(history)
      new.call(history)
    end

    def call(history, view_file = 'history.haml')
      return if history.filtered?

      rendered = render(view_of(view_file), history: history)
      rendered.fg(history.channel.parameter.color)
    end

    private

    def view_of(view_file)
      return @view unless @view.nil?

      view_filepath = view_filepath_of view_file
      @view = File.read(view_filepath)
    end

    def view_filepath_of(filename)
      "#{ENV['APP_ROOT']}/lib/slacktail/views/#{filename}"
    end

    def render(view, params)
      engine = ::Haml::Engine.new(view, escape_attrs: false)
      engine.render(Object.new, params)
    end
  end
end
