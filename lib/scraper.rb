require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

def self.scrape_index_page(index_url)
  student_hash=[]
  html=open("./fixtures/student-site/index.html")
  doc=Nokogiri::HTML(html)
    doc.css(".student-card").collect{|student|
          hash={
                :name => student.css("h4").text, 
                :location => student.css("p").text, 
                :profile_url => student.css("a").attribute("href").text
                }
                student_hash << hash 
    }
  student_hash
  end
  
  def self.scrape_profile_page(profile_url)
    student_hash={}
    doc=Nokogiri::HTML(open(profile_url))
     doc.css(".social-icon-container a").each{|icon|
     link= icon.attribute("href").text
     student_hash[:twitter]= link if link.include?("twitter")
     student_hash[:linkedin]= link if link.include?("linkedin")
     student_hash[:github]= link if link.include?("github")
     student_hash[:blog] =link if 
                  icon.css("img").attribute("src").text.include?("rss")
      
     student_hash[:profile_quote]=doc.css(".profile-quote").text
     student_hash[:bio]= doc.css(".description-holder p").text
      }
      student_hash
  end

end

