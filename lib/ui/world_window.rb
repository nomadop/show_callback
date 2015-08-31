class WorldWindow < Gosu::Window
  attr_accessor :scene

  def initialize(width, height)
    super(width, height, false)
    @scene = Scene::Base.new
    @keybinds = []
    @last_input_at = Time.at(0)
  end

  def update
    now = Time.now
    send_input(now) if now - @last_input_at > 0.1

    @scene.update
  end

  def draw
    @scene.draw
  end

  def send_input(now)
    @last_input_at = now
    @keybinds.each do |kid|
      @scene.send("key#{kid}_pressed") if button_down?(kid)
    end
  end

  def register_keybind(kid)
    @keybinds << kid
    self
  end
end