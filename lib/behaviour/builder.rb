module Behaviour
  class Builder
    def initialize(&block)
      @builder = block
    end

    def after_build(&block)
      @after_build = block
    end

    def build
      behaviour = @builder.call
      @after_build.call(behaviour) unless behaviour.nil? || @after_build.nil?
      behaviour
    end
  end
end