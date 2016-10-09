class SocialTagCreator
  def self.create_tags(rec)
    text = rec.text.mb_chars.downcase.to_s
    tags = ActsAsTaggableOn::Tag.all.map {|t| matching?(t, text)}
    rec.update_attribute(:tag_list, tags)
    rec.update_cached_tags
  end

  def self.matching?(tag, text)
    tag if tag.name
              .split("-")
              .select { |word| word.size > 3 } # remove prepositions
              .reject { |word| GENERIC_WORDS.include?(word) }
              .any? { |word| text.include?(word) }
  end

  GENERIC_WORDS = [
    "работа"
  ]
end
