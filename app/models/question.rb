class Question < ActiveRecord::Base
  is_impressionable
  belongs_to :user
  has_many :answers

  def self.by_keyword(keyword)
    return all if keyword.blank?
    keys = convert_keyword(keyword)
    query = "LOWER(title) ILIKE ANY (array[?]) OR LOWER(text) ILIKE ANY (array[?])"
    where(query, keys, keys)
  end

  def self.unanswered
    where('id NOT IN (SELECT DISTINCT(question_id) FROM answers)')
  end

  def self.answered
    where('id IN (SELECT DISTINCT(question_id) FROM answers)')
  end

  def self.convert_keyword(keyword)
    keyword.gsub(/[^0-9a-z ]/i, "")
      .split(" ")
      .map { |key| "%#{key.mb_chars.downcase}%" }
  end

  def the_answer
    answers.the_answer
  end
end
