class World
  class << self
    @@world

    def world
      @@world
    end

    def world=(world)
      @@world = world
    end

    def method_missing(*args)
      world.send(*args)
    end
  end
  WORLD_WIDTH = 640
  WORLD_HEIGHT = 480

  attr_accessor :window
  attr_accessor :scene

  def initialize(start_scene = nil)
    @window = WorldWindow.new(WORLD_WIDTH, WORLD_HEIGHT)
    start_scene ||= Scene::Base.new
    @scenes = [start_scene]
    change_scene(start_scene)
  end

  def add_scene(scene)
    @scenes << scene
    self
  end

  def next_scene
    scene = @scenes.first
    scene.nil? ? close : change_scene(scene)
  end

  def show
    @window.show
  end

  def close
    @window.close
    exit(0)
  end

  def change_scene(scene)
    @scenes.delete(scene)
    scene = scene.new if scene.respond_to?(:new)
    @scene = scene
    @window.scene = @scene
    @scene.start
  end

  def create_image(image)
    Gosu::Image.new(@window, image, false)
  end
end