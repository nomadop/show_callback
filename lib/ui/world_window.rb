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
    @keybinds.each do |key_id|
      @scene.send("key#{key_id}_pressed") if button_down?(key_id)
    end
  end

  def register_keybind(key_id)
    @keybinds << key_id
    self
  end
end