# frozen_string_literal: true

module Fb
  class Attachments
    attr_reader :atts, :data

    def initialize(atts)
      @atts = atts
    end

    def attachments
      return [] if atts.blank?
      @data ||= atts["data"].first
      return media if data["media"]
      return subattachments if data["subattachments"]
      []
    end

    private

    def media
      src = data["media"]["image"]["src"]
      [src]
    end

    def subattachments
      items = data["subattachments"]["data"]
      items.map do |obj|
        next if obj["media"].blank?
        obj["media"]["image"]["src"]
      end
    end
  end
end
