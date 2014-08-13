ActiveAdmin.register Product do  
  form do |f|
    f.inputs do
    	f.input :business
      	f.input :category
      	f.input :name
      	f.input :serial
    end
    f.actions
  end
  
  filter :name
  filter :serial
  
  index do
    column :id
    column :serial
    column :name
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