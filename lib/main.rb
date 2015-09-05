require 'gosu'
require 'require_all'

$keybinds = []
require_all './'

CallbackWorld.initialize

begin
  World.show
rescue Exception => e
  error = "inspect: #{e.inspect}, backtrace: #{e.backtrace}"
  puts error
end

