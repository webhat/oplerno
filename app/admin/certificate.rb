ActiveAdmin.register Certificate do
  index do
    column :name
    column :courses do |certificate|
      render 'admin/courses_panel', data: certificate.courses
    end
    column :teacher do |certificate|
      certificate.teacher.display_name
    end
    default_actions
  end

  filter :name

  show do |certificate|
    attributes_table do
      row :id
      row :name
      panel 'Courses' do
        render 'admin/courses_panel', data: certificate.courses
      end
      render 'admin/teacher_panel', data: certificate.teacher
    end
  end
end
