FactoryGirl.define do
  factory :attendance do
    id 1
    user_id 1
    start_at Time.zone.local(2016, 8, 1, 9, 00, 00).to_s
    end_at nil
  end

  trait :attendance_approved do
    id 2
    user_id 1
    start_at Time.zone.local(2016, 8, 1, 9, 00, 00).to_s
    end_at Time.zone.local(2016, 8, 1, 17, 00, 00).to_s
    approval 'approved'
    request 'applied'
  end

  trait :attendance_unapproved do
    id 3
    user_id 1
    start_at Time.zone.local(2016, 8, 1, 9, 00, 00).to_s
    end_at Time.zone.local(2016, 8, 1, 17, 00, 00).to_s
    approval 'unapproved'
    request 'applied'
  end

  trait :attendance_embossed_finish do
    id 4
    user_id 1
    start_at Time.zone.local(2016, 8, 1, 9, 00, 00).to_s
    end_at Time.zone.local(2016, 8, 1, 17, 00, 00).to_s
  end

  trait :attendance_embossed_unfinish do
    id 5
    user_id 1
    start_at Time.zone.local(2016, 8, 1, 9, 00, 00).to_s
    end_at nil 
  end

end
