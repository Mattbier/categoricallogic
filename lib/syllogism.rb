class Syllogism

  def initialize(major, minor, conclusion=nil)
    @major = major
    @minor = minor
    if conclusion == nil
      @conclusion = self.getComputedConclusion
    else
      @conclusion = conclusion
    end
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
  def getConclusion
    @conclusion
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


  def getMood
    @mood = "#{@major.getType}#{@minor.getType}#{@conclusion.getType}"
    return @mood
  end

  def getFigure
    mjmp = @major.getPosition(self.getMiddle)
    mnmp = @minor.getPosition(self.getMiddle)

    if mjmp == "subject" && mnmp == "predicate"
      @figure = 1
    elsif mjmp == "predicate" && mnmp == "predicate"
      @figure = 2
    elsif mjmp == 	"subject" && mnmp == "subject"
      @figure = 3
    elsif mjmp == "predicate" && mnmp == "subject"
      @figure = 4
    end
  end


  def getForm
    @form = "#{self.getMood}#{self.getFigure}"
  end

  def displayForm
    puts self.getForm
  end

  def displayPropositionalForm
    form = Form.new(PropositionType.new(@major.getType), PropositionType.new(@minor.getType), PropositionType.new(@conclusion.getType), FigureType.new(self.getFigure))
    form.displayPropositionalForm
  end

  def test1
    ## Rule Number 1 - middle distributed
    if @major.getDistribution(@major.getPosition(self.getMiddle)) == 'undistributed' && @minor.getDistribution(@minor.getPosition(self.getMiddle)) == 'undistributed'
      validity = "invalid (1, undistributed Middle)"
    else
      validity = "pass"
    end
  end
  def test2a
    ##Rule Number 2a distribution of major term
    if @conclusion.getDistribution("predicate") == 'distributed' && @major.getDistribution(@major.getPosition(self.getMajorTermFromMajorPremise)) != 'distributed'
      validity = "invalid (2a, illicit major)"
    else
      validity = "pass"
    end
  end
  def test2b
    ##Rule Number 2b distribution of minor term - check fallacy of illicit minor
    if @conclusion.getDistribution("subject") == 'distributed' && @minor.getDistribution(@minor.getPosition(self.getMinorTermFromMinorPreimse)) != 'distributed'
      validity = "invalid (2b, illicit minor)"
    else
      validty = "pass"
    end
  end
  # exclusive premises
  def test3
    if @major.getQuality == 'negative' && @minor.getQuality == "negative"
      validity = "invalid (3, Exclusive Premises)"
    else
      validity = "pass"
    end
  end

  def test4a
    if (@major.getQuality == 'negative' || @minor.getQuality == 'negative') && @conclusion.getQuality != 'negative'
      validity = "invalid (4a, affirmative conclusion from a negative premise)"
    else
      validity = "pass"
    end
  end

  def test4b
    if (@conclusion.getQuality == 'negative' && (@major.getQuality != 'negative' && @minor.getQuality != 'negative'))

      validity = "invalid (4b) Negative conclusion from affirmative premises"
      #validity = "pass"
    else
      validity = "pass"
    end
  end


  def getValidity
    if (self.test1 != "pass" || self.test2a != "pass" || self.test2b != "pass" || self.test3 != "pass" || self.test4a != "pass" || self.test4b != "pass")
      validity = "invalid"
    else
      validity = "valid"
    end
  end

  def displayValidity
    puts self.test1
    puts self.test2a
    puts self.test2b
    puts self.test3
    puts self.test4a
    print self.test4b
  end

  def displaySyllogism
    @major.displayProposition
    @minor.displayProposition
    @conclusion.displayProposition
  end
end