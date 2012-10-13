class Practice < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :patients, :dependent => :destroy

  attr_accessible :address, :fax_number, :latitude, :longitude, :name, :telephone_number
end
