FactoryBot.define do
  factory :task do
    title { 'task' }
    content { 'content' }
    association :user
    # after(:build) do |task|
    #   label = create(:label)
    #   task.labellings << build(:labellings, task: task, label: label)
    # end
  end
 
  factory :second_task, class: Task do
    title { "second_title" }
    content { "second_content" }
    association :user
  end
end
