class Article < ActiveRecord::Base
  validates :title, uniqueness: true
  belongs_to :source
  has_many :emailings
  has_many :users, :through => :emailing

  acts_as_taggable

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
    keywords = []

    synonyms_finder = SynonymsFinder.new

    # Get all related keywords using synonyms finder
    user.tag_list.each do |interest|
      keywords = keywords + synonyms_finder.getSynonyms(interest)
    end
    
    # Get all new articles matching the user interests
    articles.each do |article|
      shared = article.tag_list & keywords
      
      unless shared.empty?
        interests.push(article)
      end
    end

    return interests.first(10)
  end

  def self.calculateWeight keyword
    articles = Article.all
    articles_hash = Hash.new
    keyword = keyword.downcase

    articles.each do |article|
      weight = 0

      article.tag_list.each do |tag|
        if (tag.downcase.include?(keyword))
          weight += 4

          break
        end
      end

      if article.title.downcase.include?(keyword)
        weight += 3
      end
      if article.summary.downcase.include?(keyword)
        weight += 2
      end
      if Source.where(source_id: article.source_id).name.downcase.include?(keyword)
        weight += 1
      end

      if (weight != 0)
        articles_hash[article] = weight
      end
    end

    articles_hash = articles_hash.sort_by {|key, value| key.publication_date}.reverse.to_h
    articles_hash = articles_hash.sort_by {|key, value| -value}.to_h

    articles = articles_hash.keys

    return articles
  end
end
