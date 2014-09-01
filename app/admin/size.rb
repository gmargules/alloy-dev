ActiveAdmin.register Size do  

  index do
    column :id
    column :business_id
    column :category_id
    column :name
    column :min_bust
    column :max_bust
    column :min_waist
    column :max_waist
    column :created_at
    column :updated_at
    
    actions defaults: true do 
    
    end 
  end

  controller do
    def permitted_params
      params.permit! 
    end
  end  
end