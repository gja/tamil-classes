class Chapter < ActiveRecord::Base
  attr_accessible :name

  has_many :phrases

  def as_json(options = nil)
    options ||= {}
    super(options.merge(:include => :phrases))
  end
end
