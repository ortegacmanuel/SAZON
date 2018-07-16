Rails.application.routes.draw do

  resources :related_words do
  post 'revert', :on => :member
  get 'list_versions', :on => :member
end

  get 'errors/not_found'

  get 'errors/internal_server_error'

  resources :images do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end

  resources :begrips do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end

  resources :assignments do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end

  resources :documents do
    post 'revert', on: :member
    get 'list_versions', :on => :member
    get  'view',   on: :member, as: :view
  end

  resources :inline_forms_translations do
    get 'list_versions', :on => :member
    post 'revert', :on => :member
  end

  resources :inline_forms_keys do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end

  resources :inline_forms_locales do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end

  mount Ckeditor::Engine => '/ckeditor'

  resources :roles do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end

  resources :locales do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end

  devise_for :users, :path_prefix => 'auth'

  resources :users do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end


  # get '/stylesheets/dynamic.css', to: 'documents#css'

  match '/view', to: redirect('/view/sazon'), :via => :all
  get '/view/:slug', to: 'documents#view', constraints: { slug: Rails.configuration.slug_regex }
  get '/module_view/:slug', to: 'documents#module_view', constraints: { slug: Rails.configuration.slug_regex }
  get '/module_begrips/:slug', to: 'documents#module_begrips', constraints: { slug: Rails.configuration.slug_regex }

  match "/404", to: redirect('/view/not_found'), :via => :all

  root to: redirect('/view/sazon'), :via => :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
