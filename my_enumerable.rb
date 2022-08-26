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

  def max(num = nil, &block)
    num ? get_max_values(num, &block) : get_max_value(list, &block)
  end

  def min(num = nil, &block)
    num ? get_min_values(num, &block) : get_min_value(list, &block)
  end

  private

  def get_max_value(list)
    max_test = if block_given?
                 ->(x, y) { yield(x, y) == 1 }
               else
                 ->(x, y) { x > y }
               end

    get_min_max(list, &max_test)
  end

  def get_min_value(list)
    min_test = if block_given?
                 ->(x, y) { yield(x, y) == -1 }
               else
                 ->(x, y) { x < y }
               end

    get_min_max(list, &min_test)
  end

  def get_max_values(num, &block)
    get_min_max_values(num, method(:get_max_value), &block)
  end

  def get_min_values(num, &block)
    get_min_max_values(num, method(:get_min_value), &block)
  end

  def get_min_max(list, &min_max_test)
    min_max = list[0]

    list.each do |element|
      min_max = element if min_max_test.call(element, min_max)
    end
    min_max
  end

  def get_min_max_values(num, min_max_func, &block)
    tmp_list = list.clone
    result = []

    num.times do
      min_max = min_max_func.call(tmp_list, &block)
      tmp_list.delete_at(tmp_list.find_index(min_max))
      result << min_max
    end
    result
  end
end
