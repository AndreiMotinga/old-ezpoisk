# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(term)
      term.blank? ? all : pg_search(term)
    end
  end

  included do
    include PgSearch
    pg_search_scope :pg_search,
                    against: [:title, :text],
                    using: { tsearch: { dictionary: "russian" } }
    multisearchable against: [:title, :text]
  end
end
