FactoryBot.define do
  factory :homework, class: Task do
    association :user
    name { "complete homework" }
    priority { 1 }
    due_date { DateTime.now }
  end

  factory :email, class: Task do
    association :user
    name { "reply to Zack's email" }
    priority { 2 }
    due_date { DateTime.now }
  end

  factory :invalid_task, class: Task do
    association :user
    name { nil }
    priority { nil }
    due_date { nil }
  end

end
