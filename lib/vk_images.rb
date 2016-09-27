class VkImages
  def initialize(attachments)
    @attachments = attachments
  end

  def images
    @attachments.map { |file| largest_image(file) }.compact
  end

  private

  def largest_image(file)
    return if file[:type] != "photo"
    return file[:photo][:src_xxxbig] if file[:photo][:src_xxxbig].present?
    return file[:photo][:src_xxbig] if file[:photo][:src_xxbig].present?
    file[:photo][:src_xbig]
  end
end
