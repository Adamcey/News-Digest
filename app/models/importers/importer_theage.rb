# Author: Sangzhuoyang Yu
# Id:     747838
# Date:   18/09/2015
# This is a subclass extended from importer, which is specifically 
# implemented for scraping article information from The Age News
# website.


module Importers
  class Importer_Theage < Importer
    def initialize
      super
    end

    def scrape
      source_url = 'http://www.theage.com.au/rssheadlines/top.xml'
      source_id = Source.find_by(name: 'TheAge').id

      open(source_url) do |rss|
        # Add false as the second attribute telling ruby not to validate value
        feed = RSS::Parser.parse(rss, false)

        images = feed.image.url

        feed.items.each do |item|
          # Find date
          date = Date.new(item.pubDate.year, item.pubDate.month, item.pubDate.day)

          # Compare with the date of last week and today to filter the content
          # and get data of the recent 7 days
          if ((@start <=> date) <= 0 && (date <=> @end) <= 0)
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

            # Find section
            #section = link.to_s.gsub(/\<[\w\=\"\/\s]+\>/, '')
            section = link.split(/\//)[3].downcase

            # Store all scraped data as an AGE article
            store_data(author, title, summary, images, link, date, section, source_id)
          end
        end
      end
    end
  end
end