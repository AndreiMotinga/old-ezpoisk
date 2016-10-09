require "rails_helper"

describe SocialTagCreator do
  describe ".create_tags" do
    it "adds tags to record" do
      job = create :job, text: "Ищем на работу электрики"
      ActsAsTaggableOn::Tag.create(name: "электрики")
      ActsAsTaggableOn::Tag.create(name: "foo")

      SocialTagCreator.create_tags(job)

      expect(job.cached_tags).to eq "электрики"
    end

    it "handes dashes" do
      job = create :job, text: "Ищем на работу на front desc"
      ActsAsTaggableOn::Tag.create(name: "front-desc")
      ActsAsTaggableOn::Tag.create(name: "foo")

      SocialTagCreator.create_tags(job)

      expect(job.cached_tags).to eq "front-desc"
    end

    it "doesn't account for prepositions" do
      job = create :job, text: "Ищем на работу на front desc"
      ActsAsTaggableOn::Tag.create(name: "авто-на-аренду")

      SocialTagCreator.create_tags(job)

      expect(job.cached_tags).to eq ""
    end

    it "handes case" do
      job = create :job, text: "Ищем на работу в Офис"
      ActsAsTaggableOn::Tag.create(name: "офис")

      SocialTagCreator.create_tags(job)

      expect(job.cached_tags).to eq "офис"
    end

    it "doesn't add tag 'работа'" do
      job = create :job, text: "Ищем на работа в Офис"
      ActsAsTaggableOn::Tag.create(name: "удаленная-работа")
      ActsAsTaggableOn::Tag.create(name: "офис")

      SocialTagCreator.create_tags(job)

      expect(job.cached_tags).to eq "офис"
    end
  end
end
