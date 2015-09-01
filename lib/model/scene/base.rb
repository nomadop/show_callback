module Scene
  class Base
    class << self
      def keybind(kid, &block)
        $keybinds << kid unless $keybinds.include?(kid)
        define_method("key#{kid}_pressed", &block)
      end
    end
    attr_accessor :spirits

    def initialize
      @spirits = []
      @finished = false
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
      @spirits.each(&:update)
      World.next_scene if finish?
    end

    def draw
      @spirits.each(&:draw)
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
