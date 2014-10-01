class Proposition

  def initialize(quantity, subject, quality, predicate, truthvalue)
    @quantity=quantity
    @subject=subject
    @quality=quality
    @predicate=predicate
    @truthvalue=truthvalue
  end

  def getType
    if @quantity == 'universal' && @quality == 'affirmative'
      @type="A"
    elsif @quantity == 'universal' && @quality == 'negative'
      @type="E"
    elsif @quantity == 'particular' && @quality == 'affirmative'
      @type="I"
    elsif @quantity == 'particular' && @quality == 'negative'
      @type="O"
    end
    return @type
  end

  def getTruthValue
    @truthvalue
  end
  def getSubject
    @subject
  end
  def getPredicate
    @predicate
  end

  def getQuantity
    @quantity
  end
  def getOppositeQuality
    if @quality == "affirmative"
      quality = "negative"
    elsif @quality == "negative"
      quality = "affirmative"
    end
    return quality
  end
  def getOppositeQuantity
    if @quantity == "universal"
      quantity = "particular"
    elsif @quantity == "particular"
      quantity = "univeral"
    end
    return quantity
  end
  def getQuality
    @quality
  end
  def getContradictory

    quantity = self.getOppositeQuantity
    quality = self.getOppositeQuality

    @contradictory = Proposition.new(quantity, @subject, quality, @predicate, !@truthvalue)
    return @contradictory
  end

  def getSubaltern
    if @quantity == "universal"
      quantity = "particular"
      if @truthvalue
        truthvalue = @truthvalue
      elsif !@truthvalue
        truthvalue = "unknown"
      end
    elsif @quantity == "particular"
      quantity = "univeral"
      if !@truthvalue
        truthvalue = !@truthvalue
      elsif @truthvalue
        truthvalue = "unknown"
      end
    end

    @subaltern = Proposition.new(quantity, @subject, @quality, @predicate, truthvalue)
    return @subaltern
  end

  def getContrary
    if @quantity  == "particular"
      abort("There is no contrary for this type of propostion. Try subcontrary")

    end

    quality = self.getOppositeQuality

    if @truthvalue
      truthvalue = !@truthvalue
    elsif !@truthvalue
      truthvalue = "unknown"
    end

    @contrary = Proposition.new(@quantity, @subject, quality, @predicate, truthvalue)
    return @contrary
  end

  def getSubcontrary
    if @quantity  == "universal"
      abort("There is no subcontrary for this type of propostion. Try contrary.")
    end

    quality = self.getOppositeQuality

    if !@truthvalue
      truthvalue = !@truthvalue
    elsif @truthvalue
      truthvalue = "unknown"
    end

    @subcontrary = Proposition.new(@quantity, @subject, quality, @predicate, truthvalue)
    return @subcontrary
  end

  def getConverse
    if self.getType == "A" || self.getType == "O"
      truthvalue = "unknown"
    else
      truthvalue = @truthvalue
    end
    @converse = Proposition.new(@quantity, @predicate, @quality, @subject, truthvalue)
  end

  def getObverse
    quality = self.getOppositeQuality

    predicate = "non-#{@predicate}"
    @obverse = Proposition.new(@quantity, @subject, quality, predicate, @truthvalue)
  end

  def getContrapolated
    if self.getType == "E" || self.getType == "I"
      truthvalue = "unknown"
    else
      truthvalue = @truthvalue
    end
    subject = "non-#{@subject}"
    predicate = "non-#{@predicate}"
    @contrapolated = Proposition.new(@quantity, predicate, @quality, subject, truthvalue)

  end

  def getDistribution(term)
    if term == 'subject'
      if @quantity == "universal"
        @distribution = "distributed"
      elsif @quantity == "particular"
        @distribution = "undistributed"
      end
    elsif term == "predicate"
      if @quality == "affirmative"
        @distribution = "undistributed"
      elsif @quality == "negative"
        @distribution = "distributed"
      end
    end
    return @distribution
  end

  def getPosition(term)
    if self.getSubject == term
      @middlePosition = "subject"
    elsif self.getPredicate == term
      @middlePosition = "predicate"
    end
  end

  def displayKnownTruthValues

    contradictory = self.getContradictory
    if @quantity == "universal"
      contrary_subcontrary = self.getContrary
    elsif @quantity == "particular"
      contrary_subcontrary = self.getSubcontrary
    end
    subaltern = self.getSubaltern

    puts "contradictory = #{contradictory.getType}: #{contradictory.getTruthValue}"
    puts "contrary/subcontrary = #{contrary_subcontrary.getType}: #{contrary_subcontrary.getTruthValue}"
    puts "subaltern = #{subaltern.getType}: #{subaltern.getTruthValue}"
    puts "converse = #{self.getConverse.getType}: #{self.getConverse.getTruthValue}"
    puts "obverse = #{self.getObverse.getType}: #{self.getObverse.getTruthValue}"
    puts "contrapolated = #{self.getContrapolated.getType}: #{self.getContrapolated.getTruthValue}"
  end

  def isUnique?(set)

    set.each do |proposition|
      if (proposition.getQuantity == self.getQuantity && proposition.getSubject == self.getSubject && proposition.getQuality == self.getQuality && proposition.getPredicate == self.getPredicate && proposition.getTruthValue == self.getTruthValue)
        @answer = false
        break
      else
        @answer = true


      end
    end
    return @answer
  end

  def numberOfOccurences(set)
    @occurences = 0
    set.each do |proposition|
      if (proposition.getQuantity == self.getQuantity && proposition.getSubject == self.getSubject && proposition.getQuality == self.getQuality && proposition.getPredicate == self.getPredicate && proposition.getTruthValue == self.getTruthValue)
        @occurences += 1
      end
    end
    return @occurences
  end

  def displayProposition
    if @quantity == "universal"
      if @quality == "affirmative"
        display_quantity = "All"
        display_quality = "are"
      elsif @quality == "negative"
        display_quantity = "No"
        display_quality = "are"
      end
    elsif @quantity == "particular"
      if @quality == "affirmative"
        display_quantity = "Some"
        display_quality = "are"
      elsif @quality == "negative"
        display_quantity = "Some"
        display_quality = "are not"
      end
    end

    puts "#{display_quantity} #{@subject} #{display_quality} #{@predicate}"
  end
end