require 'thor'
require 'erb'

module Snip
  class CLI < Thor
    class << self
      def exit_on_failure?
        true
      end

      def start(*)
        super
      rescue SnipError => e
        puts "\e[31mError: #{e}\e[0m"
      end
    end

    desc 'new SNIPPET_NAME', ''
    map 'n' => :new
    def new(name)
      storage = Storage.new(name)
      pipe = stdin

      confirm "overwrite #{name} (#{storage.relative_path})? [y/N] ", default: false if storage.exist?

      unless pipe.empty?
        storage.write(pipe)
        return
      end

      storage.write
      run_editor(storage.path)
    end

    desc 'edit SNIPPET_NAME', ''
    map 'e' => :edit
    def edit(name)
      storage = Storage.new(name)
      raise NoSuchSnippetError, "no such snippet: #{name}" unless storage.file?

      run_editor(storage.path)
    end

    desc 'show SNIPPET_NAME', ''
    option :params, type: :hash, aliases: 'p'
    map 's' => :show
    def show(name)
      storage = Storage.new(name)
      raise NoSuchSnippetError, "no such snippet: #{name}" unless storage.file?

      snip = Snippet.new(storage.path.read)
      snip.params = options[:params] if options[:params]
      snip.print
    end

    desc 'list', ''
    map 'ls' => :list
    map 'l' => :list
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

    def run_editor(filepath)
      system("#{editor} #{filepath}")
    end

    def editor
      ENV['EDITOR'] || 'vim'
    end
  end
end
