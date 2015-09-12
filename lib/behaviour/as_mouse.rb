class AsMouse < Behaviour::Base
  def action
    @spirit.center_x = pos_x
    @spirit.center_y = pos_y
  end

  def pos_x
    tmp = [World.mouse.x, @spirit.half_width].max
    [tmp, World::WORLD_WIDTH - @spirit.half_width].min
  end

  def pos_y
    tmp = [World.mouse.y, @spirit.half_height].max
    [tmp, World::WORLD_HEIGHT - @spirit.half_height].min
  end
end