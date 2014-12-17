module TeachersHelper
  def teacher_cache_id teacher
    if current_user.nil?
      "#{prefix}_#{cache_id}_#{ teacher.id }"
    else
      "#{prefix}_#{cache_id}_#{ teacher.id }_#{current_user.id}"
    end
  end

  def prefix
    if @teachers.nil?
      'teacher'
    else
      'teachers'
    end
  end
end
