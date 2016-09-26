# creates listings from posts provided by vk and fb importers
class VkCreator
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
    create_post
  end

  def create_post
    return unless TextChecker.new(@text, @model).is_cool?
    case @model
    when "Job"
      record = create_job
    when "RePrivate"
      record = create_re_private
      create_attachments(record)
    when "Sale"
      record = create_sale
      create_attachments(record)
    end
    return unless record.id
    record.create_entry(user: record.user)
    GeocodeJob.perform_async(record.id, record.class.to_s)
    SlackNotifierJob.perform_async(record.id, record.class.to_s)
    VkUserNotifierJob.perform_in(@delay.minutes, @author, record.id, record.class.to_s)
  end

  def create_job
    Job.create(
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
    RePrivate.create(
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
    Sale.create(
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

  def create_attachments(record)
    return unless @attachments
    VkImageCreatorJob.perform_async(biggest_image, record.id, record.class.to_s)
  end

  def biggest_image
    @attachments.map do |f|
      next if f[:type] != "photo"
      xxx = f[:photo][:src_xxxbig]
      xx = f[:photo][:src_xxbig]
      x = f[:photo][:src_xbig]
      if xxx.present?
        xxx
      elsif xx.present?
        xx
      else
        x
      end
    end
  end

  def sanitize_text(text)
    text.gsub("<br>", "\n")
        .gsub(/[\u{1F600}-\u{1F6FF}]/, "") # remove emojis
  end
end
