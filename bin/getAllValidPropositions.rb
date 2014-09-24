#!/usr/bin/env ruby

require_relative "../lib/catlog.rb"

typeArray = ["A", "E", "I", "O"]
numberArray = [1,2,3,4]
i=0
c=0
numberArray.each do |i|
  puts "\n"
	typeArray.each do |type|

		typeArray.each do |secondtype|
			typeArray.each do |thirdtype|
				form = Form.new(PropositionType.new(type), PropositionType.new(secondtype), PropositionType.new(thirdtype), FigureType.new(i))
	
			if form.getValidity == "valid"
				form.displayForm
			end
		end
	end
end
end