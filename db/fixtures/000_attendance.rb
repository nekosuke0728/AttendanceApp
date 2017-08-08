300.times do |i|
  Attendance.seed_once(:id) do |attendance|
    attendance.id = i + 1
    attendance.start_at = DateTime.new(2016,10,1,9,0,0,"+0900") + (i + 1).day
    attendance.end_at = DateTime.new(2016,10,1,17,0,0,"+0900") + (i + 1).day
    attendance.user_id = rand(17..21)
    attendance.request = true 
    attendance.approval = false
    attendance.edit = false
  end
end
