module TeamsHelper
  def new_layout?
    !@resource.nil?
  end

  def editable_string?
    editable?.to_s
  end

  def editable?
    if user_signed_in? && member_can_edit? 
      true
    else
      false
    end
  end

  def member_can_edit?
    !@resource.mentors.select{|u| u.id == current_user.id }.empty?
  end
end
