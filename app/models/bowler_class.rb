class BowlerClass < ActiveRecord::Base
  belongs_to :bowlers

  def to_s
  	name
  end

  def to_css_class
  	BowlerClass.convert_to_css(name)
  end

  def self.convert_to_css(bowler_class)
  	s = String.new(bowler_class)
  	s.gsub!(/\s+/, "")
  	s
  end



end
