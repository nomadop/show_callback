class Rain < Ball
  DEFAULT_CENTER_Y = 0
  MIN_RAIDUS = 2
  MAX_RAIDUS = 5

  def initialize(center_x: 0.upto(World::WORLD_WIDTH).to_a.sample, center_y: DEFAULT_CENTER_Y, radius: (MIN_RAIDUS...MAX_RAIDUS).to_a.sample)
    super(center_x, center_y, radius, Color.new(0, 100, 200))
    add_behaviour(Drop.new.add_callback(Callback.disappear(self)))
  end
end