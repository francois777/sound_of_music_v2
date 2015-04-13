class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.first_name = 'Admin'
        user.last_name = 'Administrator'
        user.admin = true
        user.role = 2
        user.confirm!)
    approver = User.find_or_create_by!(email: Rails.application.secrets.approver_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.first_name = 'Anthony'
        user.last_name = 'Approver'
        user.role = 1
        user.confirm!)
    owner = User.find_or_create_by!(email: Rails.application.secrets.owner_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.first_name = 'Olivia'
        user.last_name = 'Owner'
        user.role = 2
        user.confirm!)
    user = User.find_or_create_by!(email: Rails.application.secrets.user_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.first_name = 'Ursula'
        user.last_name = 'User'
        user.role = 0
        user.confirm!)
  end
end
