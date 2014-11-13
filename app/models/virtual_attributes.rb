# Creates Virtual Attributes
module VirtualAttributes

	# initialization callback
	def after_initialize
	  self.links ||= {} 
	end

	def create_virtual_attributes (*args)
		args.each do |method_name|
			6.times do |key|
				key = key.to_s
				['name', 'url'].each do |field|
					define_method "#{method_name}_#{field}_#{key}" do
						self.links[key][field] unless self.links.nil? or self.links[key].nil? or self.links[key][field].nil?
					end
					define_method "#{method_name}_#{field}_#{key}=" do |value|
						return if value.empty?
						self.links ||= {}
						self.links[key] ||= {}
						self.links[key][field] = value
					end
				end
			end
		end
	end
end
