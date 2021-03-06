require 'rubygems'
require 'bundler/setup'
require 'indico'


module Taggers
  class TaggerIndico < Taggers::Tagger
    def initialize
    end

    def generateTags articles
      @API_KEY = '91a45efbea04ba74ee632db8a0bdd848'

      fail 'no API key' if @API_KEY == ''
      Indico.api_key = @API_KEY

      articles.each do |article|
        if (!article.title.empty?)
          ind_keywords = Indico.keywords article.title
          #  puts article.summary

          ind_keywords.each do |k, v|
            article.tag_list.add(k, parse: true)
          end

          ind_tags = Indico.text_tags article.title
          ind_tags_sorted = ind_tags.sort_by { |_k, v| -1.0 * v }.first(3).to_h
          
          ind_tags_sorted.each do |k, v|
            article.tag_list.add(k, parse: true)
          end
        end
      end

      return articles
    end
  end
end
