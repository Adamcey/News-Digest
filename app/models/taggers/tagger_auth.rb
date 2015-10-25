module Taggers
  class TaggerLast < Taggers::Tagger
    def initialize
    end

    def generateTags articles
      articles.each do |article|
        tags = article.author
        article.tag_list.add(tags)
        article.save
      end

    end
  end
end