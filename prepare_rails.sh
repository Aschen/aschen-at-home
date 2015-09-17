#!/usr/bin/env ruby

# Precompile assets
RAILS_ENV=production rake assets:precompile

# Run delayed_job's worker
RAILS_ENV=production bin/delayed_job start
