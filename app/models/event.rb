class Event
  include Mongoid::Document

  field :name
  field :description
  field :date,       type: Date
  field :time,       type: Time
  field :owner_id,   type: Integer

  belongs_to :owner, class_name: "User"

  validates :name, :date, :owner, presence: true

  attr_accessible :name, :description, :date, :time
end
