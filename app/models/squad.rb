class Squad < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :user
  has_many :squad_entries

  def to_s
  	"SQUAD-#{name}"
  end

  def info
  	"#{tournament}-SQUAD-#{name}"
  end

end
