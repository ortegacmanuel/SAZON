FactoryBot.define do
  factory :superadmin_role, class: Role do
    name 'superadmin'
    description 'Super Admin can access all.'
  end

  factory :admin_role, class: Role do
    name 'admin'
    description 'Admin role.'
  end

  factory :student_role, class: Role do
    name 'student'
    description 'Student role.'
  end
end
