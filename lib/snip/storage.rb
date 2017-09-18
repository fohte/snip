module Snip
  class Storage
    attr_reader :group, :name

    def initialize(namespace)
      *@group, @name = split(namespace.to_s)
    end

    def path
      return default_path if default_path.exist?

      Config.snippets.join(*@group, @name).tap do |f|
        return f if f.exist?
      end

      nil
    end

    def relative_path
      return unless path

      path.relative_path_from(Config.snippets)
    end

    def exist?
      !path.nil?
    end

    def file?
      exist? && path.file?
    end

    def dir?
      exist? && path.dir?
    end

    def write(string = '')
      (path || default_path).tap do |f|
        f.dirname.mkpath unless f.dirname.exist?
        f.write(string)
      end
    end

    private

    def default_path
      Config.snippets.join(*@group, "#{@name}.erb")
    end

    def split(str)
      str.split(':')
    end
  end
end
