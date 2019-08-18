require 'tco'
require_relative '../haml.rb'

module Slacktail
  class Presenter
    attr_accessor :history

    def self.output(history)
      new.output(history)
    end

    def output(history, view_file = 'history.haml')
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
      "#{ENV['APP_ROOT']}/lib/view/#{filename}"
    end

    def render(view, params)
      engine = ::Haml::Engine.new(view, escape_attrs: false)
      engine.render(Object.new, params)
    end
  end
end
