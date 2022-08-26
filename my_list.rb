require_relative 'my_enumerable'

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

list_a = MyList.new(-2, 5, 6, 8, -1, 8, 8, 3)

p list_a.list

puts 'Testing .all?'
puts(list_a.all? { |e| e < 10 })
puts(list_a.all? { |e| e < 5 })
puts(list_a.all? { |_e| nil })

puts 'Testing .any?'
puts(list_a.any? { |e| e == -2 })
puts(list_a.any? { |e| e == 999 })

puts 'Testing filter'
p(list_a.filter(&:even?))
p(list_a.filter(&:odd?))
p(list_a.filter(&:negative?))

puts 'Testing max'
puts list_a.max
p(list_a.max(5))

list_b = MyList.new('albatross', 'dog', 'horse', 'eagle', 'buffalo')
puts(list_b.max { |a, b| a.length <=> b.length })
p(list_b.max(2) { |a, b| a.length <=> b.length })

puts 'Testing min'
puts(list_a.min)
p(list_a.min(5))

puts(list_b.min { |a, b| a.length <=> b.length })
p(list_b.min(2) { |a, b| a.length <=> b.length })
