class Phrase < ActiveRecord::Base
  attr_accessible :chapter_id, :english, :kannada, :tamil, :tamil_alt
end
