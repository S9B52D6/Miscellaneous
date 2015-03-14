require 'nokogiri'
require 'open-uri'

#Attempts to find a given Wikipedia entry
#and writes all relevant wikipedia links
#to file

#Prompts user to enter subject term
print 'Enter Subject: '
subject = gets.chomp
subject.gsub!(/\s+/, '_')
url = 'http://en.wikipedia.org/wiki/' + subject #Links subject term to wiki page

begin
  open(url)
rescue #if url is unreachable, shutdown program
  puts 'Could not find a page on subject: ' + subject
  puts 'Shutting down...'
  abort()
end

def extractLinks(url) #Extracts all /wiki/ urls from a given page

  puts 'Retrieving Wikipedia page...'	
  puts 'Extracting links from ' + url + '...'
  doc = Nokogiri::HTML(open(url))
  link_array = Array.new()
  banned_words = ['wikipedia', 'wikimedia', 'file:', 'help:', 'special:', 'portal:', 'talk:', 'template:', 'category:', 'template_talk:', 'main_page', 'wikidata', 'disambiguation', 'book:', 'international_standard_book_number'] #Links with these keywords are to be removed

  
  for i in 0..doc.css('a').length-1 
    link = doc.css('a')[i]['href'] #Retrieve all links through css <a href=".."> tags
    for j in 0..banned_words.length-1
      if link.is_a?(String) and link.downcase.include?(banned_words[j]) #Remove all links with banned words
        link = '//'
      end
    end
    if link.is_a?(String) and link[0] == '/' and link[1] != '/' and link.include?('/wiki/')
      link_array.push('http://en.wikipedia.org' + link) #Adds the link to the array
    end
  end
  puts 'Finished extracting links'
  return link_array #Returns an array containing urls
end

link_array = extractLinks(url)
file = File.new('links.txt', 'w')

for i in 0..link_array.count-3
  file.puts link_array[i]
end
