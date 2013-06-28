class Squad < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :user

  def to_s
  	"#{tournament} Squad #{name} #{time.to_s(:squad_time)}"
  end
end
