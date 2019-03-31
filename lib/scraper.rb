require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))

    students = []

    student_site.css(".student-card").each do |student|
    name = student.css(".student-name").text
    location = student.css(".student-location").text
    profile_url = student.css("a").attribute("href").value
      #binding.pry
      students << {
        name: name,
        location: location,
        profile_url: profile_url
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    student_links = {}

    social_media_links = student_profile.css(".social-icon-container a").each do |sm_links|
    x = sm_links['href']
    case
    when x.include?("twitter")
      student_links[:twitter] = x
    when x.include?("linkedin")
      student_links[:linkedin] = x
    when x.include?('github')
      student_links[:github] = x
    else
      student_links[:blog] = x
      end
    end
    student_links[:profile_quote] = student_profile.css(".profile-quote").text
    student_links[:bio] = student_profile.css("div.bio-content.content-holder div.description-holder p").text
    #binding.pry
    student_links
  end
end
