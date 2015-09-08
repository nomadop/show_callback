class ASCII < String
  LIST = File.read('.ascii')
  class << self
    def at(index)
      LIST[index]
    end
  end
end