class Response < ActiveRecord::Base
  attr_accessible :user_id, :answer_choice_id

  validates :user_id :presence => true
  validates :answer_choice_id :presence => true

  belongs_to (
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to (
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

end