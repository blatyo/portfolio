class CommentsCell < Cell::Rails

  def index
    @short_name = configatron.disqus.short_name
    @article_id = params[:id]
    @url = request.url
    @developer = configatron.disqus.developer
    render
  end

end
