ActiveAdmin.register Course do
  index do
    column :name
    column :price
    column "Teacher" do |course|
      teacher = User.find(course.teacher)
      "#{teacher.first_name} #{teacher.last_name} (#{teacher.id})"
    end
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row "Teacher" do |course|
        teacher = User.find(course.teacher)
        link_to "#{teacher.first_name} #{teacher.last_name}", "/admin/users/#{teacher.id}"
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
      f.input :teacher, :collection => User.all.map { |x| ["#{x.first_name} #{x.last_name}", x.id] }
    end
    f.actions
  end
end
