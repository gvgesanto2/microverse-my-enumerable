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

  def max(n=nil, &block)
    n ? get_max_values(n, &block) : get_max_value(list, &block)      
  end

  private

  def get_max(list, &max_test)
    max = list[0]

    list.each do |element|  
      max = element if max_test.call(element, max)
    end
    max
  end

  def get_max_value(list)
    max_test = block_given? ? 
      lambda { |x, y| yield(x, y) == 1 } : 
      lambda { |x, y| x > y }

    get_max(list, &max_test)
  end

  def get_max_values(n, &block)
    tmp_list = list
    result = []

    n.times do
      max = get_max_value(tmp_list, &block)
      tmp_list.delete_at(tmp_list.find_index(max))
      result << max
    end
    result
  end
end