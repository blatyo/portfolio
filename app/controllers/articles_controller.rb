class ArticlesController < ApplicationController
  def index
    @articles = Article.order("created_at desc")
  end
  
  def search
    @articles = Article.search(params[:query])
  end

  def show
    @article = Article.find(params[:id])
  end

  def post_receive_hook
    Article.post_receive(params[:payload])
  end
end
