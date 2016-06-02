class Robot
  CAPACITY = 250

  attr_reader :position, :items

  def initialize
    @position = [0,0]
    @items = []
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

end
