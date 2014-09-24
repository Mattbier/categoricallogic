#!/usr/bin/env ruby

require_relative "../lib/catlog.rb"

type = PropositionType.new("E")
proposition = type.getProposition

#converse = proposition.getContrapolated
#converse.displayProposition
#puts converse.getTruthValue
puts "E assumed true"
puts "=============="
proposition.displayKnownTruthValues