class FigureType
  def initialize(figure)
    @figure = figure
  end
  def getType
    @figure
  end

  def getMajorSubject
    if @figure == 1 || @figure == 3
      subject = "M"

    elsif @figure == 2 || @figure == 4
      subject = "P"

    end
    return subject
  end

  def getMajorPredicate
    if @figure == 1 || @figure == 3
      predicate = "P"
    elsif @figure == 2 || @figure == 4
      predicate = "M"
    end
    return predicate
  end
  def getMinorSubject
    if @figure == 1 || @figure == 2
      subject = "S"

    elsif @figure == 3 || @figure == 4
      subject = "M"

    end
    return subject
  end
  def getMinorPredicate
    if @figure == 1 || @figure == 2
      predicate = "M"
    elsif @figure == 3 || @figure == 4
      predicate = "S"
    end
    return predicate
  end
end