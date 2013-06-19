class ApplicationDetail < ActiveRecord::Base
  attr_accessible :the_text, :purpose
  validates :purpose, :uniqueness => true, :presence => true
  validates :the_text, :presence => true
end
