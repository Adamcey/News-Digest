# Author: Sangzhuoyang Yu
# Id:     747838
# Date:   18/09/2015
# This is a subclass extended from importer, which is specifically 
# implemented for scraping article information from The ABC News
# website.


module Importers
  class Importer_Theabc < Importer
    def initialize
      super
    end

    def scrape
      source_url = 'http://abc.net.au/syndication/rss-childrens-epg.xml'
      source_id = Source.find_by(name: 'TheABC').id

      open(source_url) do |rss|
        # Add false as the second attribute telling ruby not to validate value
        feed = RSS::Parser.parse(rss, false)

        # Find date
        date = Date.new(feed.channel.pubDate.year, 
          feed.channel.pubDate.month, feed.channel.pubDate.day)

        # Find section
        section = feed.channel.title.downcase

        # Find images
        images = feed.channel.image.url

        feed.items.each do |item|
          # Author isn't presented
          author = ''
          
          # Find title
          title = item.title
          
          # Convert date to a string
          date = date.to_s
          
          #　Find summary
          summary = item.description

          # Find source
          link = item.link

          # Store all scraped data as an AGE article
          store_data(author, title, summary, images, link, date, section, source_id)
        end
      end
    end
  end
end