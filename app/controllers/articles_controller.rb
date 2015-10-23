class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.reverse
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # Retrieve all article data that match the user interests
  def interests
    @articles = Article.tagged_with(current_user.tag_list, :any => true)
    render 'index'
  end

  # Refresh the article page, scraping new article data
  def scrape
    articles = Scrapers::Importer.new.import
    #articles = Taggers::TaggingMachine.new.tag(articles)

    # Test finding interests
    articles.each do |a|
      a.tag_list.add('sport')
    end

    Article.storeData(articles)

    redirect_to articles_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:source, :title, :publication_date, :summary, :author, :images, :link)
    end
end
