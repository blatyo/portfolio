class CommentsCell < Cell::Rails

  def index
    @short_name = configratron.disqus.short_name
    render
  end

end
