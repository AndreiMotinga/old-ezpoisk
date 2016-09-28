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
    src = atts['data'][0]['media']['image']['src']
    [src]
  end
end
