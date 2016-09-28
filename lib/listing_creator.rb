# creates listings from posts provided by vk and fb importers
class ListingCreator
  def initialize(post, group, delay)
    @user_id = 181 # ez
    @delay = delay + 5

    @state_id = group[:state_id]
    @city_id = group[:city_id]
    @model = group[:model]
    @category = group[:category]

    @text = sanitize_text(post[:text])
    @date = post[:date]
    @attachments = post[:attachments]
    @author = post[:from_id]
    @vk = post[:vk]
    @fb = post[:fb]

    start
  end

  def start
    return unless TextChecker.new(@model, @text, @vk, @fb).cool?
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
    VkUserNotifierJob.perform_in(@delay.minutes, @author, @rec.id, @model)
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
      title: Title.new(@text, "Работа").title,
      category: @category,
      active: true,
      text: @text,
      state_id: @state_id,
      city_id: @city_id,
      user_id: @user_id,
      updated_at: @date,
      fb: @fb,
      vk: @vk
    )
  end

  def create_re_private
    @rec = RePrivate.create(
      post_type: "leasing",
      duration: "monthly",
      category: "apartment",
      rooms: "room",
      active: true,
      text: @text,
      user_id: @user_id,
      state_id: @state_id,
      city_id: @city_id,
      updated_at: @date,
      fb: @fb,
      vk: @vk
    )
  end

  def create_sale
    @rec = Sale.create(
      title: Title.new(@text, "Продаю").title,
      category: "sales",
      text: @text,
      active: true,
      user_id: @user_id,
      state_id: @state_id,
      city_id: @city_id,
      updated_at: @date,
      fb: @fb,
      vk: @vk
    )
  end

  def create_attachments
    return if @model == "Job"
    return unless @attachments.any?
    VkImageCreatorJob.perform_async(@attachments, @rec.id, @model)
  end

  def sanitize_text(text)
    text.gsub("<br>", "\n")
        .gsub(/[\u{1F600}-\u{1F6FF}]/, "") # remove emojis
  end
end
