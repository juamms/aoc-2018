def get_data(day)
  File.read("./data/#{day}.txt")
end

class Array
  def circular_get(pos)
    self[pos % length]
  end
end
