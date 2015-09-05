module Scene
  class Base
    class << self
      def keybind(key_id, &block)
        $keybinds << key_id unless $keybinds.include?(key_id)
        define_method("key#{key_id}_pressed", &block)
      end
    end

    attr_accessor :spirits

    def initialize
      @spirits = []
      @started = false
      @finished = false
    end

    def start!
      return if start?
      @started = true
    end

    def start?
      @started
    end

    def finish!
      @finished = true
    end

    def finish?
      @finished
    end

    def add_spirit(spirit)
      @spirits << spirit
    end

    def remove_spirit(spirit)
      @spirits.delete(spirit)
    end

    def update
      @spirits.select(&:active?).each(&:update)
      World.next_scene if finish?
    end

    def draw
      @spirits.each(&:draw)
    end

    keybind(Gosu::KbEscape) do
      finish!
    end

    def method_missing(*args)
      method = args[0]
      if method =~ /key\d+_pressed/
        puts "This key is not bind in the current scene!"
      else
        super
      end
    end
  end
end
