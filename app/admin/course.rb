ActiveAdmin.register Course do
  index do
    column :name
    column :price
    column "Instructor" do |course|
			begin
				teacher = User.find(course.teacher)
				teacher.display_name.force_encoding('UTF-8')
			rescue
				"Unknown"
			end
    end
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row "Instructor" do |course|
        begin
          teacher = User.find(course.teacher)
          teacher.courses << course
          link_to teacher.display_name.force_encoding('UTF-8'), "/admin/users/#{teacher.id}"
        rescue
          "Unknown"
        end
      end
    end
  end

  filter :name
  #filter :teacher, :collection => User.all.map { |x| ["#{x.first_name} #{x.last_name}", x.id] }

  form do |f|
    f.inputs "Course Details" do
      f.input :name
      f.input :price
      f.input :description
			f.input :hidden
			f.input :start_date
			f.input :teacher, :collection => User.all.map { |x| [x.display_name, x.id] }
    end
    f.actions
  end
end
