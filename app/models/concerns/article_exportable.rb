# frozen_string_literal: true

module ArticleExportable
  extend ActiveSupport::Concern

  module ClassMethods
  end

  included do
    def listing?; end

    def article?
      true
    end

    def city_slug
      City.where(slug: tag_list).first&.slug
    end
  end
end
