TvShows::Application.routes.draw do
  resources :television_shows, only: [:index, :show, :new, :create]

  resources :television_shows do
    resources :characters
  end

match '/television_shows/:television_show_id/characters/new',
:to => 'characters#new', :as => :new_character, via: :get

match '/television_shows/:television_show_id/characters',
:to => 'characters#index', :as => :characters, via: :get

match '/television_shows/:television_show_id/characters/:id',
:to => 'characters#show', :as => :character, via: :get

end
