class Authorization
  include Mongoid::Document

  belongs_to :user

  field :uid
  field :provider
  field :token

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.find_by_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first
  end
end
