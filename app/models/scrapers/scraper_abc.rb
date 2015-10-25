# Author: Sangzhuoyang Yu
# Id:     747838
# Date:   18/09/2015
# This is a subclass extended from importer, which is specifically
# implemented for scraping article information from The SBS News
# website.

module Scrapers
  class Scraper_ABC < Scrapers::Scraper
    def initialize
      super
    end

    def scrape
      source_url = 'http://www.abc.net.au/sport/syndicate/sport_all.xml'
      source_id = Source.find_by(name: 'TheABC').id
      articles = []

      open(source_url) do |rss|
        # Add false as the second attribute telling ruby not to validate value
        feed = RSS::Parser.parse(rss, false)

        # Find section
        #section = feed.channel.title.downcase

        # Author isn't presented
        author = ''

        # Find images
        images = ''

        feed.items.each do |item|
          # Find date
          date = Date.new(item.pubDate.year,
                          item.pubDate.month, item.pubDate.day).to_s

          # Find title
          title = item.title

          #　Find summary
          summary = item.description.split(/\<br/)[0]

          # Find source
          link = item.link

          if !Article.find_by(title: title)
            article = Article.new(title: title, publication_date: date,
                                  summary: summary, author: author, images: images, link: link,
                                  source_id: source_id)

            articles.push(article)
          end
        end
      end

      return articles
    end
  end
end