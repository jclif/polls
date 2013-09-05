class Response < ActiveRecord::Base
  attr_accessible :user_id, :answer_choice_id

  validate :respondent_has_not_already_answered_question
  validate :respondent_isnt_the_author
  validates :user_id, :presence => true
  validates :answer_choice_id, :presence => true

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  def respondent_isnt_the_author

    # returns author of question to which the response responds
    result = User.find_by_sql [<<-SQL, user_id]
    SELECT DISTINCT
    users.*

    FROM
      users
    JOIN
      polls
    ON
      polls.user_id = users.id
    JOIN
      questions
    ON
      questions.poll_id = polls.id
    JOIN
      answer_choices
    ON
      answer_choices.question_id = questions.id
    JOIN
      responses
    ON
      responses.answer_choice_id = answer_choices.id

    WHERE
      users.id = ?

    SQL

      errors.add(:user_id, " cannot answer their own question") unless result.empty?

  end

  def respondent_has_not_already_answered_question
    if existing_responses.empty?
      return true
    end

    if existing_responses.count == 1 && existing_responses.first.id == id
      return true
    end

    errors.add(:user_id, " has already answered this question")

  end

  private

  def existing_responses
    #returns an array of reponses

    Response.find_by_sql [<<-SQL, user_id]
      SELECT
        *
      FROM
        answer_choices
      WHERE
        answer_choices.question_id IN (
          --CURRENT_RESPONSE.ANSWER_CHOICE.QUESTION_ID  IN  (

          --this returns an array of all q_id of questions to which
          -- current user has responded
          SELECT
            answer_choices.question_id -- as q_id , user_id as u_id
          FROM
            answer_choices
          JOIN
            responses
          ON
            responses.answer_choice_id = answer_choices.id
          WHERE
            responses.user_id = ?
    )

      SQL



    # Response.find_by_sql [<<-SQL, user_id]
    #   SELECT
    #     *
    #   FROM
    #     responses
    #   JOIN
    #     answer_choices
    #   ON
    #     responses.answer_choice_id = answer_choices.id
    #
    #   WHERE
    #     answer_choices.question_id IN (
    #       --CURRENT_RESPONSE.ANSWER_CHOICE.QUESTION_ID  IN  (
    #
    #       --this returns an array of all q_id of questions to which
    #       -- current user has responded
    #       SELECT
    #         answer_choices.question_id -- as q_id , user_id as u_id
    #       FROM
    #         answer_choices
    #       JOIN
    #         responses
    #       ON
    #         responses.answer_choice_id = answer_choices.id
    #       WHERE
    #         responses.user_id = ?
    # )
    #   -- AND
    #   -- responses.user_id = u_id
    #
    #   SQL

  end

end