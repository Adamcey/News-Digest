require 'rubygems'
require 'bundler/setup'
require 'indico'


module Taggers
  class TaggerIndico < Taggers::Tagger
    def initialize
      @API_KEY = '91a45efbea04ba74ee632db8a0bdd848'
    end

    def generateTags articles
      fail 'no API key' if @API_KEY == ''
      Indico.api_key = @API_KEY

      articles.each do |article|
        if (!article.summary.empty?)
          ind_keywords = Indico.keywords article.summary
          puts article.summary

          ind_keywords.each do |k, v|
            article.tag_list.add(k, parse: true)
          end

          ind_tags = Indico.text_tags article.summary
          ind_tags_sorted = ind_tags.sort_by { |_k, v| -1.0 * v }.first(10).to_h
          ind_tags_sorted.each do |k, v|
            article.tag_list.add(k, parse: true)
          end
        end
      end

      return articles
    end
  end
end