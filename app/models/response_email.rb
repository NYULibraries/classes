class ResponseEmail < ActiveRecord::Base
  attr_accessible :reply_to, :subject, :body, :purpose
  validates_presence_of :reply_to, :subject, :body, :purpose
  validates_uniqueness_of :purpose
end
