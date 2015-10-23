require 'rubygems'
require 'bundler/setup'
require 'open_calais'

module Taggers

	class TaggerOpencalais < Taggers::Tagger

    def initialize
      @API_KEY = 'A0o68Abood82fCD1CMHgM0GZNBOI4v11'
    end

     def generateTags articles
      fail 'no API key' if @API_KEY == ''

      articles.each do |article|
        if (!article.summary.empty?)
        	oc = OpenCalais::Client.new(api_key: @API_KEY)
        	oc_response = oc.enrich article.summary
        	puts 'OpenCalais tags:'
        	
        	oc_response.tags.each do |t|
                
        		article.tag_list.add(t[:name], parse: true)
        	end
          
            puts 'OpenCalais topics:'
            oc_response.topics.each do |t|
            	article.tag_list.add(t[:name], parse: true)
            end
            article.save
        end
    end
end
end
end
