module Enumerable
  def my_each
    return self.to_enum unless block_given?

    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    return self.to_enum unless block_given?

    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    return self.to_enum unless block_given?

    objs = Array.new
    self.my_each { |obj|
      objs.push(obj) if yield(obj)  }
    objs
  end

  def my_all?
    return self.my_all? { |obj| obj } unless block_given?

    self.my_each { |obj|
      return false unless yield(obj) }
    true
  end

  def my_any?
    return self.my_any? { |obj| obj } unless block_given?

    self.my_each { |obj|
      return true if yield(obj) }
    false
  end

  def my_none?
    return self.my_none? { |obj| obj } unless block_given?

    self.my_each { |obj|
      return false if yield(obj) }
    true
  end

  def my_count(item = nil)
    return self.length if item.nil? && !block_given?

    count = 0
    !item.nil? ?
        self.my_each { |obj| count += 1 if obj.equal? item } :
        self.my_each { |obj| count += 1 if yield(obj) }

    count
  end

  def my_map(proc = nil)
    if proc.is_a?(Proc)
      self.my_map { proc.call(self) }
    end

    return self.my_all? { |obj| obj } unless block_given?

    new_array = Array.new
    self.to_a.my_each { |obj| new_array.push yield(obj) }
    new_array
  end

  def my_inject(initial = nil, sym = nil)
    memo = 0

    if !initial.nil?
      if !sym.nil?
        memo = initial
        self.to_a.my_each { |obj| memo = obj.send sym, memo }

      elsif block_given?
        memo = initial
        self.to_a.my_each { |obj| memo = yield(memo, obj) }

      elsif initial.is_a?(Symbol)
        memo = self.to_a[0]
        for i in 1...self.to_a.length
          memo = self.to_a[i].send initial, memo
        end
      end

    elsif block_given?
      memo = self.to_a[0]
      for i in 1...self.to_a.length
        memo = yield(memo, self.to_a[i])
      end
   end

    memo
  end

end