class Drop < Behaviour::Base
  def initialize(*callbacks)
    super
    @speed = 0
    @acc = 1
  end

  def attach_spirit(spirit)
    super
    add_callback(Callback.disappear(spirit))
  end

  def update
    @speed += @acc
    @spirit.center_y += @speed
  end

  def finish?
    super || @spirit.center_y >= World::WORLD_HEIGHT
  end
end