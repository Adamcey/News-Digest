class Article < ActiveRecord::Base
  belongs_to :source

  acts_as_taggable
<<<<<<< HEAD

  # Store the key information found in the hash into database
  def self.storeData articles
    articles.each do |article|
      article.save
    end
  end
=======
>>>>>>> 17e99a5ceb629b12b2f00a744a30787b885ea7dd
end
