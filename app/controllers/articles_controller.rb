class ArticlesController < ApplicationController
  def index
    if params[:query]
      @query = params[:query]
      @articles = Article.search(@query)
    else
      @articles = Article.order("created_at desc")
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def post_receive_hook
    Article.post_receive(params[:payload])
    render :nothing => true
  end
end
