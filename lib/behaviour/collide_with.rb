class CollideWith < Behaviour::Base
  def initialize(target, &block)
    @target = target
    @action = block
    super()
  end

  def action(&block)
    @action = block
  end

  def update
    @action.call if collide?
  end

  def collide?
    @spirit.collide?(@target)
  end
end