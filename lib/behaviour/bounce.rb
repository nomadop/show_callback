class Bounce < Behaviour::Base
  def initialize(init_speed, *callbacks)
    super(*callbacks)
    @speed = init_speed
    @acc = 1
  end

  def update
    @speed += @acc
    @spirit.center_y += move
  end

  def move
    [@speed, World::WORLD_HEIGHT - @spirit.half_height - @spirit.center_y].min
  end

  def finish?
    @spirit.center_y + @spirit.half_height >=
        (World.scene.respond_to?(:ground_y) ? World.scene.ground_y : World::WORLD_HEIGHT)
  end
end