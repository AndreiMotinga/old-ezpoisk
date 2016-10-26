module Vk
  # unifiies vk post attachments
  class Attachments
    attr_reader :files

    def initialize(files)
      @files = files
    end

    def attachments
      return [] if files.blank?
      files.map { |file| largest_image(file) }.compact
    end

    private

    def largest_image(file)
      return if file[:type] != "photo"
      return file[:photo][:src_xxxbig] if file[:photo][:src_xxxbig].present?
      return file[:photo][:src_xxbig] if file[:photo][:src_xxbig].present?
      file[:photo][:src_xbig]
    end
  end
end
