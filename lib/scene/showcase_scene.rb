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
    @cases << { name: name, builder: block }
    self
  end

  def next_case
    @case_index += 1
    @case_index = 0 unless @case_index < @cases.size
    showcase
  end

  def pre_case
    @case_index -= 1
    @case_index = @cases.size - 1 if @case_index < 0
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
    World.window.default_font.draw(case_name, 20, 20, 1)
  end

  keybind(Gosu::KbLeft) do
    pre_case
  end

  keybind(Gosu::KbRight) do
    next_case
  end
end