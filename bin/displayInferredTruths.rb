#!/usr/bin/env ruby

require_relative "../lib/catlog.rb"
=begin
premises = [Proposition.new("universal", "dogs", "affirmative", "animals", true),
            Proposition.new("universal", "cats", "affirmative", "animals", true),
            Proposition.new("universal", "animals", "affirmative", "mortals", true),
            Proposition.new("universal", "mortals", "affirmative", "things that disintegrate", true),
            Proposition.new("particular", "dogs", "affirmative", "brown", true),
            Proposition.new("particular", "cats", "negative", "mean things", true),
            Proposition.new("particular", "cats", "negative", "mean things", true),
            Proposition.new("universal", "animals", "negative", "divine things", true),
           	Proposition.new("particular", "animals", "affirmative", "carnivores", true)]
=end
premises = [Proposition.new("universal", "Events", "affirmative", "Caused Happenings", true),
        	Proposition.new("universal", "Free Decisions", "negative", "Caused Happenings", true)]
        	

collection = PremiseCollection.new(premises)
collection.displayInferredTruths
puts "#{collection.getNumberOfInferredTruths} / #{collection.getNumberOfInputTruths}: #{collection.getRatioInputToInferred}/1"