require 'rubygems'
require 'bundler/setup'
require 'alchemy_api'

module Taggers
  class TaggerAlchemy < Taggers::Tagger
    def initialize
      
    end

    def generateTags articles
      @API_KEY = '5bfb9c7ff986b8a300bbca2590ce1349c5fe477c'

      fail 'no API key' if @API_KEY == ''
      AlchemyAPI.key = @API_KEY

      articles.each do |article|
        if (!article.summary.empty?)
        	puts 'Alchemy entities:'
          
          a_entities = AlchemyAPI::EntityExtraction.new.search(text: article.summary)
          a_entities.each do |e| 
            article.tag_list.add(e['text'], parse: true)
          end
     
          a_concepts = AlchemyAPI::ConceptTagging.new.search(text: article.summary)
          a_concepts.each do |c|
            article.tag_list.add(c['text'], parse: true)
          end
        end
      end

      return articles
    end
  end
end
