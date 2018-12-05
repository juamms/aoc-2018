require_relative 'common'

data = get_data(2).split "\n"

def process_single_hash(ids)
  result = {}

  ids.each_char do |c|
    result.key?(c) ? result[c] += 1 : result[c] = 1
  end
  { has_duplicates: result.value?(2), has_triplicates: result.value?(3) }
end

def multiple_checksum(data)
  duplicates = 0
  triplicates = 0
  processor = method :process_single_hash

  data.map(&processor).each do |result|
    result[:has_duplicates] && duplicates += 1
    result[:has_triplicates] && triplicates += 1
  end

  duplicates * triplicates
end

def correct_id_matches(data)
  data.combination(2) do |str1, str2|
    diff = []
    str1.each_char.with_index do |char, index|
      break if diff.length > 1

      char != str2[index] && diff << index
    end

    if diff.length == 1
      str1.slice! diff.first

      return str1
    end
  end
end

puts "The checksum is: #{multiple_checksum data}"
puts "The matching letters for the correct ID are: #{correct_id_matches data}"