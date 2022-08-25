require_relative 'my-enumerable'

class MyList
  include MyEnumerable
  attr_reader :list

  def initialize(*list)
    @list = list
  end

  def my_each(&block)
    @list.each(&block)
  end
end

a = MyList.new(2, -5, 6, 8, 3, 8)

p a.list

puts "Testing .all?"
puts a.all? {|e| e < 10}
puts a.all? {|e| e < 5}
puts a.all? {|e| nil }

puts "Testing .any?"
puts a.any? {|e| e == 2}
puts a.any? {|e| e == 999}

puts "Testing filter"
p a.filter {|e| e.even?}
p a.filter {|e| e.odd?}
