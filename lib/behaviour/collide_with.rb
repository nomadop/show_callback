class CollideWith < Behaviour::Base
  def initialize(spirit)
    super()
    @other_spirit = spirit
  end

  def action
    callback if collide?
  end

  def collide?
    @spirit.collide?(@other_spirit)
  end
end