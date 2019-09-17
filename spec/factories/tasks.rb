FactoryBot.define do

  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    comment { 'Factoryで作ったデフォルトのコンテント１' }
    created_at { Time.current + 2.days }
    deadline { Time.current + 6.days }
  end

  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    comment { 'Factoryで作ったデフォルトのコンテント２' }
    created_at { Time.current + 1.days }
    deadline { Time.current + 10.days }
  end
end
