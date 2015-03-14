require 'nokogiri'
require 'tree'
require 'open-uri'

$LINK_LIMIT = 1000 #Sets the limit for the number of links used per page
$MAX_DEPTH = 100 #Sets how many pages deep program is allowed to go 

=begin

#Prompts user to enter subject term
print 'Enter Starting Point: '
start = gets.chomp
start.gsub('/ /', '_')
startURL = 'http://en.wikipedia.org/wiki/' + start #Links subject term to wiki page

begin
	open(startURL)
rescue #if url is unreachable, shutdown program
	puts 'Could not find a page on that subject'
	puts 'Shutting down...'
	abort()
end

print 'Enter Ending Point: '
target = gets.chomp
target.gsub('/ /', '_')
targetURL = 'http://en.wikipedia.org/wiki/' + target

begin
	open(targetURL)
rescue #if url is unreachable, shutdown program
	puts 'Could not find a page on that subject'
	puts 'Shutting down...'
	abort()
end

=end

def extractLinks(url) #Extracts all /wiki/ urls from a given page

	puts 'Retrieving Wikipedia page...'	
	puts 'Extracting links from ' + url + '...'
	doc = Nokogiri::HTML(open(url))
	link_array = Array.new()
	banned_words = ['wikipedia', 'wikimedia', 'file:', 'help:', 'special:', 'portal:', 'talk:', 'template:', 'category:', 'template_talk:', 'main_page', 'wikidata', 'disambiguation'] #Links with these keywords are to be removed

	#Remove all links containing [banned_words]
	for i in 0..doc.css('a').length-1
		link = doc.css('a')[i]['href']
		for j in 0..banned_words.length-1
			if link.is_a?(String) and link.downcase.include?(banned_words[j])
				link = '//'
			end
		end
		if link.is_a?(String) and link[0] == '/' and link[1] != '/' and link.include?('/wiki/')
			link_array.push('http://en.wikipedia.org' + link) #Add the link to [link_array]
		end
	end
	puts 'Finished extracting links'
	return link_array #Returns an array containing urls
end
=begin
found = false
current_link = 0
tmp_arr = extractLinks(startURL)

link_arr = Array.new(tmp_arr.length, Array.new()) #Create a multidimensional array
for i in 0..tmp_arr.length-1
	link_arr[i][0] = tmp_arr[i] #Store all the links in the first index of each subarray
end 

while found != true
	for i in 0..link_arr.length-1
		for j in 0..link_arr[i].length-1
			if link_arr[i][j] == targetURL
				found = true
				puts 'Path found'
			end
		end
	end
	
end
=end

link_array = extractLinks('http://wikipedia.org/wiki/' + gets.chomp)

startTime = Time.now.to_i

#=begin
#Lists and opens all urls within [link_array]
for i in 0..link_array.length-1 #For loop goes until [link_array.length-1] or [$LINK_LIMIT], whichever comes first
	puts "Opening " + link_array[i] + ' (' + (i+1).to_s + ' of ' + link_array.length.to_s + ')'
	doc = Nokogiri::HTML(open(link_array[i]))
end

puts 'Took ' + (Time.now.to_i - startTime).to_s + ' seconds for ' + link_array.length.to_s + ' pages'

 

#=end



