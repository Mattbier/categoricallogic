class PremisePair
  def initialize(major, minor)
    @major = major
    @minor = minor
  end

  def getMajor
    @major
  end
  def getMinor
    @minor
  end
  def getMiddle
    termarray = [@major.getSubject, @major.getPredicate, @minor.getSubject, @minor.getPredicate]
    termarray.detect do |term|

      if termarray.count(term) > 1
        @middle = term
      end
    end
    return @middle
  end

  def getMajorTermFromMajorPremise
    if @major.getSubject == self.getMiddle
      majorterm = @major.getPredicate
    else
      majorterm = @major.getSubject
    end
    return majorterm
  end
  def getMinorTermFromMinorPreimse
    if @minor.getSubject == self.getMiddle
      minorterm = @minor.getPredicate
    else
      minorterm = @minor.getSubject
    end
    return minorterm
  end

  def getPossibleConclusions
    @possible_conclusions = [
        Proposition.new("universal", self.getMinorTermFromMinorPreimse, "affirmative", self.getMajorTermFromMajorPremise, "unknown"),
        Proposition.new("universal", self.getMinorTermFromMinorPreimse, "negative", self.getMajorTermFromMajorPremise, "unknown"),
        Proposition.new("particular", self.getMinorTermFromMinorPreimse, "affirmative", self.getMajorTermFromMajorPremise, "unknown"),
        Proposition.new("particular", self.getMinorTermFromMinorPreimse, "negative", self.getMajorTermFromMajorPremise, "unknown")
    ]
  end

end