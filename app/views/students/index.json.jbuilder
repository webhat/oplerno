json.array!(@students) do |student|
  json.extract! student, 
  json.url student_url(student, format: :json)
end
