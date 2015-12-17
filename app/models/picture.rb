class Picture < ActiveRecord::Base
  # after_commit :resize_image
  # before_destroy :unset_logo

  belongs_to :imageable, polymorphic: true

  # private
  #   def resize_image
  #     ImageResizeJob.perform_async(self.id)
  #   end
  #
  #   def unset_logo
  #     post = self.imageable
  #     if post.try(:picture_id) == self.id
  #       post.picture_id = nil
  #       post.save
  #     end
  #   end
end
