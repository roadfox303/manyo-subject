FactoryBot.define do
  factory :user, class: User do
    name {"テストユーザー"}
    email {"test@gmail.com"}
    password_digest {"password"}
  end
end
