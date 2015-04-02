class ConfirmationsController < Devise::ConfirmationsController

  def create
    "Inside ConfirmationsController#create"
    puts "Resource params: #{resource_params}"
    super
  end

  def update
    "Inside ConfirmationsController#update"
    puts "Params: #{params}"
    super
  end

end