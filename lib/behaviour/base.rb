module Behaviour
  class Base
    include Activable

    def initialize
      @callbacks = []
      @active = false
      @persistent = false
      yield(self) if block_given?
    end

    def finish?
      false
    end

    def persistent?
      @persistent
    end

    def update; end

    def attach_spirit(spirit)
      @spirit = spirit
    end

    def add_callback(callback)
      @callbacks << callback
      self
    end

    def callback
      @callbacks.each(&:call)
    end

    def to_s
      "Behaviour #{self.class.name}: #{super}"
    end
  end
end