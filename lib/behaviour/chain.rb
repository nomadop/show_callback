module Behaviour
  class Chain
    attr_reader :behaviour_builders

    def initialize(spirit, arguments = {})
      @spirit = spirit
      @behaviour_builders = []
      @arguments = arguments
      yield(self) if block_given?
    end

    def set_arguments(arguments = {})
      @arguments.merge!(arguments)
      self
    end

    def get_arguments(key)
      @arguments.fetch(key)
    end

    def add_behaviour(&block)
      behaviour_builder = Behaviour::Builder.new(&block)
      link_behaviour(behaviour_builder)

      @behaviour_builders << behaviour_builder
      self
    end

    def link_behaviour(behaviour_builder)
      return if @behaviour_builders.empty?

      last_builder = @behaviour_builders.last
      last_builder.after_build do |behaviour|
        behaviour.add_callback(next_behaviour(@spirit, behaviour_builder))
      end
    end

    def loop!
      link_behaviour(first_builder)
      attach_spirit
    end

    def end!
      attach_spirit
    end

    private
    def first_builder
      @behaviour_builders.first
    end

    def attach_spirit
      @spirit.add_behaviour(first_behaviour)
    end

    def first_behaviour
      first_builder.build
    end
  end
end