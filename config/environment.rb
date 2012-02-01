# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Capo::Application.initialize!

# Remove field_with_errors division
ActionView::Base.field_error_proc = proc { |input, instance| input }