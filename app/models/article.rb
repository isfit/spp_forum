class Article < ActiveRecord::Base
  has_attached_file :picture, :url => ":class/:attachment/:id/:style.:extension",:path =>":rails_root/public/images/:class/:attachment/:id/:style.:extension", :styles => { :medium => "300x300>",:thumb => "50x50>" }

	attr_accessible :title_en, :ingress_en, :body_en, :visible, :picture
end

