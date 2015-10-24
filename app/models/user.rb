class User < ActiveRecord::Base
  # Validations
  validates_presence_of :email, :first_name, :last_name, :username
  validates :email, format: { with: /(.+)@(.+).[a-z]{2,4}/, message: "%{value} is not a valid email" }
  validates :username, format: { with: /\A[\w]+\z/, message: "%{value} is not a valid username" }
  validates :first_name, format: { with: /\A[a-zA-Z]+\z/, message: "%{value} is not a valid first name" }
  validates :last_name, format: { with: /\A[a-zA-Z]+\z/, message: "%{value} is not a valid last name" }
  validates :tag_list, format: { with: /\A[\w\s\,]*\z/, message: "%{value} is not a valid tag" }
  validates :username, uniqueness: true

  acts_as_taggable
  # Users can have interests
  acts_as_taggable_on :interests

  has_many :emailings
  has_many :articles, :through => :emailing

  has_secure_password

  # Find a user by username, then check whether the password is the same
  def self.authenticate username, password
	  user = User.find_by(username: username)

    if user && user.authenticate(password)
	    return user
    else
	    return nil
    end
  end

  def self.getSubscribers
    # where() always return an array whereas find_by() could return an
    # object when there is only one value found
    User.where(subscribed: true)
  end

  def full_name
    first_name + ' ' + last_name
  end
end
