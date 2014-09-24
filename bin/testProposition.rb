#!/usr/bin/env ruby

require_relative "../lib/catlog.rb"

proposition = Proposition.new("particular", "Free Decisions", "negative", "Caused Happenings", false)

#converse = proposition.getContrapolated
#converse.displayProposition
#puts converse.getTruthValue
puts "Proposition"
puts "==============="
proposition.displayProposition
puts "==============="
puts proposition.getType
puts "assumed: #{proposition.getTruthValue}"
puts "=============="
proposition.displayKnownTruthValues