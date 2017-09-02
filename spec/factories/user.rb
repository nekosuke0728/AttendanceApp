FactoryGirl.define do
  factory :user do
    id 1
    email "user1@sample.com"
    password "password"
    name "user1"
    birthday 20000101
    gender 1
    employment_status 1
    address "日本"
    phone "08000000000"

    # -----------------------------

    trait :email_is_nil do
      email nil
    end

    trait :password_is_nil do
      password nil
    end

    trait :name_is_nil do
      name nil
    end

    trait :birthday_is_nil do
      birthday nil
    end

    trait :gender_is_nil do
      gender nil
    end

    trait :employment_status_is_nil do
      employment_status nil
    end

    trait :address_is_nil do
      address nil
    end

    trait :phone_is_nil do
      phone nil
    end

    # -----------------------------

    trait :user2 do
      id  2
      name "user2"
      email  "user2@sample.com"
    end

    trait :user3 do
      id  3
      name "user3"
      email  "user3@sample.com"
    end

  end
end



