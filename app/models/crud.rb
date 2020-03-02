module Crud
  require 'bcrypt'
  puts "Using CRUD Module"

  def Crud.create_hash_digest(password)
    BCrypt::Password.create(password)
  end

  def Crud.verify_has_digest(password)
    BCrypt::Password.new(password)
  end

  def Crud.create_secure_users(users)
    users.each do | user_record |
      user_record[:password] = create_hash_digest(user_record[:password])
    end
    return users
  end

  def Crud.authenticate_user(username, password, list_users)
    list_users.each do | user_record |
      if(user_record[:username] == username && verify_has_digest(user_record[:password])==password)
        return user_record
      end
    end
    "Invalid Credentials"
  end
end
