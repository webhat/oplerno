class UserObserver < ActiveRecord::Observer
  observe :user

  def before_validation_on_create(user)
    begin
      user.confirm if user.is_teacher?
    rescue => e
      user.logger.error("User confirm failed for #{user.email}: #{e}")
    end
  end

  def after_create(user)
    user.logger.info('New user added!')
    Notification.new_user(user).deliver if (user.email =~ /.*@localhost/).nil?

    if user.is_teacher?
      Notification.faculty_invite(user).deliver

      CanvasUsers.create! username: user.email, user: user
    end
  end

  def after_save(user)
    if user.is_teacher?
      teacher = Teacher.find(user.id)

      if teacher.rank.nil?
        teacher.create_rank
        teacher.rank.teacher = teacher
        teacher.rank.save
      end
    end
  end
end
