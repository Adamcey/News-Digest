require 'rubygems'
require 'bundler/setup'
require 'open_calais'

module Taggers
  class TaggerOpencalais < Taggers::Tagger
    def initialize
    end

    def generateTags articles
      @API_KEY = 'A0o68Abood82fCD1CMHgM0GZNBOI4v11'

      fail 'no API key' if @API_KEY == ''

      articles.each do |article|
        if (!article.title.empty?)
          oc = OpenCalais::Client.new(api_key: @API_KEY)
          oc_response = oc.enrich article.title
          #puts 'OpenCalais tags:'
          
          oc_response.tags.each do |t|
            article.tag_list.add(t[:name], parse: true)
          end
          
          #puts 'OpenCalais topics:'
          oc_response.topics.each do |t|
           	article.tag_list.add(t[:name], parse: true)
          end
        end
      end

      return articles
    end
  end
end
