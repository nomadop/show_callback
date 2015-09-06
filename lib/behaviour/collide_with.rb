class CollideWith < Behaviour::Base
  def initialize(spirit)
    super()
    @other_spirit = spirit
  end

  def finish?
    @spirit.collide?(@other_spirit)
  end
end