class ShowcaseScene < Scene::Base
  def initialize
    super
    @cases = []
  end

  def start!
    super
    @case_index = 0
    showcase
  end

  def add_case(name, &block)
    @cases << { name: name, builder: block.to_proc }
    self
  end

  def next_case
    @case_index += 1
    @case_index = 0 unless @case_index < @cases.size
    showcase
  end

  def showcase
    @spirits.clear
    builder = current_case[:builder]
    @spirits += Array(builder.call)
  end

  def current_case
    @cases.at(@case_index)
  end


  def draw
    super
    case_name = current_case[:name]
    World.window.default_font.draw(case_name, 10, 10, 1)
  end

  keybind(Gosu::KbSpace) do
    next_case
  end
end