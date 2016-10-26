module Media
  class TagCreator
    def self.create_tags(job)
      ActsAsTaggableOn::Tag.find_each do |tag|
        job.tag_list << tag if matching?(tag, job)
      end
      job.save
      job.update_cached_tags
    end

    def self.matching?(tag, job)
      tag.name.split("-")
         .any? { |word| Job.where(id: job.id).search(word).any? }
    end
  end
end
