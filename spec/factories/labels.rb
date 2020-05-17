FactoryBot.define do
  factory :label do
    name { "sample0" }
  end
  factory :second_label, class: Label do
    name { "sample1" }
  end
end
