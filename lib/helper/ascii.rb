module ASCII
  LIST = File.read('.ascii')

  module_function

  def at(index)
    LIST[index]
  end
end