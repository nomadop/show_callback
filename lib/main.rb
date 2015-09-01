require 'gosu'
require 'require_all'

require_all './'

World.world = World.new()
World.window
  .register_keybind(Gosu::KbUp)
  .register_keybind(Gosu::KbDown)
  .register_keybind(Gosu::KbLeft)
  .register_keybind(Gosu::KbRight)
  .register_keybind(Gosu::KbEscape)
  .register_keybind(Gosu::KbSpace)

rain_scene = RainScene.new(World::WORLD_HEIGHT - 50, 500, 0.9)
control_scene = ControlScene.new
showcase_scene = ShowcaseScene.new

showcase_scene.add_case do
  sprite = Ball.new(320, World::WORLD_HEIGHT - 51, 50, Color::BLUE)
  sprite.add_behaviour(Bouncing.new(-30))
end

showcase_scene.add_case do
  sprite = Ball.new(100, 100, 50, Color::GREEN)
  behaviour_chain = Chain.new
  behaviour_chain
    .add_behaviour(MoveDown.new(World::WORLD_HEIGHT - 200).reset_movement_after_finish)
    .add_behaviour(MoveRight.new(World::WORLD_WIDTH - 200).reset_movement_after_finish)
    .add_behaviour(MoveUp.new(World::WORLD_HEIGHT - 200).reset_movement_after_finish)
    .add_behaviour(MoveLeft.new(World::WORLD_WIDTH - 200).reset_movement_after_finish)

  behaviour_chain.loop!
  sprite.add_behaviour(behaviour_chain.first_behaviour)
end

World.add_scene(control_scene)
World.add_scene(rain_scene)
World.add_scene(showcase_scene)
World.next_scene

World.show

