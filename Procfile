release: bin/rails db:schema:load db:seed albums:init_current
web: bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
