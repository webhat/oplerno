class AngelObserver < ActiveRecord::Observer
  def after_save angel
    begin
      ac = ::AngellistApi::Client.new
      res = ac.user_search(slug: angel.angelslug)
      user = angel.mentor
      user.last_name = res.name
      user.description = res.bio
      user.avatar = open(res.image)
      user.links['angellist_url'] = { 'url' => res.angellist_url, 'name' => 'AngelList' }
      user.save
    end if angel.angelslug_changed?
  end
end
