class MaxIntSet

  attr_accessor :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    if num > max || num < 0
      raise "#{num} is out of bounds"
    end

    if include?(num)
      raise "#{num} is already in the set"
    else
       store[num] = true
    end
  end

  def remove(num)
    if include?(num)
      store[num] = false
      "#{num} has successfully been removed"
    else 
      raise "Num is not included in set!"
    end
  end

  def include?(num)
    store[num] 
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  # attr_reader :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    
   end

   def insert(num)
    if include?(num)
      raise "#{num} is already in the set"
    else
       self[num] << num
    end
  end

  def remove(num)
     if include?(num)
      self[num].delete(num)
      "#{num} has successfully been removed"
    else 
      raise "Num is not included in set!"
    end
  end

  def include?(num)
    self[num].include?(num)  
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets] 
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store, :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @store_copy = []
    @count = 0
  end

  def insert(num)
    if !include?(num)
      resize! if count == store.length - 1  
      self[num] << num
      @store_copy << num
      @count += 1
    else
     raise "#{num} is already in the set"
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @store_copy.delete(num)
      "#{num} has successfully been removed"
    else 
      raise "Num is not included in set!"
    end
  end

  def include?(num)
    self[num].include?(num)  
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # num_buckets.times { store << [] }
    @store = Array.new(num_buckets * 2) {Array.new}
    @store_copy.each { |el| store[el % num_buckets] << el }
  end
end
