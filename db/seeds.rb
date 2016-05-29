require 'random_data'

#Seed Posts
50.times do
  Post.create!(
  title:  RandomData.random_sentence,
  body:   RandomData.random_paragraph
  )
end
posts = Post.all

#Seed Comments
100.times do
  Comment.create!(
  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

#Seed questions
100.times do
  Question.create!(
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph,
  resolved: false
  )
end


puts "Seed Finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Question.count} questions created"
