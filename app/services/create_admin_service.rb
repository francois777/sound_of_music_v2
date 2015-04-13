class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.first_name = 'Admin'
        user.last_name = 'Administrator'
        user.admin = true
        user.role = 2
        user.email = Rails.application.secrets.admin_email
        user.confirm!
    end    
    approver = User.find_or_create_by!(email: Rails.application.secrets.approver_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.first_name = 'Anthony'
        user.last_name = 'Approver'
        user.role = 1
        user.email = Rails.application.secrets.approver_email
        user.confirm!
    end
    owner = User.find_or_create_by!(email: Rails.application.secrets.owner_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.first_name = 'Olivia'
        user.last_name = 'Owner'
        user.role = 2
        user.email = Rails.application.secrets.owner_email
        user.confirm!
    end    
    user = User.find_or_create_by!(email: Rails.application.secrets.user_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.first_name = 'Ursula'
        user.last_name = 'User'
        user.role = 0
        user.email = Rails.application.secrets.user_email
        user.confirm!
    end    
  end
end
