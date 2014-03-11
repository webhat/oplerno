json.array!(@teachers) do |teacher|
  json.extract! teacher 
	json.first_name teacher.encrypted_first_name.force_encoding('utf-8') unless teacher.encrypted_first_name.nil?
	json.last_name teacher.encrypted_last_name.force_encoding('utf-8') unless teacher.encrypted_last_name.nil?
	json.description teacher.description.force_encoding('utf-8') unless teacher.description.nil?
end
