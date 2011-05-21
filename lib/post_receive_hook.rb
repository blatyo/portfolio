module PostReceiveHook
  def post_receive(push)
    @push = Push.new(push)
  end
  
  class Push
    def initialize(push)
      @push = push
    end
    
    def owner
      @owner ||= JsonPath.new('$..owner.name').on(@push).to_a.first
    end
    
    def new_files 
      return @new_files if defined? @new_files
      
      @new_files = []
      JsonPath.new('$..commits').on(@push).to_a.each do |commit|
        @new_files -= JsonPath.new('$..removed').on(commit).to_a.flatten
        @new_files += JsonPath.new('$..added').on(commit).to_a.flatten
        @new_files.uniq!
      end
      
      @new_files
    end
    
    def updated_files
      @updated_files ||= (JsonPath.new('$..modified').on(commit).to_a.flatten - (new_files + deleted_files))
    end
    
    def deleted_files
      return @deleted_files if defined? @deleted_files
      
      @deleted_files = []
      JsonPath.new('$..commits').on(@push).to_a.each do |commit|
        @deleted_files -= JsonPath.new('$..added').on(commit).to_a.flatten
        @deleted_files += JsonPath.new('$..removed').on(commit).to_a.flatten
        @deleted_files.uniq!
      end
      
      @deleted_files
    end
  end
end