class Comment < ActiveRecord::Base
  has_attached_file :attachment
  validates :subject, :body, :presence => true
  validates_presence_of :subject


  searchable do
  	text :subject
  end
end
