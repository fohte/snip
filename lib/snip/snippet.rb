module Snip
  class Snippet
    METADATA_REGEXP = Regexp.new("<%\s*#\s*(.*):\s*(.*)\s*%>")

    attr_accessor :params

    def initialize(string)
      @string = string
      @erb = ERB.new(@string, nil, '<>')
      @params = declared_params.each_with_object({}) { |p, h| h[p] = nil }
    end

    def print
      @erb.run(binding_class)
    end

    def read
      @erb.result(binding_class)
    end

    private

    def declared_params
      return unless metadata.key?('params')
      metadata['params'].split(',').map(&:strip)
    end

    def metadata
      @metadata ||=
        @string.each_line.map(&:chomp).each_with_object({}) do |line, hash|
          break hash unless line =~ METADATA_REGEXP
          hash[Regexp.last_match(1)] = Regexp.last_match(2)
        end
    end

    def binding_class
      BindingClass.new(params).bind
    end

    class BindingClass
      def initialize(params)
        define_reader_methods!(params)
      end

      def bind
        binding
      end

      private

      def define_reader_methods!(hash = {})
        hash.each do |k, v|
          define_singleton_method(k) { v }
        end
      end
    end
  end
end
