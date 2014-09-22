#!/usr/bin/env ruby

require_relative "../lib/catlog.rb"

major = Proposition.new("universal", "Dogs", "affirmative", "Nice things", true)
minor = Proposition.new("universal", "Nice things", "affirmative", "mammals", true)
conclusion = Proposition.new("particular", "mammals", "negative", "Dogs", true)
syllogism = Syllogism.new(major, minor, conclusion)

puts "Testing syllogism (#{syllogism.getForm}):"
syllogism.displaySyllogism

puts "Validity:"

puts syllogism.getValidity
syllogism.displayValidity