module Scrapers
  class Scraper_Guardian < Scrapers::Scraper
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
      source_url = 'http://content.guardianapis.com'

      uri = URI.parse(source_url)
      http = Net::HTTP.new(uri.host, uri.port)

      request_url = '/search?api-key=yxfgete98f8jghn9vtetkexv&show-fields=all&show-elements=all&show-references=all&show-rights=all&q=abbott'

      response = http.send_request('GET', request_url)
      puts response
      @response_json = JSON.parse(response.body)
    end

    # Parse the content and find key information from the hash
    def parse
      source_id = Source.find_by(name: 'The Guardian').id
      articles = []

      @response_json['response']['results'].each do |hash_article|
        # puts hash_article.to_s

        # Find author
        # if hash_article.has_key? 'byline'
        #   if !hash_article['fields']['byline'].empty?
        #     author = hash_article['fields']['byline'].sub(/\ABy\s/, '')
        #   else
        #     author = ''
        #   end
        # else
        #   author = ''
        # end


        # Find date
        date=Date.parse(hash_article["webPublicationDate"])

        # if !Article.find_by(title: hash_article['webTitle'].to_s)
          article = Article.new(author: hash_article['fields']['byline'].to_s,
                                title: hash_article['webTitle'].to_s,
                                summary: hash_article['fields']['headline'].to_s, images: hash_article['fields']['thumbnail'],
                                publication_date: date, link: hash_article['webUrl'], source_id: source_id)


          articles.push(article)
        end
      # end

      return articles
    end
  end
end