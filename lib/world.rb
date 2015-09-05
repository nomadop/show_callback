class World
  class << self
    @@world

    def world
      @@world
    end

    def world=(world)
      @@world = world
    end

    def new(*args)
      instance = super
      World.world = instance
    end

    def method_missing(*args)
      world.send(*args)
    end
  end
  WORLD_WIDTH = 1280
  WORLD_HEIGHT = 800

  attr_accessor :window
  attr_accessor :scene

  def initialize(caption: "Hello World !", fullscreen: true)
    @fullscreen = fullscreen
    @caption = caption
    @scenes = []
  end

  def add_scene(scene)
    @scenes << scene
    self
  end

  def current_scene
    @scenes.first
  end

  def next_scene
    @scenes.delete_at(0)
    close if @scenes.empty?

    set_scene
  end

  def show
    @window = WorldWindow.new(WORLD_WIDTH, WORLD_HEIGHT, @fullscreen)
    @window.caption = @caption
    $keybinds.each { |key_id| @window.register_keybind(key_id) }
    set_scene
    @window.show
  end

  def close
    @window.close
    exit(0)
  end

  def set_scene
    @scenes[0] = current_scene.new if current_scene.is_a?(Class)
    @scene = current_scene
    @window.scene = @scene
    @scene.start!
  end

  def create_image(image)
    Gosu::Image.new(@window, image, false)
  end
end