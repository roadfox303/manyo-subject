FactoryBot.define do
  factory :state, class: State do
    progress {"未着手"}
  end
  factory :state_2, class: State do
    progress {"着手中"}
  end
  factory :state_3, class: State do
    progress {"完了"}
  end
end
