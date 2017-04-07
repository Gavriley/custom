Rails.application.routes.draw do

  resources :posts do
    post :create_field, to: 'posts#create_field', on: :collection
    post :create_role, to: 'posts#create_role', on: :collection
  end

end
