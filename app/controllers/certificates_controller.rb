class CertificatesController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :show, :create]

  # GET /certificates
  def index
    @certificates = Certificate.all
  end

  # GET /certificates/1
  def show
  end

  # POST /certificates
  def create
    unless certificate_params.nil?
      create_certificate
      redirect_to @certificate, notice: I18n.t('certificate.create.succeed', @certificate.name)
    else
      redirect_to certificates_url
    end
  end

  def create_certificate
    @certificate = Certificate.new name: certificate_params[:name]
    @certificate.teacher = Teacher.find(current_user.id)
    certificate_params[:courses].each do |course_id|
      @certificate.courses << Course.find(course_id)
    end
  end

  private
  def certificate_params
    params[:certificate]
  end
end
