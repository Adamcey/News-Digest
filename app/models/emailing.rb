# Contains emailing history

class Emailing < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
end
