# creates listings from posts provided by vk and fb importers
module Media
  class Creator
    def initialize(post)
      @post = post
      @model = post[:model]
    end

    def create
      create_post
      do_maintenance
    end

    def create_post
      case @model
      when "Job" then create_job
      when "RePrivate" then create_re_private
      when "Sale" then create_sale
      end
    end

    def do_maintenance
      @rec.create_entry(user: @rec.user)
      MediaTagCreatorJob.perform_async(@rec.id, @model) if @model == "Job"
      SlackNotifierJob.perform_in(2.minute, @rec.id, @model)
      SocialUserNotifierJob.perform_in(10.minutes, @rec.id, @model)
      return if @model == "Job" || @post[:attachments].empty?
      ImageDownloaderJob.perform_async(@post[:attachments], @rec.id, @model)
    end

    def create_job
      @rec = Job.create(
        title: title,
        category: "other",
        active: true,
        post_type: "wanted",
        text: @post[:text],
        state_id: @post[:state_id],
        city_id: @post[:city_id],
        user_id: 1,
        created_at: @post[:date],
        fb: @post[:fb],
        vk: @post[:vk]
      )
    end

    def create_re_private
      @rec = RePrivate.create(
        post_type: "leasing",
        duration: "monthly",
        category: "apartment",
        rooms: "room",
        baths: 1,
        active: true,
        fee: true,
        text: @post[:text],
        user_id: 1,
        state_id: @post[:state_id],
        city_id: @post[:city_id],
        created_at: @post[:date],
        fb: @post[:fb],
        vk: @post[:vk]
      )
    end

    def create_sale
      @rec = Sale.create(
        title: title,
        category: "sale",
        post_type: "selling",
        text: @post[:text],
        active: true,
        user_id: 1,
        state_id: @post[:state_id],
        city_id: @post[:city_id],
        created_at: @post[:date],
        fb: @post[:fb],
        vk: @post[:vk]
      )
    end

    def title
      Media::Title.get(@post[:text])
    end
  end
end
