class ShowcaseScene < Scene::Base
  def initialize
    super
    @case_builders = []
  end

  def start
    @case_index = 0
    showcase
  end

  def add_case(&block)
    @case_builders << block
    self
  end

  def next_case
    @case_index += 1
    @case_index = 0 unless @case_index < @case_builders.size
    showcase
  end

  def showcase
    @sprites.clear
    builder = @case_builders.at(@case_index)
    @sprites += Array(builder.call)
  end

  keybind(Gosu::KbSpace) do
    next_case
  end
end