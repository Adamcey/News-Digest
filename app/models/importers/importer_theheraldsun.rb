# Author: Sangzhuoyang Yu
# Id:     747838
# Date:   18/09/2015
# This is a subclass extended from importer, which is specifically 
# implemented for scraping article information from The Heral Sun News
# RSS.


module Importers
  class Importer_Theheraldsun < Importer
    def initialize
      super
    end

    def scrape
      source_url = 'http://feeds.news.com.au/heraldsun/rss/heraldsun_news_breakingnews_2800.xml'
      source_id = Source.find_by(name: 'The Herald Sun').id

      open(source_url) do |rss|
        # Add false as the second attribute telling ruby not to validate value
        feed = RSS::Parser.parse(rss, false)

        # Find section
        section = feed.channel.title.split(/\|/)[2].downcase

        # Find images
        images = ''

        feed.items.each do |item|
          # Author isn't presented
          author = ''

          # Find date
          date = Date.new(item.pubDate.year, 
          item.pubDate.month, item.pubDate.day).to_s
          
          # Find title
          title = item.title
          
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