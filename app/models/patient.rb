class Patient < User
  has_many :medications, :dependent => :destroy
end
