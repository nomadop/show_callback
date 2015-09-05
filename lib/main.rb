require 'gosu'
require 'require_all'

$keybinds = []
require_all './'

World.world = World.new
$keybinds.each { |key_id| World.window.register_keybind(key_id) }

rain_scene = RainScene.new(1000, 3)
showcase_scene = ShowcaseScene.new

# Case 1
showcase_scene.add_case('Bouncing Balls') do
  bouncing_ball1 = Ball.new(100, World::WORLD_HEIGHT - 50, Ball::DEFAULT_RADIUS, Color::RED)
  behaviour_chain = Chain.new(bouncing_ball1)
  behaviour_chain
      .set_argument(:init_speed, -30)
      .set_argument(:bouncing_rate, 0.9)
      .add_behaviour do |chain|
        init_speed = chain.get_argument(:init_speed) * chain.get_argument(:bouncing_rate)
        chain.set_argument(:init_speed, init_speed)
        Bounce.new(init_speed)
      end.loop!

  bouncing_ball2 = Ball.new(300, World::WORLD_HEIGHT - Ball::DEFAULT_RADIUS, Ball::DEFAULT_RADIUS, Color::BLUE)
  init_bounce_speed = -20
  bounce_chain = Chain.new(bouncing_ball2)
  bounce_chain
      .add_behaviour { Bounce.new(init_bounce_speed) }
      .loop!

  swing_speed = 5
  swing_chain = Chain.new(bouncing_ball2)
  swing_chain
      .add_behaviour { MoveRight.new(swing_speed * 39, swing_speed) }
      .add_behaviour { MoveLeft.new(swing_speed * 39, swing_speed) }
      .loop!

  [bouncing_ball1, bouncing_ball2]
end

# Case 2
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

#Case 3
showcase_scene.add_case('Ball running in clockwise') do
  padding = 150
  spirit = Ball.new(padding, padding, Ball::DEFAULT_RADIUS, Color::GREEN)
  behaviour_chain = Chain.new(spirit)
  behaviour_chain
      .add_behaviour { MoveDown.new(World::WORLD_HEIGHT - padding * 2, 5) }
      .add_behaviour { Wait.new(0.5) }
      .add_behaviour { MoveRight.new(World::WORLD_WIDTH - padding * 2, 7) }
      .add_behaviour { Wait.new(0.5) }
      .add_behaviour { MoveUp.new(World::WORLD_HEIGHT - padding * 2, 5) }
      .add_behaviour { Wait.new(0.5) }
      .add_behaviour { MoveLeft.new(World::WORLD_WIDTH - padding * 2, 7) }
      .add_behaviour { Wait.new(0.5) }
      .loop!
end

# Case 4
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
    .add_scene(ControlScene)
    .add_scene(rain_scene)
    .add_scene(showcase_scene)

World.next_scene

begin
  World.show
rescue Exception => e
  error = "inspect: #{e.inspect}, backtrace: #{e.backtrace}"
  puts error
end

