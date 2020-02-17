Rails.application.routes.draw do
  devise_for :users,
               path: '',
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
               },
               controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
               }

  put 'users/:id/update_photo', to: 'users#update_photo'
  get 'users/:id/user_photo', to: 'users#user_photo'
  post 'users/:id/posts', to: 'posts#create'
  get 'users/:user_id/posts/:id', to: 'posts#show'
  get 'users/:user_id/posts', to: 'posts#index'
  put 'users/:user_id/posts/:id', to: 'posts#update'
  delete 'users/:user_id/posts/:id', to: 'posts#delete'
  put 'users/:user_id/posts/:id/update_tags', to: 'posts#update_tags'
  post 'users/:user_id/posts/:id/comment', to: 'comments#create'
  put 'users/:user_id/posts/:post_id/comments/:id', to: 'comments#update'
  delete 'users/:user_id/posts/:post_id/comments/:id', to: 'comments#delete'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
