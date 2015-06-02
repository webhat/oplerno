module TeamsHelper
  def new_layout?
    !@resource.nil?
  end
end
