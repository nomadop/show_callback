require 'gosu'
require 'require_all'

$keybinds = []
require_all './'

World.world = World.new
$keybinds.each { |key_id| World.window.register_keybind(key_id) }

control_scene = ControlScene.new
rain_scene = RainScene.new(1000, 3)
showcase_scene = ShowcaseScene.new

showcase_scene.add_case('Bouncing Balls') do
  spirit1 = Ball.new(100, World::WORLD_HEIGHT - 40, 40, Color::RED)
  spirit1.add_behaviour(Bounce.new(-30))

  spirit2 = Ball.new(300, World::WORLD_HEIGHT - Ball::DEFAULT_RADIUS, Ball::DEFAULT_RADIUS, Color::BLUE)
  spirit2.add_behaviour(Bounce.new(-20, 1))

  swing_speed = 5
  behaviour_chain = Chain.new(spirit2)
  behaviour_chain
      .add_behaviour { MoveRight.new(swing_speed * 39, swing_speed) }
      .add_behaviour { MoveLeft.new(swing_speed * 39, swing_speed) }
      .loop!

  [spirit1, spirit2]
end

showcase_scene.add_case('Ball running in a path') do
  spirit = Ball.new(70, 100, Ball::DEFAULT_RADIUS, Color::PURPLE)
  path = [
      Point.new(70, 200), Point.new(170, 200), Point.new(170, 300),
      Point.new(70, 300), Point.new(70, 400), Point.new(370, 400),
      Point.new(370, 300), Point.new(270, 300), Point.new(270, 200),
      Point.new(370, 200), Point.new(370, 100), Point.new(470, 100),
      Point.new(470, 200), Point.new(570, 200), Point.new(570, 300),
      Point.new(470, 300), Point.new(470, 400), Point.new(570, 400)
  ]

  behaviour_chain = Chain.new(spirit)
  path.each do |point|
    behaviour_chain
        .add_behaviour { MoveTo.new(point.x, point.y, 5) }
        .add_behaviour { Wait.new(0.1) }
  end
  behaviour_chain.end!
end

showcase_scene.add_case('Ball running in clockwise') do
  padding = 150
  spirit = Ball.new(padding, padding, Ball::DEFAULT_RADIUS, Color::GREEN)
  behaviour_chain = Chain.new(spirit)
  behaviour_chain
      .add_behaviour { MoveDown.new(World::WORLD_HEIGHT - padding * 2) }
      .add_behaviour { Wait.new(0.5) }
      .add_behaviour { MoveRight.new(World::WORLD_WIDTH - padding * 2, 10) }
      .add_behaviour { Wait.new(0.5) }
      .add_behaviour { MoveUp.new(World::WORLD_HEIGHT - padding * 2) }
      .add_behaviour { Wait.new(0.5) }
      .add_behaviour { MoveLeft.new(World::WORLD_WIDTH - padding * 2, 10) }
      .add_behaviour { Wait.new(0.5) }
      .loop!
end

showcase_scene.add_case('Passing energy between balls') do
  balls = [
      Ball.new(100, 100, Ball::DEFAULT_RADIUS, Color::RED),
      Ball.new(100, 380, Ball::DEFAULT_RADIUS, Color::YELLOW),
      Ball.new(320, 380, Ball::DEFAULT_RADIUS, Color::GREEN),
      Ball.new(580, 380, Ball::DEFAULT_RADIUS, Color::CYAN),
      Ball.new(580, 100, Ball::DEFAULT_RADIUS, Color::BLUE),
      Ball.new(320, 100, Ball::DEFAULT_RADIUS, Color::PURPLE)
  ]
  balls.each(&:freeze!)

  speed = 5
  balls[0]
      .add_behaviour(MoveTo.new(100, 280, speed)
      .add_callback(Callback.active_spirit(balls[1])))
      .active!
  balls[1]
      .add_behaviour(MoveTo.new(220, 380, speed)
      .add_callback(Callback.active_spirit(balls[2])))
  balls[2]
      .add_behaviour(MoveTo.new(480, 380, speed)
      .add_callback(Callback.active_spirit(balls[3])))
  balls[3]
      .add_behaviour(MoveTo.new(580, 200, speed)
      .add_callback(Callback.active_spirit(balls[4])))
  balls[4]
      .add_behaviour(MoveTo.new(420, 100, speed)
      .add_callback(Callback.active_spirit(balls[5])))
  balls[5].add_behaviour(MoveTo.new(200, 100, speed))

  balls
end

World
    .add_scene(control_scene)
    .add_scene(rain_scene)
    .add_scene(showcase_scene)

World.next_scene

begin
  World.show
rescue Exception => e
  error = "inspect: #{e.inspect}, backtrace: #{e.backtrace}"
  puts error
end

