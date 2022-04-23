Prefix Verb   URI Pattern                                                                              Controller#Action
users GET    /users(.:format)                                                                         users#index
      POST   /users(.:format)                                                                         users#create
new_user GET    /users/new(.:format)                                                                     users#new
edit_user GET    /users/:id/edit(.:format)                                                                users#edit
 user GET    /users/:id(.:format)                                                                     users#show
      PATCH  /users/:id(.:format)                                                                     users#update
      PUT    /users/:id(.:format)                                                                     users#update
      DELETE /users/:id(.:format)                                                                     users#destroy
 root GET    /                                                                                        top#index
rooms GET    /rooms(.:format)                                                                         rooms#index
      POST   /rooms(.:format)                                                                         rooms#create
new_room GET    /rooms/new(.:format)                                                                     rooms#new
edit_room GET    /rooms/:id/edit(.:format)                                                                rooms#edit
 room GET    /rooms/:id(.:format)                                                                     rooms#show
      PATCH  /rooms/:id(.:format)                                                                     rooms#update
      PUT    /rooms/:id(.:format)                                                                     rooms#update
      DELETE /rooms/:id(.:format)                                                                     rooms#destroy
confirm_entries POST   /rentals/confirm(.:format)                                                               entries#confirm
confirm_back_entries POST   /rentals/confirm_back(.:format)                                                          entries#confirm_back
entries GET    /rentals(.:format)                                                                       entries#index
      POST   /rentals(.:format)                                                                       entries#create
new_entry GET    /rentals/new(.:format)                                                                   entries#new
entry DELETE /rentals/:id(.:format)                                                                   entries#destroy
rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create