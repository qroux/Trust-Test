https://trustpair-test.herokuapp.com

L'application permet :
- d'importer une archive CSV
- d'enrichir chaque ligne du tableau individuellement
- d'enrichir l'ensemble de la base de donnée avec le bouton 'Enrichir la liste'
- de supprimer l'intégralité de la base donnée avec le bouton 'Supprimer la liste'

L'enrichissement complet de la base de donnée se fait avec Sidekiq (dashboard disponible addresse/sidekiq).

Test du controller: Rspec

$ bundle exec rspec
