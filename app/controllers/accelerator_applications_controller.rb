class AcceleratorApplicationsController < InheritedResources::Base

  def create
    app = AcceleratorApplication.new( description: application_params[:description], email: application_params[:email])

    if application_params[:team]
      @resource = app.team = Team.find(application_params[:team])
    else
      @resource = app.mentor = Mentor.find(application_params[:mentor])
    end

    app.save

    redirect_to @resource, notice: 'Application Recieved'
  end

  private
  def application_params
    params[:accelerator_application]
  end
end
