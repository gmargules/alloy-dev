json.user do
	json.cache! ['v1', p] do
		json.id				user.id
		json.name			user.full_name
		json.email			user.email
		json.token			token
		json.thumb			user.thumb.blank? ? user.thumb_url : '/assets/default_thumb.jpg'
		json.metrics do
			json.bust		user.bust
			json.waist	user.waist
		end
	end
end