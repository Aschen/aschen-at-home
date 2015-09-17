#!/usr/bin/env ruby

# Precompile assets
RAILS_ENV=production rake assets:precompile

# Run delayed_job's worker
RAIL_ENV=production bin/delayed_job start
