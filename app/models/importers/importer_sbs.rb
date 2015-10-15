# Author: Sangzhuoyang Yu
# Id:     747838
# Date:   18/09/2015
# This is a subclass extended from importer, which is specifically 
# implemented for scraping article information from The SBS News
# website.


module Importers
  class Importer_SBS < Importer
    def initialize
      super
    end

    def scrape
      source_url = 'http://www.sbs.com.au/news/rss/news/business.xml'
      source_id = Source.find_by(name: 'SBS').id

      open(source_url) do |rss|
        # Add false as the second attribute telling ruby not to validate value
        feed = RSS::Parser.parse(rss, false)

        # Find section
        section = feed.channel.title.downcase

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

          # Store all scraped data as an AGE article
          store_data(author, title, summary, images, link, date, section, source_id)
        end
      end
    end
  end
end