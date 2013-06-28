class Squad < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :user
  has_many :squad_entries

  def to_s
  	"#{tournament} Squad #{name} #{time.to_s(:squad_time)}"
  end
end
