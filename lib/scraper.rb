require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students= doc.css(".student-card")
    array_of_students=[]
    students.each{|student|
      student_hash={
          name: student.css("div.card-text-container .student-name").text, 
          location: student.css("div.card-text-container .student-location").text,
          profile_url: student.css("a").first["href"]
      }
      
      array_of_students<< student_hash
    }
    array_of_students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    attributes={}
    attributes[:bio]=doc.css("div.description-holder p").text
    attributes[:profile_quote]=doc.css("div.profile-quote").text
    links=doc.css('div.social-icon-container a').map { |link| link['href'] }
    links.each{|link|
      if link.include?("twitter")
        attributes[:twitter]=link
      elsif link.include?("linked")
        attributes[:linkedin]=link
      elsif link.include?("github")
        attributes[:github]=link
      else
        attributes[:blog]=link
      end
    }
    attributes

  end

end

