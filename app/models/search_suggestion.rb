class SearchSuggestion < ActiveRecord::Base

  def self.term_for(prefix)
    where("lower(term) like ?", "%#{prefix.mb_chars.downcase}%")
      .order("popularity desc")
      .limit(10)
      .pluck(:term, :id)
      .map {|q| {value: "www.google.com", label: q.title}}
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
