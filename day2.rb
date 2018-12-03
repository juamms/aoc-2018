require_relative 'common'

data = get_data(2).split "\n"

def process_single_hash(ids)
  result = {}

  ids.each_char do |c|
    if result.key? c
      result[c] += 1
    else
      result[c] = 1
    end
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

puts "The checksum is #{multiple_checksum data}"