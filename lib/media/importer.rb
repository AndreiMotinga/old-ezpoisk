# frozen_string_literal: true

module Media
  # imports vk posts
  class Importer
    attr_reader :file, :loader

    def self.import(file, loader)
      new(file, loader).import
    end

    def initialize(file, loader)
      @file = file
      @loader = loader
    end

    def import
      groups = Media::Groups.from(file)
      groups.map! { |group| loader.load(group) }
            .flatten!
            .uniq! { |post| post[:attributes][:text] }
            .select! { |post| Media::Validator.valid?(post[:attributes]) }
            .map! { |post| Media::Creator.create(post) }
            .size
    end
  end
end
