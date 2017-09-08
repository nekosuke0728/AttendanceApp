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

  trait :attendance_date1 do
    id 8
    user_id 1
    start_at Time.zone.local(2016, 8, 1, 9, 00, 00).to_s
    end_at Time.zone.local(2016, 8, 1, 17, 00, 00).to_s
  end

  trait :attendance_date2 do
    id 9
    user_id 1
    start_at Time.zone.local(2016, 8, 2, 9, 00, 00).to_s
    end_at Time.zone.local(2016, 8, 2, 17, 00, 00).to_s
  end

  trait :attendance_date3 do
    id 10
    user_id 1
    start_at Time.zone.local(2016, 8, 3, 9, 00, 00).to_s
    end_at Time.zone.local(2016, 8, 3, 17, 00, 00).to_s
  end

  trait :attendance_date4 do
    id 11
    user_id 1
    start_at Time.zone.local(2016, 8, 4, 9, 00, 00).to_s
    end_at Time.zone.local(2016, 8, 4, 17, 00, 00).to_s
  end

  trait :attendance_date5 do
    id 12
    user_id 1
    start_at Time.zone.local(2016, 8, 5, 9, 00, 00).to_s
    end_at Time.zone.local(2016, 8, 5, 17, 00, 00).to_s
  end

end
