class Article < ActiveRecord::Base
  validates :title, uniqueness: true
  belongs_to :source
  has_many :emailings
  has_many :users, :through => :emailing

  acts_as_taggable

  # Store the key information found in the hash into database
  def self.storeData articles
    articles.each do |article|
      article.save
    end
  end

  # Retrieve article data to be sent to users
  def self.getNewArticles user
    article_ids = []
    emails = Emailing.where(user_id: user.id)

    # Find all article_id of articles that have been sent to the user
    emails.each do |email|
      article_ids.push(email.article_id)
    end

    # Find all new articles have not been sent to the user
    newArticles = Article.where.not(id: article_ids).order(publication_date: :desc)

    # Get first 10 articles matching user's interests
    interests = find_interests(newArticles, user)
    
    # Store emails history into database
    interests.each do |a|
      Emailing.create(username: user.username, article_title: a.title, user_id: user.id, article_id: a.id)
    end

    return interests
  end

  # Find out articles matching user interests
  def self.find_interests articles, user
    interests = []

    articles.each do |article|
      shared = article.tag_list & user.tag_list
      
      unless shared.empty?
        interests.push(article)
      end
    end

    return interests.first(10)
  end
end
