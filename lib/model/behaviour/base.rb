module Behaviour
  class Base
    include Activable

    def initialize(*callbacks)
      @callbacks = []
      @callbacks += callbacks
      @active = false
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