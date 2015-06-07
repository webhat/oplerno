class AngelObserver < ActiveRecord::Observer
  def before_save angel
    begin
      @ac = ::AngellistApi::Client.new
      result = @ac.user_search(slug: angel.angelslug)
      populate_user angel.mentor, result
      populate_companies angel, result
    end if angel.angelslug_changed?
  end

  def populate_companies angel, result
    roles = @ac.get_startup_roles(user_id: result[:id])

    roles[:startup_roles].each do |startup|
      ac_company = startup[:startup]
      company = build_company ac_company

      if startup[:role] == 'advisor' || startup[:role] == 'founder'
        angel.advisors << company
      end
      if startup[:role] == 'current_investor' || startup[:role] == 'past_investor'
        angel.investors << company
      end
    end
  end

  def build_company ac_company
    unless company = Company.find_by_name(ac_company[:name])
      company = Company.create! name: ac_company[:name],
        logo_url: ac_company[:logo_url],
        company_url: ac_company[:company_url]
    end
    company
  end

  private
  def populate_user user, result
    user.update_from_angel result
    user.save
    return user
  end
end
