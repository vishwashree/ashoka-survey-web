FactoryGirl.define do
  factory :response do
    survey { FactoryGirl.create(:survey) }

    trait :incomplete do
      status 'incomplete'
    end

    trait :complete do
      status 'complete'
    end

    trait :clean do
      state 'clean'
    end

    trait :answers_present do
      answers_present true
    end

    before(:create) do |response|
      response.organization_id = 1 if response.organization_id.blank?
      response.user_id = 1 if response.user_id.blank?
      response.save
    end

    factory :response_with_answers do
      after(:create) do |response, evaluator|
        FactoryGirl.create_list(:answer, 10, :response => response)
      end
    end
  end
end

