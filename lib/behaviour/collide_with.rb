class CollideWith < Behaviour::Base
  def initialize(spirit)
    super()
    @other_spirit = spirit
    @persistent = true
  end

  def finish?
    @spirit.collide?(@other_spirit)
  end
end