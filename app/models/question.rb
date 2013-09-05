class Question < ActiveRecord::Base
  attr_accessible :text, :poll_id

  validates :poll_id, :presence => true
  validates :text, :presence => true

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  def results
    answers = self.answer_choices.includes(:responses)
    answer_counts = {}

    answers.each do |answer|
      answer_counts[answer.text] = answer.responses.length
    end

    answer_counts
  end

end