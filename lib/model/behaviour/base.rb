module Behaviour
  class Base
    attr_reader :sprite
    attr_reader :callbacks

    def initialize(*callbacks)
      @callbacks = []
      @callbacks += callbacks
      @active = false
    end

    def active?
      @active
    end

    def inactive?
      !@active
    end

    def active!
      @active = true
    end

    def finish?
      false
    end

    def attach_sprite(sprite)
      @sprite = sprite
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
      @callbacks.each do |callback|
        callback.call
      end
    end

    def to_s
      "Behaviour #{self.class.name}: #{super}"
    end
  end
end