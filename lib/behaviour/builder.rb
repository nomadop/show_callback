module Behaviour
  class Builder
    def initialize(*args, &block)
      @args = args
      @builder = block.to_proc
    end

    def after_build(&block)
      @after_build = block.to_proc
    end

    def build
      behaviour = @args.empty? ? @builder.call : @builder.call(*@args)
      @after_build.call(behaviour) unless @after_build.nil?
      behaviour
    end
  end
end