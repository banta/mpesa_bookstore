class Administrator < ActiveRecord::Base

  validates_presence_of     :name
  validates_uniqueness_of   :name
  attr_accessor             :password_confirmation
  validates_confirmation_of :password
  validate                  :password_non_blank

  def self.authenticate(email, password)
    administrator = self.find_by_email(email)
    if administrator
      expected_password = encrypted_password(password, administrator.salt)
      if administrator.hashed_password != expected_password
        administrator = nil
      end
    end
    administrator
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = Administrator.encrypted_password(self.password, self.salt)
  end

  def after_destroy
    if Administrator.count.zero?
      raise "Can't delete last administrator"
    end
  end

  private

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def password_non_blank
    errors.add_to_base("Missing password" ) if hashed_password.blank?
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
end
