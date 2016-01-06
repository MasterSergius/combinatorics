require '../itertools'


def test_combination_iter
  input_items = ["a", "b", "c"]
  input_range = [1, 3]
  output = [{"a"=>1, "b"=>1, "c"=>1},
            {"a"=>2, "b"=>1, "c"=>1},
            {"a"=>3, "b"=>1, "c"=>1},
            {"a"=>1, "b"=>2, "c"=>1},
            {"a"=>2, "b"=>2, "c"=>1},
            {"a"=>3, "b"=>2, "c"=>1},
            {"a"=>1, "b"=>3, "c"=>1},
            {"a"=>2, "b"=>3, "c"=>1},
            {"a"=>3, "b"=>3, "c"=>1},
            {"a"=>1, "b"=>1, "c"=>2},
            {"a"=>2, "b"=>1, "c"=>2},
            {"a"=>3, "b"=>1, "c"=>2},
            {"a"=>1, "b"=>2, "c"=>2},
            {"a"=>2, "b"=>2, "c"=>2},
            {"a"=>3, "b"=>2, "c"=>2},
            {"a"=>1, "b"=>3, "c"=>2},
            {"a"=>2, "b"=>3, "c"=>2},
            {"a"=>3, "b"=>3, "c"=>2},
            {"a"=>1, "b"=>1, "c"=>3},
            {"a"=>2, "b"=>1, "c"=>3},
            {"a"=>3, "b"=>1, "c"=>3},
            {"a"=>1, "b"=>2, "c"=>3},
            {"a"=>2, "b"=>2, "c"=>3},
            {"a"=>3, "b"=>2, "c"=>3},
            {"a"=>1, "b"=>3, "c"=>3},
            {"a"=>2, "b"=>3, "c"=>3},
            {"a"=>3, "b"=>3, "c"=>3}]

  result = []
  Itertools.combination_iter(["a", "b", "c"], [1, 3]) do |combination|
      result.push(combination.clone)
  end
  puts "Test combination_iter: #{output == result ? 'passed' : 'failed'}"
end

def test_combination_with_total_sum
  input_items = ["a", "b", "c"]
  input_total = 5
  output = [{"a"=>0, "b"=>0, "c"=>5},
            {"a"=>0, "b"=>1, "c"=>4},
            {"a"=>0, "b"=>2, "c"=>3},
            {"a"=>0, "b"=>3, "c"=>2},
            {"a"=>0, "b"=>4, "c"=>1},
            {"a"=>0, "b"=>5, "c"=>0},
            {"a"=>1, "b"=>0, "c"=>4},
            {"a"=>1, "b"=>1, "c"=>3},
            {"a"=>1, "b"=>2, "c"=>2},
            {"a"=>1, "b"=>3, "c"=>1},
            {"a"=>1, "b"=>4, "c"=>0},
            {"a"=>2, "b"=>0, "c"=>3},
            {"a"=>2, "b"=>1, "c"=>2},
            {"a"=>2, "b"=>2, "c"=>1},
            {"a"=>2, "b"=>3, "c"=>0},
            {"a"=>3, "b"=>0, "c"=>2},
            {"a"=>3, "b"=>1, "c"=>1},
            {"a"=>3, "b"=>2, "c"=>0},
            {"a"=>4, "b"=>0, "c"=>1},
            {"a"=>4, "b"=>1, "c"=>0},
            {"a"=>5, "b"=>0, "c"=>0}]

  result = Itertools.combination_with_total_sum(["a", "b", "c"], 5)

  puts "Test combination_with_total_sum: #{output == result ? 'passed' : 'failed'}"
end

def test_containers_combinations
  containers = [3, 4, 20, 12, 8, 6, 7]
  total = 20
  result = [[7, 6, 4, 3], [20], [8, 12]]

  output = Itertools.get_containers_combinations(containers, total)
  puts "Test get_containers_combinations: #{output.sort == result.sort ? 'passed' : 'failed'}"
end


def run_tests
  test_combination_iter
  test_combination_with_total_sum
  test_containers_combinations
end

run_tests
