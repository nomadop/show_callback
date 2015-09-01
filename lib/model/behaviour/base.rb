module Behaviour
  class Base
    attr_reader :spirit
    attr_reader :callbacks

    def initialize(*callbacks)
      @callbacks = []
      @callbacks += callbacks
      @active = false
      @finish = false
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
      @finish
    end

    def finish!
      @finish = true
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
      @callbacks.each do |callback|
        callback.call
      end
    end

    def to_s
      "Behaviour #{self.class.name}: #{super}"
    end
  end
end