#!/usr/bin/env ruby

require_relative "../lib/catlog.rb"

form = Form.new(PropositionType.new("A"), PropositionType.new("A"), PropositionType.new("A"), FigureType.new(3))
puts "Testing: #{form.getForm}"

syllogism = form.getFormSyllogism
conclusion = syllogism.getConclusion
conclusion.displayProposition


puts form.getValidity
puts form.displayValidity
puts "Propositional form:"
puts form.displayPropositionalForm
