module Media
  # imports vk posts
  class Importer
    attr_reader :file, :loader

    def initialize(file, loader)
      @file = file
      @loader = loader
    end

    def import
      valid_posts.each { |post| Media::Creator.new(post).create }
    end

    private

    def groups
      Media::Groups.new(file).groups
    end

    def data
      groups.map! { |group| loader.new(group).data }.flatten
    end

    def valid_posts
      Media::Cleaner.new(data).cleaned
    end
  end
end
