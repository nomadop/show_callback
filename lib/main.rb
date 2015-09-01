require 'gosu'
require 'require_all'

$keybinds = []
require_all './'

World.world = World.new()
$keybinds.each { |kid| World.window.register_keybind(kid) }

rain_scene = RainScene.new(10, 0.9)
control_scene = ControlScene.new
showcase_scene = ShowcaseScene.new

showcase_scene.add_case do
  spirit = Ball.new(320, World::WORLD_HEIGHT - 50, 50, Color::BLUE)
  spirit.add_behaviour(Bouncing.new(-30))
end

showcase_scene.add_case do
  padding = 150
  spirit = Ball.new(padding, padding, 50, Color::GREEN)
  behaviour_chain = Chain.new(spirit)
  behaviour_chain
    .add_behaviour { MoveDown.new(World::WORLD_HEIGHT - padding * 2) }
    .add_behaviour { MoveRight.new(World::WORLD_WIDTH - padding * 2) }
    .add_behaviour { MoveUp.new(World::WORLD_HEIGHT - padding * 2) }
    .add_behaviour { MoveLeft.new(World::WORLD_WIDTH - padding * 2) }
    .loop!
end

World
  .add_scene(control_scene)
  .add_scene(rain_scene)
  .add_scene(showcase_scene)
World.next_scene

World.show

