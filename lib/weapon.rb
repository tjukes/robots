class Weapon < Item
  attr_reader :damage, :range

  def initialize(name, weight, damage)
    super(name, weight)
    @damage = damage
    @range = 1
  end

  def hit(foe)
    foe.wound(damage)
  end
end
