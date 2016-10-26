module Media
  # remove listings that are old, duplicated, already persisted, etc.
  class Cleaner
    attr_reader :posts

    def initialize(posts)
      @posts = posts
    end

    def cleaned
      posts.uniq { |post| post[:text] }
           .select { |post| Media::Validator.new(post).valid? }
    end
  end
end
