FactoryBot.define do
  factory :user do
    email 'viewer@example.com'
    name 'Viewer'
    password 'viewer999'
    password_confirmation 'viewer999'

    trait :superadmin do
      email 'admin@example.com'
      name 'Admin'
      password 'admin999'
      password_confirmation 'admin999'

      after(:create) do |user|
        user.roles << create(:superadmin_role)
      end
    end

    trait :admin do
      email 'admin@example.com'
      name 'Admin'
      password 'admin999'
      password_confirmation 'admin999'

      after(:create) do |user|
        user.roles << create(:admin_role)
      end
    end

    trait :student do
      email 'student@example.com'
      name 'Student'
      password 'student999'
      password_confirmation 'student999'

      after(:create) do |user|
        user.roles << create(:student_role)
      end
    end

    before(:create) { create :student_role unless Role.find_by_name('student') }
  end
end
