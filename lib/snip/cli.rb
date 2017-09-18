require 'thor'

module Snip
  class CLI < Thor
    desc 'new SNIPPET_NAME', ''
    def new(name)
      storage = Storage.new(name)
      pipe = stdin

      confirm "overwrite #{name} (#{storage.relative_path})? [y/N] ", default: false if storage.exist?

      unless pipe.empty?
        storage.write(pipe)
        return
      end

      storage.write
      system("$EDITOR #{storage.path}")
    end

    desc 'show SNIPPET_NAME', ''
    def show(name)
      puts File.read(Config.snippets(name))
    end

    desc 'list', ''
    def list
      List.echo
    end

    private

    def stdin
      if STDIN.tty?
        ''
      else
        STDIN.gets
      end
    end

    def confirm(msg, default: false)
      print msg
      loop do
        yn = STDIN.raw(&:getc)
        yn = default ? 'y' : 'n' if yn == "\n"
        case yn
        when 'y', 'Y'
          puts yn
          break
        when 'n', 'N'
          puts yn
          return
        when "\C-c", "\C-d"
          exit
        end
      end
    end
  end
end
