require "rails_helper"

describe CommentMailer do
  describe "new_comment" do
    it "" do
      rp = create :listing
      comment = create :comment, commentable: rp
      CommentMailer.new_comment(comment, rp.contact_email).deliver_now

      delivery = deliveries.first

      expect(deliveries.count).to eq 1
      expect(delivery.to).to eq [rp.contact_email]
      expect(delivery.from).to eq ["ez@ezpoisk.com"]
      title = "eZpoisk - новый комментарий под: #{rp.title}"
      expect(delivery.subject).to eq title
    end
  end
end
