module Scene
  class Base
    class << self
      def keybind(kid, &block)
        $keybinds << kid unless $keybinds.include?(kid)
        define_method("key#{kid}_pressed", &block)
      end
    end
    attr_accessor :sprites

    def initialize
      @sprites = []
      @finished = false
    end

    def finish!
      @finished = true
    end

    def finish?
      @finished
    end

    def add_sprite(sprite)
      @sprites << sprite
    end

    def remove_sprite(sprite)
      @sprites.delete(sprite)
    end

    def update
      @sprites.each(&:update)
      World.next_scene if finish?
    end

    def draw
      @sprites.each(&:draw)
    end

    def start; end

    keybind(Gosu::KbEscape) do
      World.next_scene
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
