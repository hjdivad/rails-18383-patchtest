require 'test_helper'
require 'rails/performance_test_help'

class M2MTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  test "homepage" do
    get '/wars'

    assert_equal response.body.index("Tyler Wolf and Rosina Schumm"), 918
  end
end
