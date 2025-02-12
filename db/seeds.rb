# Create a test user
users_per_day = 5
start_date = Time.current.beginning_of_month.to_date
end_date = Time.current.end_of_month.to_date

(start_date..end_date).each do |date|
  users_per_day.times do
    p "Creating a user for #{date}}"
    User.create!(
      email: Faker::Internet.email,
      password: 'password',
      password_confirmation: 'password',
      created_at: date.beginning_of_day
    )
  end
end

# Create a test post
posts_per_day = 10

(start_date..end_date).each do |date|
  posts_per_day.times do
    p "Creating a post for #{date}}"
    Post.create!(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
      views: rand(100..1000),
      created_at: date.beginning_of_day
    )
  end
end
