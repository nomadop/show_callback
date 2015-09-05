class ControlScene < Scene::Base
  def start!
    super
    @control_spirit =
        BallFactory.ball(World::WORLD_WIDTH / 2, World::WORLD_HEIGHT / 2, 100, Color::WHITE)
    @control_spirit.extend(GoStraight)
    add_spirit(@control_spirit)
  end

  keybind(Gosu::KbUp) do
    @control_spirit.go_up
  end

  keybind(Gosu::KbDown) do
    @control_spirit.go_down
  end

  keybind(Gosu::KbLeft) do
    @control_spirit.go_left
  end

  keybind(Gosu::KbRight) do
    @control_spirit.go_right
  end

  keybind(Gosu::KbSpace) do
    @control_spirit.stop!
  end
end