require 'date'
require 'rss'
require 'open-uri'

# Author: Sangzhuoyang Yu
# Id:     747838
module Importers
  class Importer
    def initialize
  	  @start = ::Date.today - 7
      @end = ::Date.today
    end

    # Store the key information found in the hash into database
    def store_data author, title, summary, images, link, date, section_name, source_id
      if !Article.find_by(title: title)
        @article = Article.new(title: title, publication_date: date, 
          summary: summary, author: author, images: images, link: link, 
          source_id: source_id)

        @article.tag_list.add(section_name, parse: true)
        @article.save
      end
    end
  end
end
