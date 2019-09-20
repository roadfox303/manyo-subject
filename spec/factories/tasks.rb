FactoryBot.define do
  factory :task, class: Task do
    title { title }
    comment { comment }
    created_at { created_at }
    deadline { deadline }
    after(:build) do |task|
      task.statuses << build(:statuses, task_id: :@@last, state_id: State.first.id)
    end
  end
end
