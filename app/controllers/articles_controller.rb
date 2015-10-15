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
    Importers::Importer_SBS.new.scrape
    Importers::Importer_Theabc.new.scrape
    Importers::Importer_Theheraldsun.new.scrape
    Importers::Importer_Theage.new.scrape
    Importers::Importer_Thesydney.new.scrape
    Importers::Importer_NY.new.scrape

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
