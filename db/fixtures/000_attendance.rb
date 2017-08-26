
280.times do |i|
  Attendance.seed_once do |attendance|
    attendance.start_at = DateTime.new(2016,10,20,9,0,0,"+0900") + (i + 1).day
    attendance.end_at = DateTime.new(2016,10,20,17,0,0,"+0900") + (i + 1).day
    attendance.user_id = rand(1..10)
    attendance.request = true
  end
end 