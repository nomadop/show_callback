class Wait < Behaviour::Base
  def initialize(timeout)
    super()
    @timeout = timeout
  end

  def action
    @first_call_at ||= Time.now
  end

  def finish?
    !@first_call_at.nil? && Time.now - @first_call_at > @timeout ? true : false
  end
end