module PasswordGenerator
  extend ActiveSupport::Concern

  included do 
    before_validation :generate_temporary_password, if: :password_blank?, on: :create
  end

  protected

  def password_blank?
    password.blank?
  end

  def generate_temporary_password
    self.password = self.password_confirmation = SecureRandom.base64(6)
  end
end
