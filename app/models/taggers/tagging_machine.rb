module Taggers
  class TaggingMachine
    def initialize
      @taggers = []

      @taggers.push(TaggerIndico.new)

    end

    # Tag scraped articles
    def tag articles
      @taggers.each do |tagger|
        tagger.generateTags(articles)
      end

      #  return articles
    end
  end
end
