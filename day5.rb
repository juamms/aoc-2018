require_relative 'common'

data = get_data(5).strip

def mix_case_match?(char1, char2)
  (char1.casecmp? char2) && (char1.ord - char2.ord).abs == 32
end

def process_polymer(data)
  pointer = 0
  while pointer < data.length - 1
    if mix_case_match? data[pointer], data[pointer + 1]
      2.times { data.slice! pointer }
      pointer = [pointer - 1, 0].max
    else
      pointer += 1
    end
  end

  data.length
end

def find_shortest_polymer(data)
  min_length = data.length

  ('a'..'z').each do |c|
    temp = data.gsub(/[#{c}#{c.upcase}]/, '')
    length = process_polymer temp

    min_length = [length, min_length].min
  end

  min_length
end

puts "After reacting, polymer contains #{process_polymer data} units"
puts "The shortest polymer contains #{find_shortest_polymer data} units"
