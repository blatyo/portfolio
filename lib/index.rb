module Index
  class << self
    def get(name)
      api.indexes(name)
    end
  
    private
  
    def api
      @api ||= IndexTank::Client.new(configatron.indextank.api_url)
    end
  end
end