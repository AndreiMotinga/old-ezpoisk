# creates listings from posts provided by vk and fb importers
class VkCreator
  def initialize(post, group, delay)
    @delay = delay + 5
    @user_id = 181 # ez
    @state_id = group[:state_id]
    @city_id = group[:city_id]
    @model = group[:model]
    @category = group[:category]
    @text = ActionView::Base.full_sanitizer.sanitize(post[:text])
    @date = Time.at(post[:date])
    @author = post[:from_id]
    @vk = "https://vk.com/id#{@author}"
    create_post
  end

  def create_post
    return unless should_create?
    case @model
    when "Job"
      record = create_job
    when "RePrivate"
      record = create_re_private
    end
    return unless record.id
    record.create_entry(user: record.user)
    GeocodeJob.perform_async(record.id, record.class.to_s)
    SlackNotifierJob.perform_async(record.id, record.class.to_s)
    VkUserNotifierJob.perform_in(@delay.minutes, @author, record.id, record.class.to_s)
  end

  def should_create?
    return false if @text.match(/\[\w.+\]/).present? # post is a response
    return false if @model.constantize.find_by_text(@text) # post already exists
    record = @model.constantize.find_by_vk(@vk)
    return false if record.try(:fresh?)
    true
  end

  def create_job
    Job.create(
      title: Title.new(@text).title,
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
end
