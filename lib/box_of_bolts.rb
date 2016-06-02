class BoxOfBolts < Item
  def initialize
    super("Box of bolts", 25)
  end

  def feed(friend)
    friend.heal(20)
  end
end
