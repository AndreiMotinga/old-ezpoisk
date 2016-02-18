class Question < ActiveRecord::Base
  is_impressionable
  belongs_to :user
  has_many :answers

  validates :title, presence: true

  def self.by_keyword(keyword)
    return all if keyword.blank?
    keys = convert_keyword(keyword)
    query = "LOWER(title) ILIKE ANY (array[?]) OR LOWER(text) ILIKE ANY (array[?])"
    where(query, keys, keys)
  end

  def self.term_for(term)
    qs = where("LOWER(title) LIKE ?", "%#{term.mb_chars.downcase}%")
    qs = qs.limit(10).pluck(:title, :id)
    qs.map!{ |q| { value: "/questions/#{q[1]}", label: q[0]}}
    qs << { value: "/questions?keyword=#{term}", label: "Искать:  \"#{term}\"" }
  end

  def self.unanswered
    where('id NOT IN (SELECT DISTINCT(question_id) FROM answers)')
  end

  def self.answered
    where('id IN (SELECT DISTINCT(question_id) FROM answers)')
  end

  def self.convert_keyword(keyword)
    keyword.gsub(/[^0-9a-zа-я ]/i, "")
      .split(" ")
      .map { |key| "%#{key.mb_chars.downcase}%" }
  end

  def the_answer
    answers.the_answer
  end

  def text_to_show
    return the_answer.text if the_answer.present?
    text
  end
end
