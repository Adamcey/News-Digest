class Article < ActiveRecord::Base
  belongs_to :source

  acts_as_taggable

  # Store the key information found in the hash into database
  def self.storeData articles
    articles.each do |article|
      article.save
    end
  end
end
