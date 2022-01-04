class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @max = max
    @store = Array.new(max+1, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true  
  end

  def remove(num)
    @store[num] = false if @store[num]
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num > 0 && num < @max
  end

  def validate!(num)
    raise "Out of bounds" if !is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self[num].include?(num)  
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self[num].include?(num)
      self[num] << num 
      @count += 1
    end 
    resize! if num_buckets < self.count
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2){ Array.new }
    old_store.flatten.each{ |el| insert(el) }
  end
end
