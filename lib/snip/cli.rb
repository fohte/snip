require "thor"

module Snip
  class CLI < Thor
    desc "add", ""
    def add

    end

    desc "print", ""
    map "p" => :print
    def print

    end

    desc "list", ""
    def list

    end
  end
end
