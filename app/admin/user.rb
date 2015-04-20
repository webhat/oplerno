ActiveAdmin.register User do
  actions :all, :except => [:destroy]
  index do
    column :avatar do |user_object|
      link_to [user_object] do
        image_tag(user_object.avatar.url(:thumb))
      end
    end
    column 'Name' do |user_object|
      name = 'Unknown'
      begin
        name = user_object.display_name.force_encoding('utf-8')
      rescue
      end
      link_to "#{name} (#{user_object.id})", [user_object]
    end
    column 'Courses' do |user_object|
      render 'admin/courses_panel', data: Course.find(:all, conditions: ["teacher = ?", user_object.id])
    end
    column :email do |user_object|
      if user_object.unconfirmed_email.nil?
        user_object.email
      else
        user_object.unconfirmed_email
      end
    end
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email
  filter :current_sign_in_at
  filter :last_sign_in_at
  filter :sign_in_count

  show do |user_object|
    columns do
      column :span => 2 do
        attributes_table do
          row :id
          row :canvas do
            canvas_user = CanvasUsers.find_by_user_id(user_object.id)
            unless canvas_user.nil?
              link_to canvas_user.canvas_id, "https://oplerno.instructure.com/users/#{canvas_user.canvas_id}"
            else
              '??'
            end
          end
          row :encrypted_first_name
          row :encrypted_last_name
          row :email do
            mail_to user_object.email, user_object.email
          end
          row :unconfirmed_email do
            mail_to user_object.unconfirmed_email, user_object.unconfirmed_email
          end
          row :description do
            simple_format user_object.description
          end
        end
      end
      column do
        panel 'Courses' do
          courses = Course.find(:all, conditions: ["teacher = ?", user_object.id])
          courses.each do |course|
            columns title: 'Courses' do
              column do
                course.rank.ranking
              end
              column do
                link_to course.name, [:admin, course]
              end
              column do
                canvas_course = CanvasCourses.find_by_course_id(course.id)
                unless canvas_course.nil?
                  link_to canvas_course.canvas_id, "https://oplerno.instructure.com/courses/#{canvas_course.canvas_id}"
                else
                  '??'
                end
              end
            end
          end
        end
        panel 'Podio' do
          podio = PodioTeacher.find_by_teacher_id(user_object.id)
          unless podio.nil?
            table_for [podio] do
              column :name
              column :email
            end
            columns do
              column do
                simple_format podio.subject_area_s
              end
            end
            columns do
              column do
                link_to 'LinkedIn', podio.linkedin
              end
            end
          end
        end
      end
    end
    active_admin_comments
  end

  action_item only: :show do
    unless User.find(params[:id]).access_locked?
      link_to 'Lock User', "/admin/users/#{params[:id]}/lock"
    else
      link_to 'Unlock User', "/admin/users/#{params[:id]}/unlock"
    end
  end

  action_item only: :show do
    link_to 'Confirm Email', "/admin/users/#{params[:id]}/confirm"
  end

  member_action :lock, :method => :get do
    user_object = User.find(params[:id])
    user_object.lock_access!
    redirect_to :action => :show, :notice => "Locked!"
  end

  member_action :unlock, :method => :get do
    user_object = User.find(params[:id])
    user_object.unlock_access!
    redirect_to :action => :show, :notice => "Unlocked!"
  end

  member_action :confirm, :method => :get do
    user_object = User.find(params[:id])
    user_object.confirm!
    redirect_to :action => :show, :notice => "Confirmed!"
  end

  action_item only: :show do
    link_to 'Become User', "/admin/users/#{params[:id]}/become", :target => "_blank"
  end

  member_action :become, :method => :get do
    sign_in(:user, User.find(params[:id]), { :bypass => true })
    redirect_to user_url
  end

  form do |f|
    f.inputs 'User Details' do
      f.input :encrypted_first_name, label: 'First Name'
      f.input :encrypted_last_name, label: 'Last Name'

      f.input :description
      f.input :email
      if f.object.new_record?
        f.input :mailpass unless user_object.is_teacher?
        f.input :privateemail unless user_object.is_teacher?
      end
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
