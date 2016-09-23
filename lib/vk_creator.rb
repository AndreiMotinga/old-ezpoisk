# creates listings from posts provided by vk and fb importers
class VkCreator
  def initialize(post, group)
    @user_id = 181 # ez
    @state_id = group[:state_id]
    @city_id = group[:city_id]
    @model = group[:model]
    @text = ActionView::Base.full_sanitizer.sanitize(post[:text])
    @date = Time.at(post[:date])
    @author = post[:from_id]
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
    VkNotifier.new.send_message(@author, record)
  end

  def should_create?
    return false if @model.constantize.find_by_text(@text) # post already exists
    return false if @text.match(/\[\w.+\]/).present? # post is a response
    true
  end

  def create_job
    Job.create(
      title: Title.new(@text).title,
      category: "wanted",
      active: true,
      text: @text,
      state_id: @state_id,
      city_id: @city_id,
      user_id: @user_id,
      updated_at: @date,
      vk: "https://vk.com/id#{@author}"
    )
  end
end
