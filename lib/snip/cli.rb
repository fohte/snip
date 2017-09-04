require 'thor'

module Snip
  class CLI < Thor
    desc 'add SNIPPET_NAME', ''
    def add(name)
      File.open(Config.snippets(name), 'w') do |f|
        f.write('test')
      end
    end

    desc 'print SNIPPET_NAME', ''
    map 'p' => :print
    def print(name)
      puts File.read(Config.snippets(name))
    end

    desc 'list', ''
    def list

    end
  end
end
