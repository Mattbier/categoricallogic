class Form
  def initialize(majorType, minorType, conclusionType, figureType)
    @majorType = majorType
    @minorType = minorType
    @conclusionType = conclusionType
    @mood = "#{@majorType.getType}#{@minorType.getType}#{@conclusionType.getType}"
    @figureType = figureType
    @form = "#{@mood}#{@figureType.getType}"
  end


  def getFormSyllogism
    #don't need these but good for checking accuracy
    majorA1 = Proposition.new("universal", "P", "affirmative", "M", true)
    majorA2 = Proposition.new("universal", "M", "affirmative", "P", true)
    majorE1 = Proposition.new("universal", "P", "negative", "M", true)
    majorE2 = Proposition.new("universal", "M", "negative", "P", true)
    majorI1 = Proposition.new("particular", "P", "affirmative", "M", true)
    majorI1 = Proposition.new("particular", "M", "affirmative", "P", true)
    majorO1 = Proposition.new("particular", "P", "negative", "M", true)
    majorO2 = Proposition.new("particular", "M", "negative", "P", true)

    minorA1 = Proposition.new("universal", "S", "affirmative", "M", true)
    minorA2 = Proposition.new("universal", "M", "affirmative", "S", true)
    minorE1 = Proposition.new("universal", "S", "negative", "M", true)
    minorE2 = Proposition.new("universal", "M", "negative", "S", true)
    minorI1 = Proposition.new("particular", "S", "affirmative", "M", true)
    minorI1 = Proposition.new("particular", "M", "affirmative", "S", true)
    minorO1 = Proposition.new("particular", "S", "negative", "M", true)
    minorO2 = Proposition.new("particular", "M", "negative", "S", true)

    conclusionA = Proposition.new("universal", "S", "affirmative", "P", true)
    conclusionE = Proposition.new("universal", "S", "negative", "P", true)
    conclusionI = Proposition.new("particular", "S", "affirmative", "P", true)
    conclusionO1 = Proposition.new("particular", "S", "negative", "P", true)

    majorProposition = Proposition.new(@majorType.getQuantity, @figureType.getMajorSubject, @majorType.getQuality, @figureType.getMajorPredicate, true)
    minorProposition = Proposition.new(@minorType.getQuantity, @figureType.getMinorSubject, @minorType.getQuality, @figureType.getMinorPredicate, true)

    conclusion = Proposition.new(@conclusionType.getQuantity, "S", @conclusionType.getQuality, "P", true)
    syllogism = Syllogism.new(majorProposition, minorProposition, conclusion)


  end

  def getValidity
    syllogism = self.getFormSyllogism
    syllogism.getValidity
  end

  def displayValidity
    syllogism = self.getFormSyllogism
    syllogism.displayValidity
  end
  def displayPropositionalForm
    syllogism = self.getFormSyllogism
    syllogism.displaySyllogism
  end
  def getForm
    @form
  end
  def displayForm
    puts "#{@form}"
  end
end