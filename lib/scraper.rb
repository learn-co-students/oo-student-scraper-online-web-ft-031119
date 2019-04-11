
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    cards = doc.css(".student-card")
    data = cards.collect {|c|
      {
        :name => c.css(".student-name").text,
        :location => c.css(".student-location").text,
        :profile_url => c.css("a").attribute("href").value
      }
    }
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scrape = {}
    scrape[:profile_quote] = doc.css(".profile-quote").text
    scrape[:bio] = doc.css(".description-holder p").text
    
    links = doc.css(".social-icon-container").css("a").collect{ |item|
      item.attribute("href").value
    }
    
    links.each {|link|
      if link.include?("twitter.com")
        scrape[:twitter] = link
      elsif link.include?("linkedin.com")
        scrape[:linkedin] = link
      elsif link.include?("github.com")
        scrape[:github] = link
      else
        scrape[:blog] = link
      end
    }
    
    scrape
  end

end

