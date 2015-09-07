require 'gosu'
require 'require_all'

require_all './'

Kernel.module_eval do
  def method_missing(method, *args, &block)
    CallbackFactory.respond_to?(method) ? CallbackFactory.send(method, *args, &block) : super
  end
end

CallbackWorld.initialize

begin
  World.show
rescue Exception => e
  error = "inspect: #{e.inspect}, backtrace: #{e.backtrace}"
  puts error
end

