shared_context 'cache set unable', cachable: false do
  before(:all) do
    allow(Cache).to receive(:set).and_return(true)
  end
end
