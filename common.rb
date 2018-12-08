require 'matrix'

def get_data(day)
  File.read("./data/#{day}.txt")
end

class Array
  def circular_get(pos)
    self[pos % length]
  end
end

class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end

  def to_s(cell_padding = 4)
    i = 0
    str = ''
    each do |number|
      str << number.to_s.rjust(cell_padding, ' ') + ' '
      i += 1
      if i == column_size
        str << "\n"
        i = 0
      end
    end

    str
  end
end
