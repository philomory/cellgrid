# Intended usage after creating you RogueMap::Grid and RogueMap::Cell classes:
@map = RogueMap::Grid.new(30,30) do |cell|
  cell.terrain = Wall.new(cell)
end

# Some code which carves out walls would go here, but it not included in the
# example.

# Now, place the player.
start_cell = @map.pick {|cell| cell.traversable? } # Picks a random traversable cell
@player = Player.new(start_cell) # Player inherits from Occupant, about which we will learn later.

# Let's make some monsters! @map.pick(10) randomly selects 10 cells where the block returns true. 
@map.pick(10) {|cell| cell.traversable? && !cell.occupant }.each {|cell| Monster.new(cell) }

# Are there any monsters near the player? Within five squares, say?
monsters = @map.around(@player,5).occupant.to_a.compact


# So that's the intended usage. But what about that RogueMap::Grid class?
# And what about those cells? How are they made?
#
# I have three possible idioms for creating the RogueMap::Grid and
# RogueMap::Cell class using CellGrid. These are:

# Style one (Arguments based, aka 'Structy')
RogueMap = CellGrid.new(:terrain,:occupant,:lighting,:many => :items)
RogueMap::Grid.wrap_at_edges = false


# Style two (Block based)
RogueMap = CellGrid.new do |cell,grid|
  cell.has_one :terrain, :occupant, :lighting
  cell.has_many :items
  grid.wrap_at_edges = false
end


# Style three (Inheritance + declarative aka 'Railsy')
class RogueMap::Cell < CellGrid::Cell
  has_one :terrain, :occupant, :lighting
  has_many :items
end

class RogueMap::Grid < CellGrid::Grid
  composed_of RogueMap::Cell
  self.wrap_at_edges = false
end


# Classes such as Occupant will be associated with a particular 'slot' in a
# map cell, like those we declared, occupant, terrain, items, etc. They will
# have a number of useful methods provided for them to do things such as move
# them around the map.
#
# We have a few idioms for producing these classes:

# Style one: Class, argument and block (New Structy)
Occupant = RogueMap::Content.new(:occupant) do
  #...
end

# Style two: Inherit from class with argument (old Structy)
class Occupant < RogueMap::Content.new(:occupant)
  #...
end

# Style three: Inherit from Constant-looking Method Call (Delegatory)
class Occupant < RogueMap::Content(:occupant)
  #...
end

# Style four: Inherit + declarative (Railsy)
class Occupant < CellGrid::Content
  fills RogueMap::Cell, :occupant
  #...
end  

