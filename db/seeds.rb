Article.destroy_all
Comment.destroy_all
User.destroy_all

User.create(first_name: "Briana",
            last_name: "West",
            email: "bmwest@bu.edu",
            password: "admin1234",
            role: "admin")

User.create(first_name: "Troll",
            last_name: "Trollerson",
            email: "test@testemail6789.com",
            password: "troll12345")

3.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: Faker::Internet.password)
end

12.times do
  Article.create(title: Faker::Hipster.word,
                body: Faker::Hipster.paragraph,
                user: User.all.sample)
end

5.times do
  Article.create(title: Faker::Hipster.word,
                body: Faker::Hipster.paragraph,
                user: User.where(role: "admin")[0])
end

12.times do
  Comment.create(body: Faker::ChuckNorris.fact,
                article: Article.all.sample,
                user: User.all.sample)
end

16.times do
  Comment.create(body: Faker::ChuckNorris.fact,
                article: Article.all.sample,
                commenter: Faker::Name.first_name)
end
