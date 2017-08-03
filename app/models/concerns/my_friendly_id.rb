module MyFriendlyId
  def self.included(klass)
    klass.extend FriendlyId

    klass.class_eval do
      friendly_id :title, use: [:slugged, :finders]
      def normalize_friendly_id(text)
        text.to_slug.normalize(transliterations: :russian).to_s
      end

      def should_generate_new_friendly_id?
        slug.blank?
      end
    end
  end
end
