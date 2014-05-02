namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
  admin = User.create!(name: "Example User",
                        aka: "aka",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      aka = "aka-#{n+1}"
      password  = "password"
      User.create!(name: name,
                   aka: aka,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end