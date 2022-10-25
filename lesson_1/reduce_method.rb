def reduce(array, starting_num=array[0])
  count = 0
  count = 1 if starting_num == array[0]
  accumalator = starting_num
  
  while count < array.size
    accumalator = yield(accumalator, array[count])
    count += 1
  end
  
  accumalator
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
# reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']
