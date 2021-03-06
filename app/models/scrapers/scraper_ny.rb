# Author: Sangzhuoyang Yu
# Id:     747838
# Date:   18/09/2015
# This is a subclass extended from Scraper, which is specifically 
# implemented for scraping article information from The New York 
# Times website.


module Scrapers
  class Scraper_NY < Scrapers::Scraper
    def initialize
      super
    end

    # Scrape an article data from the web, including opening 
    # a source, parsing the received content, finding and storing data 
    # into database
    def scrape
      request_source
      parse
    end

    # Send a request to the source, and receive respond which 
    # will be converted into hash data structure
    def request_source
      source_url = 'http://api.nytimes.com'

      uri = URI.parse(source_url)
      http = Net::HTTP.new(uri.host, uri.port)
      
      request_url = '/svc/search/v2/articlesearch.json?q=game&begin_date=' << 
        @start.to_s.gsub(/\-/, '') << '&end_date=' << @end.to_s.gsub(/\-/, '') << 
        '&api-key=0f4965d7ed1303239c58e40913231985:3:72689674'

      response = http.send_request('GET', request_url)
      @response_json = JSON.parse(response.body)
    end

    # Parse the content and find key information from the hash
    def parse
      source_id = Source.find_by(name: 'The New York Times').id
      articles = []

      @response_json['response']['docs'].each do |hash_article|
       # puts hash_article.to_s

        # Find author
        if hash_article.has_key? 'byline'
          if !hash_article['byline'].empty?
            author = hash_article['byline']['original'].sub(/\ABy\s/, '')
          else
            author = ''
          end
        else
          author = ''
        end
        
        # Find title
        title = hash_article['headline']['main'].gsub(/[^\w\s\.]/, '')
        
        # Find summary
        summary = hash_article['snippet'].gsub(/\,/, '\&')
        
        # Find images
        if !hash_article['multimedia'].empty?
          images = hash_article['multimedia'].map { |m| "http://www.nytimes.com/"+m["url"] }.first
        else
          images = ''
        end
        
        # Find source
        link = hash_article['web_url']
        
        # Find date
        date = hash_article['pub_date'].gsub(/[TZ]/, ' ')

        # Find section_name
        if hash_article['section_name']
          section = hash_article['section_name'].downcase
        elsif hash_article['subsection_name']
          section = hash_article['subsection_name'].downcase
        else
          section = ''
        end

        if !Article.find_by(title: title)
          article = Article.new(title: title, publication_date: date, 
            summary: summary, author: author, images: images, link: link, 
            source_id: source_id)

          articles.push(article)
        end
      end

      return articles
    end
  end
end