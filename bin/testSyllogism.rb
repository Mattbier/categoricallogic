#!/usr/bin/env ruby

require_relative "../lib/catlog.rb"

major = Proposition.new("universal", "pollution free", "affirmative", "completely efficient", true)
minor = Proposition.new("universal", "automobile", "negative", "completely efficient", true)
conclusion = Proposition.new("universal", "automobile", "negative", "pollution free", true)
syllogism = Syllogism.new(major, minor, conclusion)

puts "Testing syllogism (#{syllogism.getForm}):"
syllogism.displaySyllogism

puts "Validity:"

puts syllogism.getValidity
syllogism.displayValidity