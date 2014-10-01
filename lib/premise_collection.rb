class PremiseCollection
  def initialize(propositionarray)
    @collection = propositionarray
  end


  def getAllInferredTruths

    if @collection.count < 2
      puts "collection must include two or more propositions"
    else
      inputconclusions = @collection
      inferredconclusions = []
      pairs = []

      @collection.each do |proposition|

        @collection.each do |secondproposition|
          unless proposition.equal? secondproposition
            pairs << PremisePair.new(proposition, secondproposition)
            #I cant tell if this needs to be added or if just creates duplicates right now it seems like duplicates only
            # I think it does make it a difference; it mostly creates duplicates but there are a few extra created -- need to filter unique propositions
            #pairs << PremisePair.new(secondproposition, proposition)
          end
        end
      end
      pairs.each do |pair|
        conclusions = pair.getPossibleConclusions
        conclusions.each do |conclusion|
          syllogism = Syllogism.new(pair.getMajor, pair.getMinor, conclusion)

          if syllogism.getValidity == "valid"
            validconclusion = syllogism.getConclusion
            #tests against original set - but does not yet successfully test again newly produced set
            if (validconclusion.isUnique?(inputconclusions))
              inferredconclusions << validconclusion
            end
          end
        end
      end

    return inferredconclusions

    end
  end

  def getUniqueInferredTruths
    newset = PremiseCollection.new(self.getAllInferredTruths)
    unique_inferredconclusions = newset.reduceToUniqueSet
    return unique_inferredconclusions
  end

  def displayLoopedInferredTruths

      #get first set of inferences
      inferredtruths = self.getUniqueInferredTruths
      combinedset = self.combineSets(inferredtruths)

      puts "======================="
      puts "first set of inferences"
      puts inferredtruths.count
      puts "======================="
      self.displayInferredTruths

      while (inferredtruths.count != 0)

      ## create new collection object
      newcollection = PremiseCollection.new(combinedset)

      ## get next set of inferences

      #reset inferred truths
      inferredtruths = newcollection.getUniqueInferredTruths
      #rest combined set
      combinedset = newcollection.combineSets(inferredtruths)

      puts "======================="
      puts inferredtruths.count
      puts "next set of inferences"
      puts "======================="

      #display inferred set
      newcollection.displayInferredTruths

    end
  end


  def combineSets(newset)
    newcollection = []

    newcollection << @collection
    newcollection << newset


    return newcollection.flatten
  end



  def reduceToUniqueSet
    unique_knownconclusions = []

    @collection.each do |conclusion|
      if unique_knownconclusions.count == 0
        unique_knownconclusions << conclusion
      elsif conclusion.isUnique?(unique_knownconclusions)
        unique_knownconclusions << conclusion
      end


    end
    return unique_knownconclusions
end

  def displayInferredTruths
    truths = self.getUniqueInferredTruths
    truths.each do |truth|
      truth.displayProposition
    end
  end


  def getNumberOfInferredTruths
    self.getUniqueInferredTruths.count
  end
  def getNumberOfInputTruths
    @collection.count
  end
  def getRatioInputToInferred
    self.getNumberOfInferredTruths / self.getNumberOfInputTruths
  end
end