class Event
  include Mongoid::Document

  field :name
  field :description
  field :date, type: Date
  field :time, type: Time
end
