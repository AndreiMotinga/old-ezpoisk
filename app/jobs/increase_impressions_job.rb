class IncreaseImpressionsJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    daily.hour_of_day([1, 4, 6, 10, 13, 15, 18, 19, 20, 21, 23])
  end

  def perform
    return unless Rails.env.production?
    increase_models
    increase_qs
  end

  def increase_models
    models.each do |model|
      increase_records_of(model)
    end
  end

  def increase_records_of(model)
    model.find_each do |record|
      bool = [true, true, false].sample
      record.increment!(:impressions_count) if bool
    end
  end

  def increase_qs
    Question.find_each do |question|
      bool = [true, true, false].sample
      if bool
        question.increment!(:impressions_count)
        question.answers.find_each do |answer|
          answer.increment!(:impressions_count)
        end
      end
    end
  end

  def models
    [ReAgency, RePrivate, ReFinance, Job, JobAgency, Service, Sale]
  end
end
