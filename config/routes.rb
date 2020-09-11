Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get 'attendances/show_applied_attendances'
      patch 'attendances/approve_applied_attendances'
      get 'attendances/confirm_applied_attendance'
      get 'one_month_attendances/show_one_month_attendances'
      get 'one_month_attendances/show_one_month_attendance'
      patch 'one_month_attendances/approve_one_month_attendances'
      get 'one_month_attendances/confirm_one_month_attendance'
      get 'overtimes/show_overtime'
      patch 'overtimes/apply_overtime'
      get 'overtimes/show_overtimes'
      patch 'overtimes/approve_overtimes'
      get 'overtimes/confirm_overtime'
      get 'attendances/show_attendance_log'
      post 'attendances/search_attendance_log'
      get 'attendances/export'
    end
    collection do
      post :import
      get 'show_employees_at_work'
    end
    resources :attendances, only: :update
    resources :one_month_attendances, only: :update
  end
  
  resources :offices
end