#!/urs/env/bin ruby
require_relative 'common'

data = get_data(1).split("\n").map(&:to_i)

def apply_changes_to_frequency(data)
  data.sum
end

def find_frequency_twice(data)
  frequencies = [0]

  pos = 0
  cur_freq = 0
  loop do
    cur_freq += data.circular_get(pos)

    return cur_freq if frequencies.include?(cur_freq)

    frequencies << cur_freq
    pos += 1
  end
end

puts "Frequency after changes: #{apply_changes_to_frequency data}"
puts "Frequency found twice: #{find_frequency_twice data}"
