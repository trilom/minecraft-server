#
# Cookbook Name:: minecraft
# Recipe:: default
#
# Copyright 2013, Greg Fitzgerald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.override['java']['jdk_version'] = '8'
include_recipe 'java'
include_recipe 'runit'
include_recipe 'minecraft::user'

jar_name = minecraft_file(node['minecraft']['url'])
ftp_zip = minecraft_file(node['minecraft']['ftb_url'])

directory node['minecraft']['install_dir'] do
  recursive true
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0o755
  action :create
end

remote_file "#{node['minecraft']['install_dir']}/#{jar_name}" do
  source node['minecraft']['url']
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0o644
  action :create_if_missing
end

remote_file "#{node['minecraft']['install_dir']}/#{ftp_zip}" do
  source node['minecraft']['ftb_url']
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0o644
  action :create_if_missing
end

include_recipe 'minecraft::service'
include_recipe 'minecraft::vanilla'

template "#{node['minecraft']['install_dir']}/server.properties" do
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0o644
  action :create
  notifies :restart, 'runit_service[minecraft]', :delayed if node['minecraft']['autorestart']
end

%w(ops banned-ips banned-players white-list).each do |f|
  file "#{node['minecraft']['install_dir']}/#{f}.txt" do
    owner node['minecraft']['user']
    group node['minecraft']['group']
    mode 0o644
    action :create
    content node['minecraft'][f].join("\n") + "\n"
    notifies :restart, 'runit_service[minecraft]', :delayed if node['minecraft']['autorestart']
  end
end

file "#{node['minecraft']['install_dir']}/eula.txt" do
  content "eula=#{node['minecraft']['accept_eula']}\n"
  mode 0o644
  action :create
  notifies :stop, 'runit_service[minecraft]', :delayed if node['minecraft']['autorestart']
end
