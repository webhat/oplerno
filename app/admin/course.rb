ActiveAdmin.register Course do
	actions :all, :except => [:destroy]
  index do
		column :avatar do |course|
			image_tag(course.avatar.url(:thumb))
		end
    column :name do |course|
			"#{course.name} (#{course.id})"
		end
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

	action_item only: :show, if: proc{ current_admin_user.id == 3 } do
		link_to "/admin/courses/#{params[:id]}/hide" do 
			unless Course.find(params[:id]).hidden
				'Hide Course'
			else
				'Show Course'
			end
		end
	end

	member_action :hide, :method => :get do
		course = Course.find(params[:id])
		course.hidden = !course.hidden
		course.save
		redirect_to :action => :show, :notice => "Locked!"
	end

  show do
    attributes_table do
			row :avatar do |course|
				image_tag(course.avatar.url(:thumb))
			end
      row :name
      row :price
      row :description
      row :syllabus
			row 'Canvas ID' do |course|
				canvas_course = CanvasCourses.find_by_course_id(course.id)
				unless canvas_course.nil?
					link_to canvas_course.canvas_id, "https://oplerno.instructure.com/courses/#{canvas_course.canvas_id}"
				else
					'??'
				end
			end
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
      f.input :syllabus
			f.input :hidden
			f.input :start_date
			f.input :teacher, :collection => User.all.map { |x| [x.display_name.force_encoding('UTF-8'), x.id] }
			f.input :avatar, :as => :file, :required => false
    end
    f.actions
  end
end
