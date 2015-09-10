class RainScene < Scene::Base
  attr_accessor :ground_y

  def initialize(rain_remains, raining_rate, ground_height = 100)
    super()
    @ground_y = World::WORLD_HEIGHT - ground_height
    @drop_remains = rain_remains
    @raining_rate = raining_rate
    @raining_started = false
  end

  def start!
    super
    create_sun
    create_ground_line
  end

  def create_ground_line
    line = Line.new(World::WORLD_WIDTH, 1)
    @ground_line = Gosu::Image.new(World.window, line, false)
  end

  def rain_start!
    @raining_started = true
  end

  def rain_start?
    @raining_started
  end

  def update
    super
    @raining_rate.times { create_drop } if rain_start? && drop_remain?
  end

  def draw
    super
    @ground_line.draw(0, @ground_y, 1)
    World.window.print(
        "Drop Remains: #{@drop_remains}",
        20,
        World::WORLD_HEIGHT - 50,
        1
    )
  end

  def create_drop
    if drop_remain?
      @drop_remains -= 1
      drop_speed = 10
      drop = BallFactory.drop
      drop.add_behaviour(MoveDown.new(ground_y - drop.radius, drop_speed)) do |move_down|
        move_down.add_callback(disappear(drop))
      end
      add_spirit(drop)
    end
  end

  def create_sun
    sun = BallFactory.sun(center_x: 200, center_y: 150, radius: 150)
    sun.add_behaviour(Wait.new(2)) do |wait2|
      wait2.add_callback(next_behaviour(sun, MoveTo.new(-150, -100, 5) do |move_to|
        move_to.add_callback(next_behaviour(sun, Wait.new(1) do |wait1|
          wait1.add_callback(lambda { rain_start! })
        end))
      end))
    end
    add_spirit(sun)
  end

  def drop_remain?
    @drop_remains > 0
  end

  keybind(Gosu::KbUp) do
    @ground_y -= 3
  end

  keybind(Gosu::KbDown) do
    @ground_y += 3
  end
end