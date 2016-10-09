# changes post received from vk api
class VkListingUnifier
  attr_reader :post

  def initialize(post)
    @post = HashWithIndifferentAccess.new(
      date: Time.at(post[:date]),
      text: SocialTextSanitizer.clean(post[:text]),
      vk: "https://vk.com/id#{post[:from_id]}",
      fb: "",
      attachments: attachments(post[:attachments])
    )
  end

  private

  def attachments(atts)
    return [] unless atts.present?
    atts.map { |file| largest_image(file) }.compact
  end

  def largest_image(file)
    return if file[:type] != "photo"
    return file[:photo][:src_xxxbig] if file[:photo][:src_xxxbig].present?
    return file[:photo][:src_xxbig] if file[:photo][:src_xxbig].present?
    file[:photo][:src_xbig]
  end
end
