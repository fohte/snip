module Snip
  class CLI
    class List
      class << self
        def echo
          _echo
        end

        private

        def _echo(root_path = Config.snippets, indent: 0)
          root_path.children.each do |path|
            if path.directory?
              stdout(dir(path), indent: indent)
              _echo(path, indent: indent + 2)
            end

            stdout(file(path), indent: indent) if path.file?
          end
        end

        def stdout(*msgs, indent: 0)
          puts ' ' * indent + msgs.join
        end

        def file(path)
          path.basename.to_s.sub(Config.snippets.to_s, '').chomp('.erb')
        end

        def dir(path)
          "\e[1;34m#{path.basename}:\e[0m"
        end
      end
    end
  end
end
