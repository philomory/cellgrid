class CellGrid
  class CellClass
    # Cells are structs with members based on the arguments to CellGrid.new,
    # with additional readers x, y and grid whose values are set
    # based on the arguments to Cell.new.
    def self.new(*args)
      cc = Struct.new(*args) do
        attr_reader :x, :y, :grid
        def initialize(x,y,grid)
          @x, @y, @grid = x, y, grid
        end

        def north
          return @grid[@x,@y-1]
        end
        def south
          return @grid[@x,@y+1]
        end
        def east
          return @grid[@x+1,@y]
        end
        def west
          return @grid[@x-1,@y]
        end

        alias_method :up,    :north
        alias_method :down,  :south
        alias_method :right, :east
        alias_method :left,  :west

      end
      return cc
    end
  end
end