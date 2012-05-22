class Event
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes


  field :name
  field :description
  field :address
  field :time,       type: DateTime
  field :owner_id,   type: Integer

  belongs_to :owner, class_name: "User"
  has_and_belongs_to_many :participants, class_name: "User"

  validates :name, :time, :owner, presence: true

  attr_accessible :name, :description, :address, :time

  scope :today_events,         -> { where(:time => Date.today.beginning_of_day..Date.today.end_of_day) }
  scope :future_events,        -> { where(:time.gte => Time.zone.now) }
  scope :events_within_a_week, -> { where(:time => 1.week.since) }

  def add_participant(user)
    return participants if participants.include?(user)
    participants << user
  end

  def owned_by?(user)
    return false if user.nil?
    owner == user
  end
  
  def date
    time.to_date if time.respond_to? :to_date
  end

  def important_information_changed?
    time_changed? || address_changed?
  end
end
