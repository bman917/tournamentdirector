class BowlerClass < ActiveRecord::Base
  belongs_to :bowlers
  has_and_belongs_to_many :tournaments, -> { uniq }  
  

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
