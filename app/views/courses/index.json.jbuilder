json.array!(@courses) do |course|
  json.extract! course, 
  json.url course_url(course, format: :json)
end
