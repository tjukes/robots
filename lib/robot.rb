class Robot
  CAPACITY = 250

  attr_reader :position, :items, :health, :attack_power

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @attack_power = 5
  end

# Movement methods
  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

# Item interaction methods
  def pick_up(item)
    @items << item if items_weight + item.weight <= CAPACITY
  end

  def items_weight
    weight = 0
    @items.each { |item| weight += item.weight}
    weight
  end

  # Robot health methods
  def wound(amount)
    @health - amount < 0 ? @health = 0 : @health -= amount
  end

  def heal(amount)
    @health + amount > 100 ? @health = 100 : @health += amount
  end

  # Attack
  def attack(foe)
    foe.wound(attack_power)
  end
end
