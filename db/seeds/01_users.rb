if User.count == 0
  admin = User.create(
      password: Rails.application.secrets.admin_password,
      password_confirmation: Rails.application.secrets.admin_password,
      first_name: 'Admin',
      last_name: 'Administrator',
      admin: true,
      role: 2,
      email: Rails.application.secrets.admin_email,
      confirmed_at: Time.now)

  approver = User.create(
      password: Rails.application.secrets.admin_password,
      password_confirmation: Rails.application.secrets.admin_password,
      first_name: 'Anthony',
      last_name: 'Approver',
      role: 1,
      email: Rails.application.secrets.approver_email,
      confirmed_at: Time.now)

  owner = User.create(
      password: Rails.application.secrets.admin_password,
      password_confirmation: Rails.application.secrets.admin_password,
      first_name: 'Olivia',
      last_name: 'Owner',
      role: 2,
      email: Rails.application.secrets.owner_email,
      confirmed_at: Time.now)
      
  user = User.create(
      password: Rails.application.secrets.admin_password,
      password_confirmation: Rails.application.secrets.admin_password,
      first_name: 'Ursula',
      last_name: 'User',
      role: 0,
      email: Rails.application.secrets.user_email,
      confirmed_at: Time.now)
  
  puts "#{User.count} Users have been loaded"

end