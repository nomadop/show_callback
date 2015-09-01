class Drop < Behaviour::Base
  def initialize(*callbacks)
    super
    @speed = 0
    @acc = 1
  end

  def attach_sprite(sprite)
    super
    add_callback(Callback.disappear(sprite))
  end

  def update
    @speed += @acc
    @sprite.center_y += @speed
  end

  def finish?
    super || @sprite.center_y >= World::WORLD_HEIGHT
  end
end