# creates listings from posts provided by vk and fb importers
class ListingCreator
  def initialize(post, group, delay)
    @post = post
    @group = group
    @delay = delay + 3
    @model = group[:model]
  end

  def create
    return unless PostChecker.new(@model, @post).cool?
    create_post
    puts "ANDREI: #{@rec.errors.messages}" if @rec.errors.any?
    return unless @rec.id # id == saved
    create_attachments
    run_notifications
  end

  def run_notifications
    @rec.create_entry(user: @rec.user)
    GeocodeJob.perform_async(@rec.id, @model)
    SlackNotifierJob.perform_async(@rec.id, @model)
    VkUserNotifierJob.perform_in(@delay.minutes, @post[:from_id], @rec.id, @model)
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

  def create_job
    @rec = Job.create(
      title: Title.new(@post[:text], "Работа").title,
      category: @group[:category],
      active: true,
      text: @post[:text],
      state_id: @group[:state_id],
      city_id: @group[:city_id],
      user_id: 181,
      updated_at: @post[:date],
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
      active: true,
      text: @post[:text],
      user_id: 181,
      state_id: @group[:state_id],
      city_id: @group[:city_id],
      updated_at: @post[:date],
      fb: @post[:fb],
      vk: @post[:vk]
    )
  end

  def create_sale
    @rec = Sale.create(
      title: Title.new(@post[:text], "Продаю").title,
      category: "sales",
      text: @post[:text],
      active: true,
      user_id: 181,
      state_id: @group[:state_id],
      city_id: @group[:city_id],
      updated_at: @post[:date],
      fb: @post[:fb],
      vk: @post[:vk]
    )
  end

  def create_attachments
    return if @model == "Job"
    return unless @post[:attachments].any?
    ImageDownloaderJob.perform_async(@post[:attachments], @rec.id, @model)
  end
end
