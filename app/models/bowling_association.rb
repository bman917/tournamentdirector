class BowlingAssociation < ActiveRecord::Base
  include PublicActivity::Common

  has_many :bowlers
  validates :name, presence: true
  validates_uniqueness_of :name

  def to_s
    name
  end

  def details
    "[ID-#{id}] #{name}"
  end

  def record(action, user_doing_the_action, tournament)

    detail = self.details

    if action == :update
      description = "Updated Association"
    elsif action == :destroy
      description = "Deleted Association"
    elsif action == :create
      description = "Added Association"
    end

    self.create_activity action, owner: user_doing_the_action, tournament_id: tournament.id, parameters: {description: description, details: detail, tournament: tournament.name}
        
  end

end
