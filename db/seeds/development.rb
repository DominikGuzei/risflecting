unless User.exists? :email => 'admin@risflecting.dev'
  user = User.new :email => 'admin@risflecting.dev',
                  :forename => 'Marvin',
                  :surname => 'Levenstein',
                  :phone => '+41 44 111 22 33',
                  :password => 'password',
                  :password_confirmation => 'password'

  user.role = Role.find_by_name('Admin')
  user.confirmed_at = Time.now

  user.save!

end
