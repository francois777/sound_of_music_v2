class RegistrationsController < Devise::RegistrationsController

  def create
    "Inside RegistrationsController#create"
    super
  end

end