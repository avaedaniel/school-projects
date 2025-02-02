  # Author: Ava Daniel
  # 6. Percentage: (a / b) * 100
  def percentage(a, b)
    raise ArgumentError, "Denominator (b) cannot be zero" if b == 0
    (a * 100) / b
  end
