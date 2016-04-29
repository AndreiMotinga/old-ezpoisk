class IncreaseImpressionsJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    hourly
  end

  def perform
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
      if bool && record.active
        record.update_column(:impressions_count, record.impressions_count+1)
      end
    end
  end

  def increase_qs
    Question.find_each do |question|
      bool = [true, true, false].sample
      if bool
        question.update_column(:impressions_count, question.impressions_count+1)
        question.answers.find_each do |answer|
          answer.update_column(:impressions_count, answer.impressions_count+1)
        end
      end
    end
  end

  def models
    [ReAgency, RePrivate, Job, Service, Sale]
  end
end
