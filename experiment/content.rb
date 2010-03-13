module CellGrid
  # The CellGrid::Content class is a starting point for representations of
  # anything that resides in a Cell. It is intended to be used as a parent
  # class for a heirarchy of Cell content classes, though it's use is not
  # mandatory. For example,
  #
  # class DungeonCell < CellGrid::Cell
  #   has_one  :terrain, :occupant
  #   has_many :items
  # end
  #
  # class Occupant < CellGrid::Content
  #   fills :occupant, DungeonCell
  # end
  #
  # class Player < Occupant; end
  # class Monster < Occupant; end
  # class Boss < Monster; end
  # class NPC < Occupant; end
  # ...etc...
  class Content
    class << self
      attr_reader :slot, :cell_class
    end
    def self.fills(slot,cell_class)
      @slot, @cell_class = slot, cell_class
    end
  end
end