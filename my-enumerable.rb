module MyEnumerable
  def all?
    if block_given?
      my_each { |element| return false unless yield(element) } 
      true
    else
      all? { |obj| obj }
    end
  end

  def any?
    if block_given?
      my_each { |element| return true if yield(element) } 
      false
    else
      any? { |obj| obj }
    end
  end

  def filter
    if block_given?
      result = []
      my_each { |element| result << element if yield(element) } 
      result
    else
      self
    end
  end
end