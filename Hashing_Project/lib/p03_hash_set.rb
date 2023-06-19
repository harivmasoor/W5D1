class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
	if !include?(key)
		@store[key.hash % num_buckets] << key
		@count += 1
	end
	resize! if @count == num_buckets
  end

  def include?(key)
	@store.each do |bucket|
		return true if bucket.include?(key)
	end
	false
  end

  def remove(key)
	if include?(key)
		index = @store[key.hash % num_buckets].index(key) 
		@store[key.hash % num_buckets].delete_at(index)
		@count -= 1 
	end
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