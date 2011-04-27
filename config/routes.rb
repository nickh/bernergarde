Bernergarde::Application.routes.draw do
  root :to => 'pages#show', :id => 'home', :format => 'html'

  pages = %w(
    home faq repository repository_p2 trustees operators submit donations
    studies studies_mh studies_broad_institute studies_dm studies_santera
    studies_optigen_pra studies_utrecht_liver_shunt studies_carc
    articles links
  )

  match "/:locale", :to => 'pages#show', :id => 'home', :format => 'html', :via => 'get'
  match "/:locale/:id.:format",
    :id  => /#{pages.join('|')}/,
    :to  => 'pages#show',
    :as  => 'page',
    :via => 'get'

  scope "/:locale/db" do
    resources :people
  end
end
