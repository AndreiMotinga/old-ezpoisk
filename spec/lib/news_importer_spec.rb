# require "rails_helper"
#
# describe "NewsImporter" do
#   it "imports news" do
#     user = create(:user, id: 1)
#     stub_xml
#
#     NewsImporter.import
#     result = Post.invisible.count
#
#     expect(result).to_not eq 0
#   end
#
#   def stub_xml
#     NEWS_CATEGORIES.each do |link|
#       stub_request(:get, link).to_return(status: 200, :body => file)
#     end
#   end
#
#   def file
#     File.new("#{Rails.root}/spec/support/fixtures/posts/yandex_auto.xml").read
#   end
# end
