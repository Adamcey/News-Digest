module Taggers
  class TaggerAuth < Taggers::Tagger
    def initialize
    end

    def generateTags articles
      articles.each do |article|
        tags = article.author
        article.tag_list.add(tags)
      end

      return articles
    end
  end
end
