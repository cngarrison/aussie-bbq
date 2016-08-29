# many of the interesting customizations for this were done in attributes
include_recipe 'elasticsearch::default'
# include_recipe 'elasticsearch::plugins'

service 'elasticsearch' do
  action [:enable, :start]
end

