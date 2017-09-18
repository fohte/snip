module Snip
  class SnipError < StandardError; end

  class NoSuchSnippetError < SnipError; end
end
