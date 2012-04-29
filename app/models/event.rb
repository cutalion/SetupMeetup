class Event
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes


  field :name
  field :description
  field :address
  field :date,       type: Date
  field :time,       type: Time
  field :owner_id,   type: Integer

  belongs_to :owner, class_name: "User"
  has_and_belongs_to_many :participants, class_name: "User"

  validates :name, :date, :owner, presence: true

  attr_accessible :name, :description, :address, :date, :time

  scope :future_events, where(:date.gte => Date.today)

  def add_participant(user)
    return participants if participants.include?(user)
    participants << user
  end

  def owned_by?(user)
    owner == user
  end

  def important_information_changed?
    time_changed? || date_changed? || address_changed?
  end
end
