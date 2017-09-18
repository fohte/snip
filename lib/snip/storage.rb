module Snip
  class Storage
    attr_reader :group, :name

    def initialize(namespace)
      *@group, @name = split(namespace.to_s)
    end

    def path
      return default_path if default_path.exist?

      f = Config.snippets.join(*@group, @name)
      return f if f.exist?

      nil
    end

    def relative_path
      return unless path

      path.relative_path_from(Config.snippets)
    end

    def exist?
      !path.nil?
    end

    def write(string = '')
      f = path || default_path
      f.dirname.mkpath unless f.dirname.exist?
      f.write(string)
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
