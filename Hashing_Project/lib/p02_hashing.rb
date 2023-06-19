class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    arr = []
    self.each_with_index do |el, i|
      arr << (el.hash*i)
    end
    return arr.sum
  end
end

class String
  def hash
    num = 0
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    self.each_char.with_index do |char, i|
      num += char.ord.hash * i * alphabet.index(char.downcase)
    end
    num
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    array = []
    self.each do |k,v|
      array << v.ord.hash
    end
    array.sum
  end
end