resource_name :defaults

BASE_COMMAND = '/usr/bin/defaults'.freeze

property :domain, String, name_property: true
property :option, String, default: 'write'
property :read_only, [true, false], default: false
property :settings, Hash
property :system, [true, false]

action :run do
  new_resource.option = 'read' if read_only
  settings.each do |setting, value|
    execute BASE_COMMAND do
      command "#{BASE_COMMAND} #{new_resource.option} \
              #{new_resource.domain} #{setting} #{value}"
    end
  end
end
