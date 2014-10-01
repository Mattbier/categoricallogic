class PropositionType
  def initialize(type, truthvalue=true)
    @type = type
    @truthvalue = truthvalue
  end
  def getType
    @type
  end

  def getQuantity
    if @type == "A"
      quantity = "universal"
    elsif @type == "E"
      quantity = "universal"
    elsif @type == "I"
      quantity = "particular"
    elsif @type == "O"
      quantity = "particular"
    else
      quantity = "not a valid type"
    end
    return quantity
  end
  def getQuality
    if @type == "A"
      quality = "affirmative"
    elsif @type == "E"
      quality = "negative"
    elsif @type == "I"
      quality = "affirmative"
    elsif @type == "O"
      quality = "negative"
    else
      quality = "not a valid type"
    end
    return quality
  end

  def getProposition
    proposition = Proposition.new(self.getQuantity, "S", self.getQuality, "P", @truthvalue)
    return proposition
  end
end