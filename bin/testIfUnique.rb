#!/usr/bin/env ruby

require_relative "../lib/catlog.rb"

premisesArray = [Proposition.new("universal", "Events", "affirmative", "Caused Happenings", true),
            Proposition.new("universal", "Free Decisions", "negative", "Caused Happenings", true),
            Proposition.new("universal", "Fun", "affirmative", "Events", true)]




proposition = Proposition.new("universal", "Free Decisions", "affirmative", "Caused Happenings", true)

puts proposition.isUnique?(premisesArray)