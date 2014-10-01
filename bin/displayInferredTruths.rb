#!/usr/bin/env ruby

require_relative "../lib/catlog.rb"

premises2 = [Proposition.new("universal", "dogs", "affirmative", "animals", true),
            Proposition.new("universal", "cats", "affirmative", "animals", true),
            Proposition.new("universal", "animals", "affirmative", "mortals", true),
            Proposition.new("universal", "mortals", "affirmative", "things that disintegrate", true),
            Proposition.new("particular", "dogs", "affirmative", "brown", true),
            Proposition.new("particular", "cats", "negative", "mean things", true),
            Proposition.new("particular", "cats", "negative", "mean things", true),
            Proposition.new("universal", "animals", "negative", "divine things", true),
           	Proposition.new("particular", "animals", "affirmative", "carnivores", true)]


premises1 = [Proposition.new("universal", "Mammals", "affirmative", "Mortal Things", true),
        	Proposition.new("universal", "People", "affirmative", "Mammals", true),]

        	

collection = PremiseCollection.new(premises1)
puts "==============="
puts "intial set"
puts premises1.count
puts "================="
premises1.each do |proposition|
proposition.displayProposition
end

collection.displayLoopedInferredTruths
#puts "#{collection.getNumberOfInferredTruths} / #{collection.getNumberOfInputTruths}: #{collection.getRatioInputToInferred}/1"