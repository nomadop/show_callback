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
    @scene_index = 0
    change_scene(0)
  end

  def add_scene(scene)
    @scenes << scene
  end

  def next_scene
    @scene_index += 1
    @scene_index < @scenes.size ? change_scene(@scene_index) : close
  end

  def show
    @window.show
  end

  def close
    exit(0)
    @window.close
  end

  def change_scene(index)
    @scene = @scenes[index]
    @window.scene = @scene
    @scene.start
  end

  def create_image(image)
    Gosu::Image.new(@window, image, false)
  end
end