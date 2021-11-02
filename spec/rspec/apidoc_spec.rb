# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RSpec::Apidoc do
  let(:formatter) do
    RSpec.configuration.formatters.first do |formatter|
      formatter.instance_if?(described_class)
    end
  end

  it { expect(formatter.title).to eq('YOUR.APP API Documentation') }

  it { expect(formatter.description).to eq('YOUR.APP long description') }

  it { expect(File.exist?(formatter.template_path)).to eq(true) }

  it { expect(formatter.output_filename).to eq('api.html') }

  it { expect(formatter.host).to eq('https://api.YOUR.APP') }

  describe 'with a Rack app', type: :request, apidoc: true do
    describe 'with Rails' do
      it do
        post('/test', params: { q: :ok? })

        expect(response).to have_http_status(418)
        expect(response.body).to eq('{"test":"ok"}')
      end
    end

    it do
      get('/lobster', params: { q: :ok })

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Lobstericious')
    end
  end

  it do
    formatter.close(nil)
    doc = File.read(formatter.output_filename)

    expect(doc).to include(formatter.title)
    expect(doc).to include(formatter.description)
    expect(doc).to include(formatter.host)
    expect(doc).to include('https://api.YOUR.APP/lobster/?q=ok')
    expect(doc).to include('https://api.YOUR.APP/test')
    expect(doc).to include('-X POST')
    expect(doc).to include('-X GET')
    expect(doc).to include('Index docstring')
    expect(doc).to include(
      'RSpec::Apidoc with a Rack app with Rails is expected to eq'
    )
    expect(doc).to include('Content-Type: application/x-www-form-urlencoded')
    expect(doc).to include(
      'RSpec::Apidoc with a Rack app is expected to include "Lobstericious"'
    )
  end
end
