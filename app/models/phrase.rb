class Phrase < ActiveRecord::Base
  attr_accessible :chapter_id, :english, :kannada, :tamil, :tamil_alt

  validates_presence_of :chapter_id
  validates_presence_of :english
  validates_presence_of :tamil
end
