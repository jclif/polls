class Poll < ActiveRecord::Base
  attr_accessible :user_name, :title

  validates :user_name :presence => true

  belongs_to (
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :questions,
    class_name: 'Question',
    foreign_key: :poll_id,
    primary_key: :id
  )

end