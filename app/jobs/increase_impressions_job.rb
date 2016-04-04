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
        record.update_attribute(:impressions_count, record.impressions_count+1)
      end
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
