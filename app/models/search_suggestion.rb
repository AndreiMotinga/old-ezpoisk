class SearchSuggestion < ActiveRecord::Base

  def self.term_for(prefix)
    suggestions = where("lower(term) like ?", "%#{prefix.mb_chars.downcase}%")
    suggestions.order("popularity desc").limit(10).pluck(:term)
  end

  def self.index_questions
    Question.find_each do |question|
      index_term(question.title)
      question.title.split.each { |t| index_term(t) }
    end
  end

  def self.index_term(term)
    where(term: term.downcase).first_or_initialize.tap do |suggestion|
      suggestion.increment! :popularity
    end
  end
end
