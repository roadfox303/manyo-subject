FactoryBot.define do
  factory :tag, class: Tag do
    name {"猫"}
  end
  factory :tag_2, class: Tag do
    name {"犬"}
  end
  factory :tag_3, class: Tag do
    name {"鳥"}
  end
end
