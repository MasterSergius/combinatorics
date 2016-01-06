module Itertools

  def Itertools.combination_iter(items, value_range)
    # Example:
    #
    # items = ["a", "b"], value_range = [1, 2]
    # combinations:
    # [{"a":1, "b":1}, {"a":2, "b":1}, {"a":1, "b":2}, {"a":2, "b":2}]

    combination = Hash[items.zip([value_range[0]] * items.length)]
    yield combination

    has_next_combination = true
    while has_next_combination
      next_combination = false
      index = 0
      while index < items.length and not next_combination
        cur_value = combination[items[index]] + 1
        if cur_value > value_range[1] then
          combination[items[index]] = value_range[0]
          index += 1
        elsif
          combination[items[index]] = cur_value
          next_combination = true
          yield combination
        end
      end
      has_next_combination = next_combination
    end
  end

  def Itertools.combination_with_total_sum(items, total)
    # Example:
    #
    # items = ["a", "b"], total_sum = 3
    # combinations:
    # [{"a":0, "b":3}, {"a":1, "b":2}, {"a":2, "b":1}, {"a":3, "b":0}]
    if items.length == 1 then
      return [{items[0] => total}]
    else
      result = []
      (0..total).each do |i|
        combination = {items[0] => i}
        sublist = combination_with_total_sum(items[1..-1], total-i)
        sublist.each do |item|
          combination.update(item)
          result.push(combination.clone)
        end
      end
      return result
    end
  end

  def Itertools.get_containers_combinations(containers, total)
    # Example:
    #
    # containers = [20, 15, 10, 5, 5], total = 25
    # result:
    # [15, 10]
    # [20, 5] (the first 5)
    # [20, 5] (the second 5)
    # [15, 5, 5]

    def Itertools.add_container(cntr_index, containers, current_sum, combinations)
      # Helper function to handle combinations
      #
      # Example:
      #
      # containers = [2, 3, 5] (indexes - 0, 1, 2)
      # possible combinations:
      #       {2 => [[0]], 3 => [[1]],
      #        5 => [[2], [0, 1]], 7 => [[0, 2]],
      #        8 => [[1, 2]], 10 => [[0,1,2]]}
      if not combinations.has_key? current_sum
        combinations[current_sum] = []
      end
      added = false
      if containers[cntr_index] == current_sum
        combinations[current_sum].push([cntr_index])
        added = true
      elsif
        # find all combinations to which we can add this container
        avail = combinations[current_sum - containers[cntr_index]]
        avail.each do |comb| # each combination is type of Array
          if not comb.member? cntr_index
            new_combination = comb.clone.push(cntr_index)
            # check for possible duplicates
            dup = false
            combinations[current_sum].each do |item|
              if item.sort == new_combination.sort
                dup = true
              end
            end
            if not dup
              combinations[current_sum].push(new_combination)
            end
            added = true # even if dup, because it already has this
          end
        end # avail.each
      end
      added
    end # add_container

    biggest = containers.max
    sums = [false] * (total + 1)
    combinations = {}
    (1..total).each do |current_sum|
      containers.each_index do |i|
        if containers[i] == current_sum then
          sums[current_sum] = true
          add_container(i, containers, current_sum, combinations)
        elsif containers[i] < current_sum and
              sums[current_sum - containers[i]] then
          added = add_container(i, containers, current_sum, combinations)
          sums[current_sum] = added
        end
      end
      # remove no longer useful combinations to save resources
      (1..current_sum - biggest).each do |to_remove|
        combinations.delete(to_remove)
      end
    end
    # build result, because combinations stores containers by indexes
    result = []
    combinations[total].each do |comb|
      result.push(comb.map { |i| containers[i] })
    end
    result
  end

end

__END__
