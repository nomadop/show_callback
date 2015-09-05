class Wait < Behaviour::Base
  def initialize(timeout, *callback)
    super(*callback)
    @timeout = timeout
  end

  def update
    @first_call_at ||= Time.now
  end

  def finish?
    !@first_call_at.nil? && Time.now - @first_call_at > @timeout ? true : false
  end
end