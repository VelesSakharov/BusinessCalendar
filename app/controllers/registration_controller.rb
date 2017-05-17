class RegistrationController < Devise::RegistrationsController
  layout 'devise', only: [:new]
  def new
    super
  end

  def create
    super
  end

  def update
    super
  end
end
