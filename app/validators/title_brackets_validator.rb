class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    if record.title.match?(/\(\)/) || counter_odd?(record.title) || !balanced?(record.title)
      record.errors.add :base, "not valid"
    end
  end

  private

  def counter_odd?(string)
    counter = 0
    string.each_char do |char|
      counter += 1 if [")", "("].include? char
    end
    counter.odd?
  end

  def balanced?(string)
    stack = ["$"]
    string.each_char do |symbol|
      stack.push symbol if opener? symbol
      if closer? symbol
        stack.pop if closes? stack.last, symbol
        next
      end
    end
    return true if stack == ["$"]
    false
  end

  def opener?(symbol)
    ["(", "[", "{"].include? symbol
  end

  def closer?(symbol)
    [")", "]", "}"].include? symbol
  end

  def closes?(opener, closer)
    return true if check_opener_and_closer "(", ")", opener, closer
    return true if check_opener_and_closer "[", "]", opener, closer
    return true if check_opener_and_closer "{", "}", opener, closer
    false
  end

  def check_opener_and_closer(bracket1, bracket2, opener, closer)
    return true if opener == bracket1 && closer == bracket2
  end
end
