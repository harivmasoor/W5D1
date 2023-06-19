class MaxIntSet
  attr_reader :store
  def initialize(max)
    @max = max
    @store = Array.new(@max, false)
  end

  def insert(num)
    raise "Out of bounds" if !is_valid?(num)
    @store[num] = true if !include?(num)
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num >= 0 && num <= @store.length
  end

  def validate!(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num
  end

  def remove(num)
    index = @store[num % num_buckets].index(num)
    @store[num % num_buckets].delete_at(index)
  end

  def include?(num)
    @store.any? do |bucket|
      bucket.include?(num)
    end
  end

  private

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
	if !include?(num) && @count < num_buckets
		@store[num % num_buckets] << num 
		@count += 1
	end
	resize! if @count == num_buckets
  end

  def remove(num)
	if include?(num)
		index = @store[num % num_buckets].index(num)
    	@store[num % num_buckets].delete_at(index)
		@count -= 1
	end
  end

  def include?(num)
	@store.each do |bucket|
		return true if bucket.include?(num)
	end
	false
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
	if num_buckets == @count
		prev_elements = []
		@store.each do |bucket|
			prev_elements += bucket
		end
		
		@store = Array.new(num_buckets * 2) { Array.new }

		prev_elements.each do |num|
			@store[num % (num_buckets * 2)] << num
		end
	end
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end
end