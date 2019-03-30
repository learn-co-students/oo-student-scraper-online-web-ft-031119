require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
#attr_accessor :name, :location, :profile_url, :index_url

#@@all = []

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))

    students = []

    student_site.css(".student-card").each do |student|
      
      binding.pry
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
