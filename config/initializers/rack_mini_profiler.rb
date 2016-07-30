# https://github.com/MiniProfiler/rack-mini-profiler/issues/134#issuecomment-126647212
require 'rack-mini-profiler'

Rack::MiniProfilerRails.initialize!(Rails.application)

if Rails.env.production? or Rails.env.staging?
  Rails.application.middleware.delete(Rack::MiniProfiler)
  Rails.application.middleware.insert_after(Rack::Deflater, Rack::MiniProfiler)
end
