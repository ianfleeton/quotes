FactoryBot.define do
  factory :profile do
    sequence(:domain) { |n| "host#{n}.example.com" }
    from { "quotes@example.com" }
    html { "<!DOCTYPE html>" }
    intro { "Intro..." }
    name { "Name" }
    subject { "Your quote" }
  end
end
