# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create({
  user_name: "clement"
})

u2 = User.create({
  user_name: "Jared"
})

p1 = Poll.create({
  title: "baguette",
  user_id: u1.id
})

p2 = Poll.create({
  title: "pizza",
  user_id: u2.id
})

q1 = Question.create({
  text: "Are they fresh?",
  poll_id: p1.id
})

q2 = Question.create({
  text: "Is it pepperoni?",
  poll_id: p2.id
})

a1 = AnswerChoice.create({
  text: "So fresh, so clean.",
  question_id: q1.id
})

a2 = AnswerChoice.create({
  text: "Not so fresh.",
  question_id: q1.id
})

a3 = AnswerChoice.create({
  text: "So very pepperoni.",
  question_id: q2.id
})

r1 = Response.create!({
  user_id: u1.id,
  answer_choice_id: a1.id
})

r2 = Response.create!({
  user_id: u2.id,
  answer_choice_id: a1.id
})

r3 = Response.create!({
  user_id: u1.id,
  answer_choice_id: a1.id
})



