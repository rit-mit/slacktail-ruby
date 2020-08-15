require 'haml'
require 'terminal-table'

module Haml
  module Helpers
    def partial(filename, locals = {})
      filepath = "#{ENV['APP_ROOT']}/lib/slacktail/views/#{filename}"
      return '' unless File.exist? filepath

      render_with_filepath(filepath, locals)
    rescue StandardError => e
      puts 'Exception! in render!!'
      pp filename
      pp locals
      pp e.class
      pp e.message
      pp e.backtrace
      $sigint = true
    end

    def box_partial(filename, locals = {})
      box_title = locals.fetch(:box_title, '')
      box(partial(filename, locals), box_title)
      partial(filename, locals)
    end

    def indent(txt)
      return if txt.nil?
      return if !txt.is_a?(String) && !txt.respond_to?(to_s)

      txt.to_s.strip.split("\n").map do |t|
        "    #{t}"
      end.join("\n")
    end

    def box(txt, box_title = '')
      Terminal::Table.new do |t|
        t.title = box_title if box_title != ''
        t.rows = [[txt]]
      end
    end

    private

    def encode(val)
      return val unless val.respond_to? :force_encoding

      val.force_encoding(Encoding::UTF_8)
    end

    def render_with_filepath(filepath, locals)
      haml = encode(File.read(filepath))

      if locals.blank?
        ::Haml::Engine.new(haml).render
      else
        ::Haml::Engine.new(haml).render(Object.new, locals)
      end
    end
  end
end
