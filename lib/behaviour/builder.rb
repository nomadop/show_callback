module Behaviour
  class Builder
    def initialize(&block)
      @builder = block.to_proc
    end

    def after_build(&block)
      @after_build = block.to_proc
    end

    def build
      behaviour = @builder.call
      @after_build.call(behaviour) unless behaviour.nil? || @after_build.nil?
      behaviour
    end
  end
end