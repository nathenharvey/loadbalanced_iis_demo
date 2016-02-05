# confirm it is listening on port 80
describe port(80) do
  it { should be_listening }
end

# curl the home page
describe command('curl localhost') do
  its('stdout') { should match(/StatusCode *: *200/)}
end

