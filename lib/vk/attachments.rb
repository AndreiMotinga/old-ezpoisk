# frozen_string_literal: true

module Vk
  # unifiies vk post attachments
  class Attachments
    attr_reader :files

    def initialize(files)
      @files = files
    end

    def attachments
      return [] if files.blank?
      files.map { |file| largest_image(file[:photo]) }.compact
    end

    private

    def largest_image(photo)
      return unless photo
      largest = photo.keys.select { |key| key =~ /photo/ }.last
      photo[largest]
    end
  end
end
