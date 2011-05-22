module PostReceiveHook
  extend ActiveSupport::Concern
  
  module ClassMethods
    attr_reader :push
    
    def post_receive(push)
      @push = Push.new(push)
    end
  end
  
  class Push
    def initialize(push)
      @push = JSON.parse(push)
      @called_group_files = false
    end
    
    def owner
      @owner ||= JsonPath.new('$..owner.name').on(@push).to_a.first
    end
    
    def repository
      @repository ||= JsonPath.new('$..repository.name').on(@push).to_a.first
    end
    
    def new_files
      group_files
      
      @new_files
    end
    
    def updated_files
      group_files
      
      @updated_files
    end
    
    def deleted_files
      group_files
      
      @deleted_files
    end
    
    private
    
    def group_files
      return if @called_group_files
      @new_files, @updated_files, @deleted_files = [], [], []
      file_changes.each do |file_name, changes|
        if changes.last == :removed
          @deleted_files << file_name
        elsif changes.first == :added
          @new_files << file_name
        else
          @updated_files << file_name
        end
      end
      
      @called_group_files = true
    end
    
    def file_changes
      changes = Hash.new{|h, k| h[k] = []}
      
      JsonPath.new('$..commits').on(@push).to_a.each do |commit|
        p commit
        [:added, :modified, :removed].each do |change|
          JsonPath.new("$..#{change}").on(commit).to_a.flatten.each do |file_name|
            p file_name
            changes[file_name] << :change
          end
        end
      end
      
      p changes
      
      changes
    end
  end
end