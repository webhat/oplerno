class AngelObserver < ActiveRecord::Observer
  def after_save angel
    begin
      ac = ::AngellistApi::Client.new
      res = ac.user_search(slug: angel.angelslug)
      user = angel.mentor
      user.update_from_angel res
      user.save
    end if angel.angelslug_changed?
  end
end
