
def bubble_sort_by(array)
  n = array.size

  begin
  swapped = false

    (1..n-1).each { |i|
      if yield(array[i-1], array[i]) > 0
        array[i-1], array[i] = array[i], array[i-1]
        swapped = true
      end
    }

  end while swapped

  array
end

def bubble_sort(array)
  bubble_sort_by(array) { |first, second| first <=> second }
end



