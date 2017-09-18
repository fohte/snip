require 'pathname'

module Snip
  class Config
    class << self
      def root
        @root ||= Pathname.new(home_dir).tap do |f|
          f.mkpath unless f.exist?
        end
      end

      def snippets
        root.join('snippets')
      end

      def yaml
        root.join('config.yaml')
      end

      private

      def home_dir
        File.join(
          ENV['XDG_CONFIG_HOME'] || File.join(Dir.home, '.config'),
          'snip',
        )
      end
    end
  end
end
