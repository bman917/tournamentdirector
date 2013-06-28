class Squad < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :user
  has_many :squad_entries

  def to_s
  	"Squad-#{name}"
  end
end
