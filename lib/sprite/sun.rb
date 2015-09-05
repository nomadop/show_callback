class Sun < Ball
  DEFAULT_CENTER_X = -150
  DEFAULT_CENTER_Y = -100
  DEFAULT_RADIUS = 150

  def initialize(center_x: DEFAULT_CENTER_X, center_y: DEFAULT_CENTER_Y, radius: DEFAULT_RADIUS)
    super(center_x, center_y, radius, Color::ORANGE)
  end
end