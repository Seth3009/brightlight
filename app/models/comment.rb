class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  after_save :send_notification

  def send_notification
    email = self.commentable.create_email_from_comment(self)
    email.deliver_now
    notification = Message.new_from_email(email)
    notification.save
  end
end
