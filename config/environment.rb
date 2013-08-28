# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Wave::Application.initialize!
Time::DATE_FORMATS[:profile_datetime] = "%Y-%m-%d в %H:%M:%S"