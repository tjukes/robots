class Robot
  CAPACITY = 250

  attr_reader :position, :items, :health, :attack_power
  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @attack_power = 5
  end

# Movement methods
  def move_left
    move(-1,0)
  end

  def move_right
    move(1,0)
  end

  def move_up
    move(0,1)
  end

  def move_down
    move(0,-1)
  end

# Item interaction methods, including weapon pick-up
  def pick_up(item)
    return false if items_weight + item.weight > CAPACITY
    @items << item
    # Equipping with weapon
    self.equipped_weapon = item if item.is_a? Weapon
    # Feeding on bolts
    item.feed(self) if self.health <= 80 && item.is_a?(BoxOfBolts)
    # Return value
    @items
  end

  def items_weight
    return 0 if @items == []
    @items.reduce(0) {|sum, item| sum += item.weight }
  end

  # Robot health methods
  def wound(health_points)
    @health - health_points < 0 ? @health = 0 : @health -= health_points
  end

  def heal(health_points)
    @health + health_points > 100 ? @health = 100 : @health += health_points
  end

  # Enhanced healing
  def heal!(health_points)
    raise DeadRobotError, "Too late - robot is already dead!" if @health <= 0
    self.heal(health_points)
  end

  # Attack
  def attack(foe)
    if equipped_weapon.is_a? Grenade
      return false unless foe_in_range?(foe, equipped_weapon.range)
      equipped_weapon.hit(foe)
      self.equipped_weapon = nil
    elsif equipped_weapon
      return false unless foe_in_range?(foe)
      equipped_weapon.hit(foe)
    elsif foe_in_range?(foe)
      foe.wound(attack_power)
    else
      false
    end
    # return false unless foe_in_range?(foe)
    # equipped_weapon ? equipped_weapon.hit(foe) : foe.wound(attack_power)
  end

  # Enhanced attack
  def attack!(foe)
    raise UnattackableFoeError, "Pick on a robot your own size!" unless foe.is_a? Robot
    attack(foe)
  end

  private
  def move(x,y)
    @position[0] += x
    @position[1] += y
  end

  def foe_in_range?(foe, range=1)
    x, y = self.position
    foe_x, foe_y = foe.position
    if foe_x == x
      # Current specs require "in range" to include foes at exactly the same position. Remove first conditions if that is no longer true.
      foe_y == y || foe_y == y + range || foe_y == y - range
    elsif foe_y == y
      foe_x == x || foe_x == x + range || foe_x == x - range
    else
      false
    end
  end
end
