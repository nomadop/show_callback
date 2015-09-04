module Activable
  def active?
    @active
  end

  def active!
    @active = true
  end

  def freeze?
    !@active
  end

  def freeze!
    @active = false
  end
end