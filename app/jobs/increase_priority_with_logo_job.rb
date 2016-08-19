class IncreasePriorityWithLogoJob
  def perform
    [RePrivate, Sale].each do |model|
      model.find_each do |record|
        if record.logo.present? and record.priority == 0
          record.update_column(:priority, 1)
        end
      end
    end
  end
end

Sidekiq::Cron::Job.create(name: "IncreasePriorityWithLogoJob 0 1 * * *",
                          cron: "0 1 * * *",
                          class: "DataAggregatorJob")
