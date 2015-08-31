class Drop < Behaviour::Base
  def initialize(*callbacks)
    super
    @speed = 0
    @acc = 1
    add_callback(Callback.disappear)
  end

  def update
    @speed += @acc
    @sprite.center_y += @speed
  end

  def finish?
    @sprite.center_y >= World.world.scene.ground_y
  end
end