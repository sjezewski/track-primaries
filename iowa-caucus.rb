#!/usr/bin/env ruby

# Hit google to see the results and print them
# I use it by doing:
#     watch ./iowa-caucus.rb

require 'http'
require 'nokogiri'

#url = "https://www.google.com/search?q=bernie+vs+hilary+iowa+caucus&oq=bernie+vs+hilary+iowa+caucus&aqs=chrome..69i57.4746j0j7&sourceid=chrome&es_sm=91&ie=UTF-8#q=iowa+cuacus+results&eob=D/2/short/m.03s0w/"

c = "https://www.google.com/async/usprimaries_party?async=party:2,exp:0,month:2016-02,cs:0,ecm:,location:%2Fm%2F03s0w,_id:eob-pcb,_pms:s&ei=9SywVtm6CsGujAOU-KCgCQ&yv=2"

r = HTTP.get(c)
p = JSON(r.body.to_s)

doc = Nokogiri::HTML(p[1][1])

buffer = []

buffer <<  "Candidate\tPercentage\tDelegates"
buffer << "---------\t----------\t---------"

results = {}

["Hillary","Bernie"].each do |candidate|
  percentage = doc.search("//*[contains(@aria-label, '#{candidate}')]/../../td[last()]/text()")
  delegates = doc.search("//*[contains(@aria-label, '#{candidate}')]/../../td[2]/div/text()")

  buffer << "#{candidate}\t\t#{percentage}\t\t#{delegates}"
  percentage.to_s =~ /\A([\d\.]+?)\%/
  results[candidate] = $1.to_f
end

difference = results["Hillary"] - results["Bernie"]

if results["Bernie"] > results["Hillary"]
  puts "FEEEEEL THE BERN!\n"
  puts buffer.join("\n")
  exit 0
else
  puts "Hilary is winning by #{difference}\n\n"
  puts buffer.join("\n")
  exit 1
end

