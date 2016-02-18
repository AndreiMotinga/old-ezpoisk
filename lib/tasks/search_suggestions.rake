namespace :search_suggestions do
  desc "Generate search suggestions from questions"
  task :index => :environment do
    SearchSuggestion.index_questions
  end
end
