Rails.application.routes.draw do

  resources :class_budgets
  resources :approvers
  resources :student_tardies
  resources :diknas_conversions do
    member do
      get 'dry_run'
    end
  end
  resources :diknas_report_cards do
    collection do
      post 'import'
      get 'convert'
    end 
  end
  resources :diknas_courses
  
  resources :food_delivery_items
  
  resources :food_order_items
  
  resources :food_packs, except: :show
  
  resources :course_schedules
  resources :class_periods
  resources :batches
  resources :employee_smartcards
  resources :stock_categories
  resources :stock_items
  resources :req_items
  resources :supplies_transaction_items
  resources :warehouses
  resources :item_categories
  resources :item_units
  resources :template_targets, except: :show
  resources :templates
  resources :currencies
  resources :people
  resources :book_categories, except: :show
  resources :subjects
  resources :fine_scales
  resources :book_labels
  resources :rosters
  resources :departments
  resources :employees
  resources :guardians
  resources :book_assignments
  resources :book_grades
  resources :academic_years

  resources :copy_conditions
  resources :book_conditions
  resources :student_activities

  resources :nat_exams do 
    collection do
      get 'letter_ii'
      get 'scores'
      get 'export'
      post 'import'
    end
  end

  post 'diknas_conversions/copy' => 'diknas_conversions#duplicate', as: :duplicate_diknas_conversions
  get 'diknas_converteds/reports' => 'diknas_converteds#reports', as: :converted_reports
  resources :diknas_converteds
  
  resources :lunch_menus, except: [:show]
  get 'lunch_menus/food_lists' => 'lunch_menus#food_lists', as: :lunch_menus_food_lists
  get 'lunch_menus/food_order' => 'lunch_menus#food_order', as: :lunch_menus_food_order 

  resources :food_suppliers, except: [:show]
  resources :food_packages_food_suppliers, except: [:new, :show]
  
  get 'food_suppliers/:id/items' => 'food_suppliers#show', as: :food_supplier_items
  get 'food_suppliers/:id/items/new' => 'food_packages_food_suppliers#new', as: :new_item_supplier

  resources :foods do    
    resources :recipes, shallow: true, except: [:edit]
  end
  
  
  resources :raw_foods do
    resources :food_packages, shallow: true, except: [:edit]
  end  

  get 'food_packages' => 'food_packages#index', as: :food_packages
  get 'food_packages_list' => 'food_packages#food_packages_list', as: :food_packages_list
  get 'food_orders/non_stock_order' => 'food_orders#non_stock_order', as: :non_stock_order
  get 'food_orders/:id/item_receive' => 'food_orders#item_receive', as: :item_receive
  
  resources :food_orders, shallow: true do
    member do
      put 'update_multiple_item'
    end
  end

  resources :food_deliveries, shallow: true ,except: [:show] do
    member do
      put 'update_multiple_item'
    end
  end

  resources :activity_schedules, shallow: true do
    member do
      get 'students'
      post 'add_students'
      delete 'remove_student'      
    end
  end

  resources :rooms ,shallow: true do
    member do
      get 'badges'
      post 'add_badges'
      delete 'remove_badges'
    end
  end
 
  get 'leave_requests/archives' => 'leave_requests#archives', as: :archive
  resources :leave_requests do
    member do
      delete 'cancel'
    end
  end 
  #  get 'leave_requests/:id/cancel' => 'leave_requests#cancel', as: :cancel_leave_request
  get 'leave_requests/:id/approve/:page' => 'leave_requests#approve', as: :approve
  

  resources :supplies_transactions, except: [:edit, :update] do
    collection do
      get 'recap'
      get 'monthly'
      get 'new_supplies'
    end
  end
  
  resources :products do
    collection do
      get 'supplies_stocks'
    end
    member do
      get 'stock_card'
    end
  end
  
  resources :courses do
    collection do 
      post 'init'
    end
    resources :course_texts, shallow: true do
      collection do 
        get 'copy'
        post 'init'
        post 'filter'
      end
    end
    resources :course_sections, except: :new, shallow: true do
      member do
        get  'students'
        post 'add_students'
      end
    end
  end

  get  'book_copies/disposed_index' => 'book_copies#disposed_index', as: :book_copies_disposed_index
  get  'book_copies/dispose_books' => 'book_copies#dispose_books', as: :dispose_books
  get  'book_copies/dispose_books/new_list' => 'book_copies#new_book_dispose', as: :new_book_dispose
  put 'book_copies/dispose_books/new_list/:id' => 'book_copies#update_book_copy', as: :update_book_copy
  resources :book_editions do
    collection do
      get 'summary'
    end
    resources :book_copies, shallow: true do
      collection do
        get 'edit_labels'
        get 'disposed'   
      end
    end
    member do
      get 'update_metadata'
    end
  end

  get  'book_copies/:id/copy_conditions/check' => 'copy_conditions#check', as: :check_copy_condition
  post 'book_copies/:id/copy_conditions/check_update' => 'copy_conditions#check_update'
  put  'book_copies/:id/copy_conditions/create' => 'copy_conditions#create', as: :create_book_copy_condition
  get  'book_copies/:id/conditions' => 'book_copies#conditions', as: :book_copy_conditions
  get  'book_copies/:id/loans' => 'book_copies#loans', as: :book_copy_loans
  get  'book_copies/:id/checks' => 'book_copies#checks', as: :book_copy_checks
  get  'book_copies/:id/check_barcode' => 'book_copies#check_barcode', as: :book_copy_check_barcode
  post 'book_copies/dispose' => 'book_copies#dispose', as: :dispose_book_copies
  get  'book_copies/:id/undispose' => 'book_copies#undispose', as: :undispose_book_copy
  post 'book_copies/update_multiple' => 'book_copies#update_multiple', as: :update_multiple_book_copies
  

  resources :book_titles do
    collection do
      post 'edit_merge' # edit merges
      post 'merge'      # merges several book titles together
      post 'delete'     # deletes several book titles at the same time
      post 'search_isbn'
      get 'tags'
    end
    member do
      get 'editions'
      post 'add_existing_editions'
      post 'add_isbn'
      post 'update_metadata'
      get 'edit_subject'
    end
  end

  # For some reasons this line should be placed before the "resources :standard_books" line for autocomplete to work
  # get 'standard_books/autocomplete_book_edition_title' => 'standard_books/autocomplete_book_edition_title', as: :autocomplete_book_edition_title_standard_books

  resources :grade_levels do
    collection do
      get 'archive'
    end

    member do
      get 'edit_labels'
      post 'add_standard_books'
    end
    resources :grade_sections, shallow: true do
      member do
        get 'students'
        post 'add_students'
        get 'assign'
      end
    end
  end

  resources :standard_books do
    collection do
      post 'prepare'
    end
  end

  get 'grade_sections/:id/edit_labels' => 'grade_sections#edit_labels', as: :edit_labels_grade_section

  resources :grade_section_histories, only: [:index, :show]

  resources :invoices do
    resources :line_items
    member do
      patch 'finalize'
    end
  end

  get 'student_books' => 'student_books#index', as: :student_books
  get 'student_books/assign' => 'student_books#assign', as: :assign_student_books
  get 'student_books/label' => 'student_books#label', as: :label_student_books
  get 'student_books/receipt_form' => 'student_books#receipt_form', as: :receipt_form_student_books
  get 'student_books/by_title' => 'student_books#by_title', as: :by_title_student_books
  get 'student_books/by_student' => 'student_books#by_student', as: :by_student_student_books
  put 'student_books/update_multiple' => 'student_books#update_multiple', as: :update_multiple_student_books
  get 'student_books/missing' => 'student_books#missing', as: :missing_student_books
  get 'student_books/pnnrb' => 'student_books#pnnrb', as: :pnnrb_student_books
  get 'student_books/titles' => 'student_books#titles', as: :titles_student_books
  post 'student_books/finalize' => 'student_books#finalize', as: :finalize_student_books
  post 'student_books/prepare_student_books' => 'student_books#prepare', as: :prepare_student_books  

  get 'students/tardy_list' => 'students#student_tardy_list', as: :student_tardy_list
  resources :students do
    resources :student_books, shallow: true
  end
  
  # resources :book_loans
  resources :book_loans do
    collection do
      get 'teachers'
      post 'initialize_teachers'
      post 'move_all'
      get 'borrowers'
      get 'teacher_receipt'
    end
  end

  get  'students/:student_id/book_loans' => 'book_loans#index', as: :student_book_loans
  post 'students/:student_id/book_loans' => 'book_loans#create'
  get  'students/:student_id/book_loans/new' => 'book_loans#new', as: :new_student_book_loan
  get  'students/:student_id/book_loans/:id/edit' => 'book_loans#edit', as: :edit_student_book_loan
  get  'students/:student_id/book_loans/:id' => 'book_loans#show', as: :student_book_loan
  patch  'students/:student_id/book_loans/:id' => 'book_loans#update'
  put  'students/:student_id/book_loans/:id' => 'book_loans#update'
  delete  'students/:student_id/book_loans/:id' => 'book_loans#destroy'
  
  get  'employees/:employee_id/book_loans' => 'book_loans#list', as: :employee_book_loans
  get  'employees/:employee_id/teacher_receipt' => 'book_loans#teacher_receipt', as: :employee_book_loans_receipt
  post 'employees/:employee_id/book_loans' => 'book_loans#create_tm'
  get  'employees/:employee_id/book_loans/new' => 'book_loans#new_tm', as: :new_employee_book_loans
  get  'employees/:employee_id/book_loans/:id/edit' => 'book_loans#edit_tm', as: :edit_employee_book_loans
  get  'employees/:employee_id/book_loans/scan' => 'book_loans#scan', as: :scan_employee_book_loans
  get  'employees/:employee_id/book_loans/:id' => 'book_loans#show_tm', as: :employee_book_loan
  post 'employees/:employee_id/book_loans/list_action' => 'book_loans#list_action', as: :list_action_book_loans
  patch  'employees/:employee_id/book_loans/:id' => 'book_loans#update_tm'
  put  'employees/:employee_id/book_loans/:id' => 'book_loans#update_tm'
  delete  'employees/:employee_id/book_loans/:id' => 'book_loans#destroy_tm'

  get  'employees/:employee_id/loan_checks' => 'loan_checks#index', as: :employee_loan_checks
  get  'employees/:employee_id/loan_check/new' => 'loan_checks#new', as: :new_employee_loan_check
  post 'employees/:employee_id/loan_check' => 'loan_checks#create'
  delete  'employees/:employee_id/loan_check' => 'loan_checks#delete'

  resources :book_fines do
    collection do
      post 'calculate'
      get 'current'
      get 'autocomplete_student_name'
      get 'notification'
      get 'payment'
    end
  end

  resources :book_receipts do
    collection do
      post 'prepare'
      get  'check'
      post 'finalize_condition'
    end
  end

  resources :transports do
    member do
      get 'members'
      post 'add_members'
    end
  end

  resources :smart_cards, only: [:show, :create, :destroy]

  resources :requisitions do
    collection do
      get 'list'
    end
    member do
      get 'approve'
      patch 'update_approval'
      get 'edit_account'
      patch 'update_account'
      get 'submit'
    end
  end 

  resources :budgets do
    collection do
      post 'import'
    end 
  end

  resources :budget_items, only: [:index, :show]
  
  resources :messages do 
    collection do
      post 'mark'
      post 'delete'
    end
    member do
      post 'mark_read'
    end
  end

  resources :purchase_orders do
    collection do
      get 'report'
      get 'status'
    end
    member do
      get 'list'
      get 'letter'
      get 'print'
      get 'mark'
    end
  end

  resources :purchase_receives do
    collection do
      get 'check'
    end
  end

  resources :order_items, only: [:edit, :update, :destroy]

  resources :accounts, only: [:index, :new, :create, :edit, :update, :destroy]  do
    collection do
      post 'import'
    end
  end

  resources :suppliers do
    collection do
      post 'import'
    end
  end

  resources :events, except: :show do
    collection do
      post 'submit'
      get 'approve'
      post 'update_approval'
    end
  end

  resources :badges, only: [:new, :create, :edit, :update, :destroy]
  resources :door_access_logs, only: [:index]
  get '/door_tap'     => "door_access_logs#list", as: :list_door_access_logs
  get '/door_tap/:id' => "door_access_logs#list"

  get  '/search' => "search#index"
  post '/search' => "search#index"

  post '/comments' => "comments#create"
  
  patch 'pax/:id' => 'late_passengers#update'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, only: [:index, :show, :edit, :update]
  
  # API
  namespace :api, :defaults => {:format => :json} do
    as :user do
      post   "/sign-in"       => "sessions#create"
      delete "/sign-out"      => "sessions#destroy"
    end
    resources :carpools do
      collection do
        get 'poll'
        put 'reorder'
      end
    end

    post "/gates" => 'gates#create'
    post "/tap"   => 'gates#tap'
  end
  
  get 'settings/inventory_mtce' => 'settings#inventory_mtce', as: :settings_inventory_mtce
  get 'settings/courses_mtce' => 'settings#courses_mtce', as: :settings_courses_mtce

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get :dashboard, to: 'welcome#dashboard'

  # For authorization with OmniAuth2
  get '/auth/:provider/callback', to: 'sessions#create'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     #   end
end
