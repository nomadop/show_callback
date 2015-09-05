class DisappearWhenCollideTarget < Behaviour::Base
  def initialize(target, *callbacks)
    super(*callbacks)
    @target = target
  end

  def attach_spirit(spirit)
    super
    add_callback(Callback.disappear(spirit))
  end

  def finish?
    @spirit.collide?(@target)
  end
end