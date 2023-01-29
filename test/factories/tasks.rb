FactoryBot.define do
  factory :task do
    name { "MyString" }
    description { "MyText" }
    author factory: :manager
    assignee factory: :developer
    state { "MyString" }
    expired_at { "2023-01-29" }
  end
end
