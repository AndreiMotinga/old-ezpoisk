# creates listings from posts provided by vk and fb importers
class SocialListingCreator
  def initialize(post, group)
    @post = post
    @group = group
    @model = group[:model]
  end

  def create
    create_post
    do_maintenance
    run_notifications
  end

  def create_post
    case @model
    when "Job"
      create_job
    when "RePrivate"
      create_re_private
    when "Sale"
      create_sale
    end
  end

  def do_maintenance
    @rec.create_entry(user: @rec.user)
    SocialTagCreatorJob.perform_async(@rec.id, @model) if @model == "Job"
    return if @model == "Job" || @post[:attachments].empty?
    ImageDownloaderJob.perform_async(@post[:attachments], @rec.id, @model)
  end

  def run_notifications
    SlackNotifierJob.perform_in(1.minute, @rec.id, @model)
    GeocodeJob.perform_in(1.minute, @rec.id, @model)
    SocialUserNotifierJob.perform_in(3.minutes, @rec.id, @model)
  end

  def create_job
    @rec = Job.create(
      title: title,
      category: @group[:category] || "wanted",
      active: true,
      text: @post[:text],
      state_id: @group[:state_id],
      city_id: @group[:city_id],
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
      state_id: @group[:state_id],
      city_id: @group[:city_id],
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
      state_id: @group[:state_id],
      city_id: @group[:city_id],
      created_at: @post[:date],
      fb: @post[:fb],
      vk: @post[:vk]
    )
  end

  private

  def title
    TitleFromText.get(@post[:text])
  end
end
