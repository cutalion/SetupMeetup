class Comment

  include Mongoid::Document
  include Mongoid::Timestamps

  field :body
  field :owner_id, type: Integer

  belongs_to :event, inverse_of: :comments
  belongs_to :owner, class_name: "User", inverse_of: :owned_comments

  validates :body, :owner, presence: true

  attr_accessible :body

  def deletable_by?(u)
    u && (self.owner_id == u.id || self.event.owner_id == u.id)
  end

end
