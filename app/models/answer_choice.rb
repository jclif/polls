class AnswerChoice < ActiveRecord::Base
  attr_accessible :text, :question_id

  validates :question_id :presence => true
  validates :text :presence => true

  belongs_to (
    :question,
    class_name: 'Question',
    foreign_key: :question_id,
    primary_key: :id
  )

  # has_many (
  #   :response,
  #   class_name: 'AnswerChoice',
  #   foreign_key: :question_id,
  #   primary_key: :id
  # )

end