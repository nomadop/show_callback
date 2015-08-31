class ShowcaseScene < Scene::Base
  def initialize
    super
    @cases = []
  end

  def start
    @case_index = 0
    showcase(@case_index)
  end

  def add_case(sprites = [])
    sprites << yield if block_given?
    @cases << {sprites: sprites}
    self
  end

  def next_case
    @case_index += 1
    @case_index < @cases.size? ? showcase(@case_index) : finish!
  end

  def showcase(index)
    @sprites.clear
    @sprites = @cases.at(index)[:sprites]
  end

  keybind(Gosu::KbSpace) do
    next_case
  end
end