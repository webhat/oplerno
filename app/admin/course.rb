ActiveAdmin.register Course do
  index download_links: [:csv, :xml, :json, :ical] do
    column :avatar do |course|
      link_to [course] do
        image_tag(course.avatar.url(:thumb))
      end
    end
    column :name do |course|
      "#{course.name} (#{course.id})"
    end
    column :start_date
    column :price
    column 'Instructor' do |course|
      course_teacher = course.teacher
      unless course_teacher.blank?
        teacher = Teacher.find(course_teacher)
        begin
          teacher.display_name.force_encoding('UTF-8')
        rescue
          link_to 'Unknown' [:admin, teacher]
        end
      end
    end
    default_actions
  end

  action_item only: :show, if: proc { current_admin_user.id == 3 } do
    link_to "/admin/courses/#{params[:id]}/hide" do
      unless Course.find(params[:id]).hidden
        'Hide Course'
      else
        'Show Course'
      end
    end
  end

  member_action :hide, method: :get do
    course = Course.find(params[:id])
    course.hidden = !course.hidden
    course.save
    redirect_to action: :show, notice: 'Locked!'
  end

  controller do
    if Mime::Type.lookup_by_extension(:ical).nil?
      Mime::Type.register 'text/calendar', :ical
    end
    require 'activeadmin/ical'
    ActiveAdmin::ResourceDSL.send :include, ActiveAdmin::Ical::DSL
    ActiveAdmin::Resource.send :include, ActiveAdmin::Ical::Resource
    ActiveAdmin::Views::PaginatedCollection.add_format :ical
    ActiveAdmin::ResourceController.send :include, ActiveAdmin::Ical::ResourceController
  end

  def ical(options={}, &block)
    options[:resource] = @resource

    config.ical_builder = ActiveAdmin::Ical::Builder.new config.resource_class, options, &block
  end

  ical do
  end

  show do
    columns do
      column span: 2 do
        attributes_table do
          row :id
          row :hidden
          row :avatar do |course|
            image_tag(course.avatar.url(:thumb))
          end
          row :name
          row :slug
          row :price
          row :description do
            simple_format course.description
          end
          row :syllabus do
            simple_format course.syllabus
          end
          row 'Canvas ID' do |course|
            canvas_course = CanvasCourses.find_by_course_id(course.id)
            unless canvas_course.blank?
              link_to canvas_course.canvas_id, "https://oplerno.instructure.com/courses/#{canvas_course.canvas_id}"
            else
              '??'
            end
          end
        end
      end
      unless course.teacher.blank?
        teacher = Teacher.find(course.teacher)
        column do
          render 'admin/teacher_panel', data: teacher
          render 'admin/more_courses_panel', data: teacher
        end
      end
    end
    active_admin_comments
  end

  filter :name
  filter :start_date
  # filter :teacher, :collection => User.all.map { |x| ["#{x.first_name} #{x.last_name}", x.id] }

  form do |f|
    f.inputs 'Course Details' do
      f.input :name
      f.input :slug
      f.input :price
      f.input :description
      f.input :syllabus
      f.input :hidden
      f.input :start_date
      f.input :teacher, collection: Teacher.all.map { |x| [x.display_name.force_encoding('UTF-8'), x.id] }
      f.input :avatar, as: :file, required: false
    end
    f.actions
  end
end
