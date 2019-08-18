require 'digest/md5'
require 'fileutils'

class Cache
  class << self
    def get(key)
      cache.get(key)
    end

    def set(key, value)
      cache.save(key, value)
    end

    def fetch(key, &block)
      cache.get(key, &block)
    end

    private

    def cache
      return @cache unless @cache.nil?

      @cache = JsonCache.new(dir: cache_dir)
    end

    def cache_dir
      # TODO : tokenごとにディレクトリを切り替えたい
      Settings.cache.cache_dir
    end
  end
end

#############

require 'json'
require 'fileutils'
require 'pathname'

# http://lethe2211.hatenablog.com/entry/2014/07/23/161155
class JsonCache
  PREFIX = 'cache_'.freeze
  POSTFIX = '.json'.freeze

  attr_accessor :cache_dir

  def initialize(dir:)
    @cache_dir = dir || 'cache/'

    FileUtils.mkdir_p(@cache_dir)
  end

  def get(key)
    cache_file = cache_file_of key

    return nil unless File.exist? cache_file

    json = File.read(cache_file_of(key))
    result = JSON.parse(json)

    result
  end

  def set(key, value)
    File.open(cache_file_of(key), 'w') do |io|
      JSON.dump(value, io)
    end
  end
  alias save set

  private

  def cache_file_of(key)
    cache_filename = "#{PREFIX}#{key}#{POSTFIX}"
    Pathname(cache_dir).join(cache_filename)
  end
end
