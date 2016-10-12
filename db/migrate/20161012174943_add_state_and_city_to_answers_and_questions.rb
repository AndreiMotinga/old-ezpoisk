class AddStateAndCityToAnswersAndQuestions < ActiveRecord::Migration[5.0]
  def change
    add_reference :answers, :city
    add_reference :answers, :state
    add_reference :questions, :city
    add_reference :questions, :state
  end
end
