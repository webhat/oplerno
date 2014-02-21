json.array!(@teachers) do |teacher|
  json.extract! teacher, 
  json.url teacher_url(teacher, format: :json)
end
