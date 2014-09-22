#!/usr/bin/env ruby
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
def getQuality
	@quality
end	
def getContradictory
	if @quantity == "universal"
		quantity = "particular"
	elsif @quantity == "particular"
		quantity = "univeral"
	end
	
	if @quality == "affirmative"
		quality = "negative"
	elsif @quality == "negative"
		quality = "affirmative"
	end
		
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

	if @quality == "affirmative"
		quality = "negative"
	elsif @quality == "negative"
		quality = "affirmative"
	end

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
		 
	if @quality == "affirmative"
		quality = "negative"
	elsif @quality == "negative"
		quality = "affirmative"
	end

	if !@truthvalue
			truthvalue = !@truthvalue
	elsif @truthvalue
			truthvalue = "unknown"
	end
		
	@subcontrary = Proposition.new(@quantity, @subject, quality, @predicate, truthvalue)
	return @subcontrary
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
		contrary = self.getContrary
	elsif @quantity == "particular"
		subcontrary = self.getSubcontrary
	end
	subaltern = self.getSubaltern

	puts "contradictory = #{contradictory.getType}: #{contradictory.getTruthValue}"
	puts "contrary/subcontrary = #{contrary.getType}: #{contrary.getTruthValue}"
	puts "subaltern = #{subaltern.getType}: #{subaltern.getTruthValue}"
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
		if @conclusion.getDistribution("predicate") != @major.getDistribution(@major.getPosition(self.getMajorTermFromMajorPremise))  	
			validity = "invalid (2a, illicit major)"
		else
			validity = "pass"
		end
	end
	def test2b
		##Rule Number 2b distribution of minor term - check fallacy of illicit minor
		if @conclusion.getDistribution("subject") != @minor.getDistribution(@minor.getPosition(self.getMinorTermFromMinorPreimse))  	
			validity = "invalid (2b, illicit minor)"
		else
			validty = "pass"
		end
	end

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

class PremiseCollection
  def initialize(propositionarray)
    @collection = propositionarray
  end

  def getInferredTruths
    if @collection.count < 2
      puts "collection must include two or more propositions"
    else

    knownconclusions = []
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
        	#puts "=="
          	#syllogism.displayForm
          	#syllogism.displaySyllogism
          	#puts syllogism.getValidity
          	#puts "=="

          if syllogism.getValidity == "valid"
          	
          	validconclusion = syllogism.getConclusion

            knownconclusions << validconclusion

            end
          end
        end
      return knownconclusions
    end
  end

  def displayInferredTruths
    truths = self.getInferredTruths
    truths.each do |truth|
      truth.displayProposition
    end
  end

  def getNumberOfInferredTruths
    self.getInferredTruths.count
  end
  def getNumberOfInputTruths
    @collection.count
  end
  def getRatioInputToInferred
    self.getNumberOfInferredTruths / self.getNumberOfInputTruths
  end
end

class PropositionType
	def initialize(type)
		@type = type
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
end

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











