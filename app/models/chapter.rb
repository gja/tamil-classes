class Chapter < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name

  has_many :phrases

  def as_json(options = nil)
    options ||= {}
    super(options.merge(:include => :phrases))
  end
end
