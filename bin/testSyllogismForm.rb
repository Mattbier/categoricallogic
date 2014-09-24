#!/usr/bin/env ruby

require_relative "../lib/catlog.rb"

form = Form.new(PropositionType.new("E"), PropositionType.new("O"), PropositionType.new("E"), FigureType.new(2))
puts "Testing: #{form.getForm}"

syllogism = form.getFormSyllogism
conclusion = syllogism.getConclusion
#conclusion.displayProposition


puts form.getValidity
puts "=============="
puts form.displayValidity
puts "Propositional form:"
puts form.displayPropositionalForm



