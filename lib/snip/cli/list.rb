module Snip
  class CLI
    class List
      class << self
        def echo
          _echo
        end

        private

        def _echo(root_path = Config.snippets, indent = 0)
          p = ->(msg) { puts ' ' * indent + msg.to_s }

          root_path.children.each do |path|
            if path.directory?
              print "\e[1;34m" # enable bold and blue text
              p.call "#{path.basename}:"
              print "\e[0m"

              _echo(path, indent + 2)
            end

            p.call path.basename.to_s.sub(Config.snippets.to_s, '').chomp('.erb') if path.file?
          end
        end
      end
    end
  end
end
