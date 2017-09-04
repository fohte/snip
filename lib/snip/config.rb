require 'fileutils'

module Snip
  class Config
    class << self
      def home
        @home ||= File.join(
          ENV['XDG_CONFIG_HOME'] || File.join(Dir.home, '.config'),
          'snip',
        )
        FileUtils.mkdir_p(@home) unless File.exist?(@home)
        @home
      end

      def join(*paths)
        File.join(home, *paths)
      end

      def snippets(name)
        dir = join('snippets')
        FileUtils.mkdir_p(dir) unless File.exist?(dir)
        File.join(dir, name)
      end

      def yaml
        join('config.yaml')
      end
    end
  end
end
