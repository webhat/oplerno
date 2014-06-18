Sitemap::Generator.instance.load :host => "enroll.oplerno.com" do
	path :root, :priority => 1
	path :teachers, :priority => 0.5, :change_frequency => "weekly"
	resources :courses
end
