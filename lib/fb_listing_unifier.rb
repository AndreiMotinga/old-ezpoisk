# changes post received from fb api
class FbListingUnifier
  attr_reader :post

  def initialize(post)
    @post = HashWithIndifferentAccess.new(
      date: post["created_time"],
      text: PostSanitizer.new(post["message"]).clean,
      vk: "",
      fb: "https://www.facebook.com/#{post['from']['id']}",
      attachments: attachments(post['attachments'])
    )
  end


  private

  def attachments(atts)
    return [] unless atts.present?
    data = atts['data'].first
    return media(data) if data["media"]
    return subattachments(data) if data["subattachments"]
    []
  end

  def media(data)
    src = data['media']['image']['src']
    [src]
  end

  def subattachments(data)
    data = data["subattachments"]["data"]
    data.map { |obj| obj["media"]["image"]["src"] }
  end
end
