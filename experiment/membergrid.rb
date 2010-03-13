# This class is not used at the moment. It was used, but was removed
# during refactoring. It aims to provide sugar like this:
#
# grid.foo.each {|foo| # do stuff with foo}
#
# as sugar for
#
# grid.each {|cell| # do stuff with cell.foo }
#
# I was advised to save sugar for later. This can be safely removed
# during code clean up if this sugar is decided against.

module CellGrid
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