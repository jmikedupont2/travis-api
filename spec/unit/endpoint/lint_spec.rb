describe Travis::Api::App::Endpoint::Lint, set_app: true do
  let(:content) { "foo: bar" }
  let(:body) { JSON.dump(lint: { warnings: [key: [], message: msg] }) }
  let(:msg) { '[warn] on root: unknown key "unknown" (str)' }

  before { stub_request(:post, 'https://yml.travis-ci.org/v1/parse').to_return(body: JSON.dump(full_messages: [msg])) }

  it "accepts content in parameter" do
    response = post('/lint', content: content)
    response.should be_ok
    response.body.should eq body
  end

  it "accepts content as body" do
    response = put('/lint', content)
    response.should be_ok
    response.body.should eq body
  end
end
