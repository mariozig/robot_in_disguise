require 'robot_in_disguise'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.default_cassette_options = { record: :new_episodes }
end
