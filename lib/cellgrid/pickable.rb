module CellGrid
  module Pickable
    
    def pick(count = nil,rng = lambda {|r=0| rand(r) }, &blk)
      set = self.each.select(&blk)
      if count.nil?
        picked = set[rng.call(set.length)]
      else
        ordered = set.sort_by {rng.call}
        picked = ordered.first(count)
      end
    end
    
  end
end