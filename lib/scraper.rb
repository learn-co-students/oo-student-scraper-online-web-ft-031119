require 'open-uri'
require 'pry'


class Scraper

@@students = []
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.student-card").each do |student_card|
      student = {
        name: student_card.css("h4").text,
        location: student_card.css("p").text,
        profile_url: student_card.css("a[href]").first['href']
      }
      @@students << student
    end
    @@students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student_file = {
      # twitter: doc.css("div.social-icon-container a")[0]['href'],
      # linkedin: doc.css("div.social-icon-container a")[1]['href'],
      # github: doc.css("div.social-icon-container a")[2]['href'],
      # blog: doc.css("div.social-icon-container a")[3]['href'],
      profile_quote: doc.css("div.profile-quote").text.strip,
      bio: doc.css("div.description-holder p").text
      }
      doc.css("div.social-icon-container a").each do |anchor|
        a = anchor['href']
        case
        when a.include?('twit')
          student_file[:twitter] = a
        when a.include?('link')
          student_file[:linkedin] = a
        when a.include?('git')
          student_file[:github] = a
        else
           student_file[:blog] = a
        end
    end
    student_file
  end

end
