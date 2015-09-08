module Behaviour
  class Base
    include Activable

    def initialize
      @callbacks = []
      @active = false
      yield(self) if block_given?
    end

    def update
      return if finish?
    end

    def finish?
      false
    end

    def attach_spirit(spirit)
      @spirit = spirit
    end

    def add_callback(callback)
      @callbacks << callback
      self
    end

    def remove_callback(callback)
      @callbacks.delete(callback)
      self
    end

    def callback
      @callbacks.each(&:call)

      @callbacks.clear
    end

    def to_s
      "Behaviour #{self.class.name}: #{super}"
    end
  end
end