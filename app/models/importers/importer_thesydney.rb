# Author: Sangzhuoyang Yu
# Id:     747838
# Date:   18/09/2015
# This is a subclass extended from importer, which is specifically 
# implemented for scraping article information from The Sydney News 
# website.

module Importers
  class Importer_Thesydney < Importer
    def initialize
      super
    end

    # Scrape an article data from the web, including opening 
    # a source, parsing the received content, finding and storing data 
    # into database
    def scrape
      source_url = 'http://www.smh.com.au/rssheadlines/nsw/article/rss.xml'
      source_id = Source.find_by(name: 'The Sydney Morning Herald').id

      open(source_url) do |rss|
        # Add false as the second attribute telling ruby not to validate value
        feed = RSS::Parser.parse(rss, false)

        # Find section
        #section = feed.channel.link.split(/\//)[3]
        section = 'NSW'

        # Find images
        images = feed.channel.image.url

        feed.items.each do |item|
          # Find date
          date = Date.new(item.pubDate.year, 
          item.pubDate.month, item.pubDate.day)

          # Compare with the date of last week and today to filter the content
          # and get data of the recent 7 days
          if ((@start <=> date) <= 0 && (date <=> @end) <= 0)
            # Author isn't presented
            author = ''

            # Find title
            title = item.title
            
            #　Find summary
            summary = item.description.split(/\<\/p\>/)[1]
            
            if !summary
              summary = item.description
            end

            # Find source
            link = item.link

            # Store all scraped data as an AGE article
            store_data(author, title, summary, images, link, date, section, source_id)
          end
        end
      end
    end
  end
end