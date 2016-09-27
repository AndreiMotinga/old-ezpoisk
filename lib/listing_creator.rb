# creates listings from posts provided by vk and fb importers
class ListingCreator
  def initialize(post, group, delay)
    @delay = delay + 5
    @user_id = 181 # ez
    @state_id = group[:state_id]
    @city_id = group[:city_id]
    @model = group[:model]
    @category = group[:category]
    @text = sanitize_text(post[:text])
    @date = Time.at(post[:date])
    @author = post[:from_id]
    @vk = "https://vk.com/id#{@author}"
    @attachments = post[:attachments]
    start
  end

  def start
    return unless TextChecker.new(@model, @text, @vk).cool?
    create_post
    return unless @rec
    create_attachments
    run_notifications
  end

  def run_notifications
    @rec.create_entry(user: @rec.user)
    GeocodeJob.perform_async(@id, @model)
    SlackNotifierJob.perform_async(@id, @model)
    VkUserNotifierJob.perform_in(@delay.minutes, @author, @id, @model)
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
    @id = @rec.id
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
      vk: @vk
    )
  end

  def create_attachments
    return if @model == "Job"
    pics = VkImages.new(@attachments).images
    return if pics.empty?
    VkImageCreatorJob.perform_async(pics, @id, @model)
  end

  def sanitize_text(text)
    text.gsub("<br>", "\n")
        .gsub(/[\u{1F600}-\u{1F6FF}]/, "") # remove emojis
  end
end
