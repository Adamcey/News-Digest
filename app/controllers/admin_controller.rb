class AdminController < ApplicationController
  def sendEmailToSubscribers
    # Get all users who subscribe for articles
    users = User.getSubscribers

    users.each do |user|
      newArticles = Article.getNewArticles(user)
      Emailer.sendEmail(user, newArticles).deliver
    end

    redirect_to articles_url
  end

  # Refresh the article page, scraping new article data
  def scrape
    @articles = Scrapers::Importer.new.import
    Taggers::TaggingMachine.new.tag(@articles)

    #Article.storeData(@articles)

    redirect_to articles_url
  end
end
