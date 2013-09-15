# Load the rails application.
require File.expand_path('../application', __FILE__)

# Initialize the rails application.
Tournamentdirector::Application.initialize!

Time::DATE_FORMATS[:squad_time] = "%B %d %I:%M %p"
Time::DATE_FORMATS[:activity_time] = "%B %d, %I:%M %p"

