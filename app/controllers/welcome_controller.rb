class WelcomeController < ApplicationController
skip_before_filter :verify_authenticity_token  

def index

end 

def update_gamertag
	user = current_user 
	
	if params[:psn].present?
		user.update_attributes(psn: params[:psn])

	end 
	
	
	if params[:xbl].present?
		user.update_attributes(xbl: params[:xbl])

	end 
	
	
	if params[:destiny].present?
		user.update_attributes(destiny: params[:destiny])

	end 
	
	if params[:event][:fireteam_group_type].present?
		user.update_attributes(guardian_type: params[:event][:fireteam_group_type])

	end
	
	if params[:level].present?
		user.update_attributes(guardian_level: params[:level])
		
	end 		 
	redirect_to root_url
end 

end