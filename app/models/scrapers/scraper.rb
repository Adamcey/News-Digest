require 'date'
require 'rss'
require 'open-uri'

# Author: Sangzhuoyang Yu
# Id:     747838
module Scrapers
  class Scraper
    def initialize
  	  @start = ::Date.today - 7
      @end = ::Date.today
    end
  end
end
