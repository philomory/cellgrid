class CellGrid
  class MemberGrid
    attr_reader :grid, :member
    def initialize(grid,member)
      @grid, @member = grid, member
    end
    
    def [](x,y)
      @grid[x,y][@member]
    end
    
    def []=(x,y,value)
      @grid[x,y][@member] = value
    end
  end
end