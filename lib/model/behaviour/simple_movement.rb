class SimpleMovement < Behaviour::Base
  DEFAULT_SPEED = 5

  attr_accessor :moved

  def initialize(distance, speed)
    super()
    @speed = speed
    @distance = distance
    @moved = 0
  end

  def update
    @moved += move
  end

  def finish?
    super || @moved >= @distance
  end

  def reset_movement_after_finish
    add_callback(reset_movement_callback)
  end

  def reset_movement_callback
    Callback.new(self) do |behaviour|
      behaviour.moved = 0
      # puts "callbacks: #{behaviour.callbacks.map(&:to_s)}"
      # puts "current: #{self}"
    end
  end
end