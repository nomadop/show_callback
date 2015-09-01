class ControlScene < Scene::Base
  def start
    @control_spirit = Ball.new(320, 240, 50, Color::WHITE)
    @control_spirit.extend(GoStraight)
    add_spirit(@control_spirit)
  end

  keybind(Gosu::KbUp) do
    @control_spirit.up
  end

  keybind(Gosu::KbDown) do
    @control_spirit.down
  end

  keybind(Gosu::KbLeft) do
    @control_spirit.left
  end

  keybind(Gosu::KbRight) do
    @control_spirit.right
  end

  keybind(Gosu::KbSpace) do
    @control_spirit.stop!
  end
end