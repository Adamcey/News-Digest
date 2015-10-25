require 'rubygems'
require 'bundler/setup'
require 'alchemy_api'
module Taggers
  class TaggerAlchemy < Taggers::Tagger
    def initialize
      @API_KEY = '5bfb9c7ff986b8a300bbca2590ce1349c5fe477c'
    end

    def generateTags articles
      fail 'no API key' if @API_KEY == ''
      AlchemyAPI.key = @API_KEY

      articles.each do |article|
        if (!article.title.empty?)
        	puts 'Alchemy entities:'
            a_entities = AlchemyAPI::EntityExtraction.new.search(text: article.title)
            a_entities.each do |e| 
            article.tag_list.add(e['text'], parse: true)
            end
       
            a_concepts = AlchemyAPI::ConceptTagging.new.search(text: article.title)
            a_concepts.each do |c|
            article.tag_list.add(c['text'], parse: true)
            end
          article.save
        end
      end
    end
  end
end



