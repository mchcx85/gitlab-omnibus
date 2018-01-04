require 'chef_helper'

describe Prometheus do
  before { Services.add_services('gitlab', Services::BaseServices.list) }

  it 'should return a list of known services' do
    expect(Prometheus.services).to match_array(%w(
                                                 prometheus
                                                 alertmanager
                                                 node-exporter
                                                 redis-exporter
                                                 postgres-exporter
                                                 gitlab-monitor
                                               ))
  end
end
