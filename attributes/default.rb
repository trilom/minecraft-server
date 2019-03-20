#
# Cookbook Name:: minecraft
# Attributes:: default
#
# Copyright 2013, Greg Fitzgerald.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['minecraft']['user']                = 'mcserver'
default['minecraft']['group']               = 'mcserver'
default['minecraft']['install_dir']         = '/srv/minecraft'

default['minecraft']['url']                 = 'https://s3.amazonaws.com/trailmix-minecraft/1.12.2/server.jar'
default['minecraft']['ftb_url']             = 'https://s3.amazonaws.com/trailmix-minecraft/mods/server/FTBRevelationServer_2.7.0.zip'
default['minecraft']['server_opts']         = 'nogui'

# Defaults to 40% of your total memory.
default['minecraft']['xms']                 = "#{(node['memory']['total'].to_i * 0.4).floor / 1024}M"
# Defaults to 80% of your total memory.
default['minecraft']['xmx']                 = "#{(node['memory']['total'].to_i * 0.8).floor / 1024}M"

# Additional options to be passed to java, for runit only
default['minecraft']['java-options']        = ''
default['minecraft']['init_style']          = 'runit'

default['minecraft']['ops']                 = [ 'Trilom13','DJKitty2013','DJTotoro2013' ]
default['minecraft']['banned-ips']          = []
default['minecraft']['banned-players']      = []
default['minecraft']['white-list']          = []

# Stop minecraft from binding to ipv6 by default
default['minecraft']['prefer_ipv4'] = true

# See the readme for an explanation
default['minecraft']['autorestart'] = true
