class ASCII < String
  LIST = File.read('.ascii')

  def self.at(index)
    LIST[index]
  end
end