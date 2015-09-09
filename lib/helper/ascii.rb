class ASCII
  LIST = File.read('.ascii')

  def self.at(index)
    LIST[index]
  end
end