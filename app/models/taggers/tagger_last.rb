module Taggers
  class TaggerLast < Taggers::Tagger
    def initialize
    end

    def generateTags articles
       articles.each do |article|
       regex = /(?:\s*\b([A-Z]+(?:\s*\w*)?)\b)+/
       tags = article.summary.scan(regex)
       article.tag_list.add(tags)
       article.save
     end
    
end
end
end