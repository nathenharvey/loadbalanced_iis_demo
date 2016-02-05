#
# Cookbook Name:: iis_demo
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'iis_demo::default' do
  context 'When all attributes are default, on Windows 2012r2' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012r2')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'adds the Web-Server windows feature' do
      expect(chef_run).to run_powershell_script('Install IIS').with(code: 'add-windowsfeature Web-Server')
    end

    it 'renders the home page' do
      expect(chef_run).to render_file('c:\inetpub\wwwroot\Default.htm').with_content(/hello/i)
    end

    it 'starts the web server' do
      expect(chef_run).to start_service 'w3svc'
    end

    it 'enables the web server' do
      expect(chef_run).to enable_service 'w3svc'
    end
  end
end
