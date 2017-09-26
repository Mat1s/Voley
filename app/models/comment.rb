class Comment < ApplicationRecord
  belongs_to :pcomment, polymorphic: true
  belongs_to :user
  has_many :nested_comments, class_name: "Comment", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Comment"

  def destroy_body
  	self.update_columns(body: "This comment was deleted at #{Time.zone.now}",
  	deleted_at: Time.zone.now, deleted: true)
  end
end
