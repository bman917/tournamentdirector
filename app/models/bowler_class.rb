class BowlerClass < ActiveRecord::Base
  belongs_to :bowlers

  def to_s
  	name
  end

  def to_css_class
  	s = String.new(name)
  	s.gsub!(/\s+/, "")
  	s
  end



end
