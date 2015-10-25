module Taggers
  class TaggingMachine
    def initialize
      @taggers = []

      @taggers.push(TaggerIndico.new)
      @taggers.push(TaggerOpencalais.new)
      @taggers.push(TaggerAlchemy.new)
      @taggers.push(TaggerSentimental.new)
      @taggers.push(TaggerLast.new)


    end

    # Tag scraped articles
    def tag articles
      @taggers.each do |tagger|
        tagger.generateTags(articles)
      end

      return articles
    end
  end
end