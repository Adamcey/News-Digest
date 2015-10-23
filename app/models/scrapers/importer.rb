module Scrapers
  class Importer
    def initialize
      @scrapers = []
      @articles = []

      @scrapers.push(Scraper_NY.new)
      @scrapers.push(Scraper_Theage.new)
      @scrapers.push(Scraper_Theheraldsun.new)
      @scrapers.push(Scraper_Thesydney.new)
      @scrapers.push(Scraper_SBS.new)
    end

    def import
      @scrapers.each do |scraper|
        @articles = @articles + scraper.scrape
      end

      return @articles
    end
  end
end
