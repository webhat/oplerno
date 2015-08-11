class MentorObserver < ActiveRecord::Observer
  observe 'mentor'
  def after_save mentor
    if mentor.unconfirmed_email_changed?
      MentorMailer.email_changed(mentor).deliver
    end
  end
end
