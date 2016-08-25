class IncreasePriorityWithLogoJob
  include Sidekiq::Worker
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

Sidekiq::Cron::Job.create(name: "priority job",
                          cron: "0 1 * * *",
                          class: "IncreasePriorityWithLogoJob")
