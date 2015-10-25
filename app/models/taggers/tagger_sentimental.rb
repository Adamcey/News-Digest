require 'rubygems'
require 'bundler/setup'
require 'sentimental'


module Taggers
  class TaggerSentimental < Taggers::Tagger
    def initialize
    end

    def generateTags articles
      Sentimental.load_defaults
      Sentimental.threshold = 0.1

      articles.each do |article|
        if (!article.title.empty?)
         s = Sentimental.new
         sentiment = (s.get_sentiment article.title).to_s
         if sentiment == "positive"
            article.tag_list.add('happy')
            article.save
          end
            
          if sentiment == "neutral" 
            article.tag_list.add('just so so')
            article.save
          end
          if sentiment == "negative"
            article.tag_list.add('unhappy')
          article.save
        end
        end
      end
    end
  end
end