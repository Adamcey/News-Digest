class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  # GET /articles
  # GET /articles.json
  def index
    #@articles = Article.all.reverse

    @articles = Article.paginate( :page => params[:page], :per_page => 10).order('publication_date DESC').page(params[:page])

  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # Retrieve all article data that match the user interests
  def interests
    # Find articles relavent to user interests using Thesaurus api
    @articles = Article.find_interests(Article.all, current_user).reverse

    render 'index'
  end

  def search
    @keyword = params[:search][:query]

    #lack : keyword in string ,souce include, cant multiple choice

    if (@keyword != nil)

      #@articles = Article.tagged_with(@keyword, :any => true)
      calculateWeight(@keyword)
      @articles = Article.all.find_all { |a| a.weight != 0 }
       @articles = @articles.sort_by { |a| [a.weight, a.publication_date]}
      #@articles = @articles.reverse
    else
      @articles = nil

    end
  end

  def calculateWeight keyword
    Article.all.each do |article|
      article.weight = 0
      if (article.tag_list.include?(keyword))
        article.weight += 4
      end
      if article.title.include?(keyword)
        article.weight += 3
      end
      if article.summary.include?(keyword)
        article.weight += 2
      end
      if Source.find_by(article.source_id).name.include?(keyword)
        article.weight += 1
      end


      article.save
    end
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
