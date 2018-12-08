require_relative 'common'
require 'matrix'

class Claim
  def initialize(raw_data)
    data = raw_data.gsub!(/[#@:]/, '').split(' ')

    @id = data.first
    @left_start, @top_start = data[1].split(',').map(&:to_i)
    @width, @height = data[2].split('x').map(&:to_i)
  end

  attr_accessor :id
  attr_accessor :left_start
  attr_accessor :top_start
  attr_accessor :width
  attr_accessor :height
end

data = get_data(3).split("\n").map { |str| Claim.new(str) }

def overlapping_fabric(data)
  matrix = Matrix.build(1000) { '.' }

  data.each do |claim|
    x = claim.left_start
    y = claim.top_start

    claim.width.times do |offset_x|
      xx = x + offset_x

      claim.height.times do |offset_y|
        yy = y + offset_y
        val = matrix[xx, yy] == '.' ? claim.id : 'X'
        matrix[xx, yy] = val
      end
    end
  end

  # Uncomment the next line if you want to save the resulting matrix to a txt file
  # File.write('./out.txt', matrix.to_s)
  matrix.map { |val| val == 'X' ? 1 : 0 }.sum
end

puts "There are #{overlapping_fabric data} inches of overlapping fabric"