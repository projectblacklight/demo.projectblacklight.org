Rails.application.routes.draw do
  scope '/(:locale)' do
    Blacklight::Marc.add_routes(self)

    root to: 'catalog#index'
    concern :searchable, Blacklight::Routes::Searchable.new

    resource :catalog, only: [:index], controller: 'catalog' do
      concerns :searchable
    end

    concern :exportable, Blacklight::Routes::Exportable.new

    resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
      concerns :exportable
    end

    resources :bookmarks do
      concerns :exportable

      collection do
        delete 'clear'
      end
    end

    devise_for :users
  end
  Blacklight::Engine.routes.default_scope = { path: '(:locale)', module: 'blacklight' }
  mount Blacklight::Engine, at: '/'

  get '/' => 'catalog#index'
end
