Rails.application.routes.draw do
  scope '/(:locale)',
    # This is a workaround for https://github.com/rails/rails/issues/32013
    constraints: { locale: /(#{Rails.application.config.available_locales.join('|')})/ } do

    root to: 'catalog#index'
    concern :searchable, Blacklight::Routes::Searchable.new

    resource :catalog, only: [], controller: 'catalog' do
      concerns :searchable
    end

    concern :exportable, Blacklight::Routes::Exportable.new
    concern :marc_viewable, Blacklight::Marc::Routes::MarcViewable.new

    resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
      concerns [:exportable, :marc_viewable]
    end

    resources :bookmarks do
      concerns :exportable

      collection do
        delete 'clear'
      end
    end

    devise_for :users
  end
  Blacklight::Engine.routes.default_scope = { path: '(:locale)' }
  mount Blacklight::Engine, at: '/'

  get '/' => 'catalog#index'
end
