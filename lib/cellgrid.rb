class CellGrid
  def self.new(*args)
    mod = Module.new
    mod.const_set(:Cell,self.cell_class(*args))
    mod.const_set(:Grid,Class.new)
    return mod
  end
  
  protected
  
  def self.cell_class(*args)
    puts args.inspect
    cell = Struct.new(*args) do
      attr_reader :x, :y, :grid
      def initialize(x,y,grid)
        @x, @y, @grid = x, y, grid
      end
    end
    return cell
  end
  
  
end