# frozen_string_literal: true

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

    def posts
      groups.map! { |group| loader.new(group).data }
            .flatten
            .uniq { |post| post[:attributes][:text] }
    end

    def valid_posts
      posts.select { |post| Media::Validator.new(post[:attributes]).valid? }
    end
  end
end
