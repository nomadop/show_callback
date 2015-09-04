class Drop < Behaviour::Base
  DEFAULT_SPEED = 20

  def initialize(*callbacks)
    super
    @speed = DEFAULT_SPEED
  end

  def update
    @spirit.center_y += @speed
  end

  def finish?
    @spirit.center_y >=
        if World.scene.respond_to?(:ground_y)
          World.scene.ground_y
        else
          World::WORLD_HEIGHT - @sprite.half_height
        end
  end
end