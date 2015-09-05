class WorldWindow < Gosu::Window
  attr_accessor :scene
  attr_reader :default_font

  def initialize(width, height, fullscreen)
    super(width, height, fullscreen)
    @scene = Scene::Base.new
    @keybinds = []
    @last_input_at = Time.at(0)
    @default_font = Gosu::Font.new(self, Gosu::default_font_name, 24)
  end

  def update
    now = Time.now
    send_input(now) if now - @last_input_at > 0.1

    @scene.update
  end

  def draw
    @scene.draw
    @default_font.draw("FPS: #{Gosu::fps}", World::WORLD_WIDTH - 100, 10, 1)
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