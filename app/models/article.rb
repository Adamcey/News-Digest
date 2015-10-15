class Article < ActiveRecord::Base
  belongs_to :source

  acts_as_taggable
end
