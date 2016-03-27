module Taggers
  class TaggingMachine
    def initialize
      @taggers = []

      #@taggers.push(TaggerIndico.new)
      #@taggers.push(TaggerOpencalais.new)
      #@taggers.push(TaggerAlchemy.new)
      @taggers.push(TaggerSentimental.new)
      @taggers.push(TaggerAuth.new)
    end

    # Tag scraped articles
    def tag articles
      @taggers.each do |tagger|
        articles = tagger.generateTags(articles)
      end

      articles.each do |article|
        article.save
      end

      return articles
    end
  end
end
