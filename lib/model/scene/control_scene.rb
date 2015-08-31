class ControlScene < Scene::Base
  def start
    @control_sprite = Ball.new(320, 240, 50, Color::GREEN)
    @control_sprite.extend(GoStraight)
    add_sprite(@control_sprite)
  end

  keybind(Gosu::KbUp) do
    @control_sprite.up
  end

  keybind(Gosu::KbDown) do
    @control_sprite.down
  end

  keybind(Gosu::KbLeft) do
    @control_sprite.left
  end

  keybind(Gosu::KbRight) do
    @control_sprite.right
  end

  keybind(Gosu::KbSpace) do
    @control_sprite.stop!
  end
end