unless User.exists? :email => 'admin@risflecting.dev'
  user = User.new :email => 'admin@risflecting.dev',
                  :forename => 'Admin',
                  :surname => 'Admin',
                  :phone => '042',
                  :password => 'password',
                  :password_confirmation => 'password'

  user.roles << Role.find_by_name('Admin')
  user.confirmed_at = Time.now

  user.save
end
