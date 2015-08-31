module Behaviour
  class Base
    attr_reader :sprite

    def initialize(*callbacks)
      @callbacks = []
      @callbacks += callbacks
    end

    def finish?
      false
    end

    def attach_sprite(sprite)
      @sprite = sprite
    end

    def add_callback(callback, &block)
      @callbacks << (block_given? ? block.to_proc : callback)
      self
    end

    def remove_callback(callback)
      @callbacks.delete(callback)
      self
    end

    def callback
      @callbacks.each do |callback|
        callback.call(self)
      end
    end
  end
end