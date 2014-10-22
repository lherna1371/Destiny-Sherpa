class Event < ActiveRecord::Base
	serialize :requests 
	serialize :approvals

end
