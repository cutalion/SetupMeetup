class User
  include Mongoid::Document

  has_many :owned_events, foreign_key: :owner_id, class_name: "Event", inverse_of: :owner
  has_many :owned_comments, foreign_key: :owner_id, class_name: "Comment", inverse_of: :owner
  has_and_belongs_to_many :events

  field :email, type: String, default: ""
  field :name

  validates :email, presence: true

  def self.find_by_email(email)
    where(email: email).first
  end

  def name
    username = read_attribute(:name)
    username.blank? ? email : username
  end

  def email_not_required!
    @skip_email_presence_validation = true
  end

  def email_required?
    !@skip_email_presence_validation
  end

  def start_event(event_attributes)
    owned_events.create event_attributes
  end

  def participated?(event)
    event.participants.include? self
  end

  def remember_me
    true
  end
end
