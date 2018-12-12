require_relative 'common'
require 'matrix'

data = 5535

def calculate_power_level(x, y, serial_number)
  rack_id = x + 10
  power_level = rack_id * y
  power_level += serial_number
  power_level *= rack_id
  power_level = power_level / 100 % 10

  power_level - 5
end

def build_power_grid(data)
  grid = Matrix.build(300) { 0 }

  300.times do |x|
    300.times do |y|
      grid[x, y] = calculate_power_level x + 1, y + 1, data
    end
  end

  grid
end

class Matrix
  def get_power(x_start, y_start, size = 3)
    power = 0

    size.times do |x_offset|
      size.times do |y_offset|
        power += self[x_start + x_offset, y_start + y_offset]
      end
    end

    power
  end
end

def find_max_power(grid)
  x_pos = 0, y_pos = 0, max_power = 0

  297.times do |x|
    297.times do |y|
      power = grid.get_power(x, y)
      next unless power > max_power

      x_pos = x + 1
      y_pos = y + 1
      max_power = power
    end
  end

  [x_pos, y_pos]
end

def find_max_power_no_size(grid)
  x_pos = 0, y_pos = 0, max_size = 0, max_power = 0

  # Since the max size is found at size 11,
  # we'll only do this loop 15 times for
  # completion's sake. 🙂
  15.times do |size|
    (300 - size).times do |x|
      (300 - size).times do |y|
        power = grid.get_power(x, y, size)
        next unless power > max_power

        x_pos = x + 1
        y_pos = y + 1
        max_power = power
        max_size = size
      end
    end
  end

  [x_pos, y_pos, max_size]
end

grid = build_power_grid data

x, y = find_max_power grid
puts "The max power starts at #{x},#{y}"

x, y, size = find_max_power_no_size grid
puts "The max power without size limit starts at #{x},#{y} at size #{size}"
