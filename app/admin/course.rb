ActiveAdmin.register Course do
  index do
    column :name
    column :price
    column "Teacher" do |course|
      teacher = User.find(course.teacher)
      "#{teacher.first_name} #{teacher.last_name}"
    end
    default_actions
  end

  filter :name

  form do |f|
    f.inputs "Course Details" do
      f.input :name
      f.input :price
      f.input :description
      #f.input :teacher
    end
    f.actions
  end
end                                   
