require 'rails_helper'
require 'spec_helper'
RSpec.describe CachedModel, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "saves in cache" do
    test_key = "test-key"
    test_value = "123"
    Rails.cache.write(test_key, test_value ,:expires_in => 99999)
    returned_value = Rails.cache.read(test_key)
    expect(returned_value).to eq(test_value)
    # assert_equal test_value, returned_value, "should return cached value"

  end
  it "caches data in the cache store" do
    test_attr = {"a" => 1, "b" => 1}
    test_key = "dd"
    cached_model_obj = CachedModel.new
    allow(cached_model_obj).to receive(:attributes).and_return(test_attr)
    cached_model_obj.cache_object(test_key)
    expect(Rails.cache.read(test_key)).to eq(JSON.generate(test_attr))

  end
  it "loads from the cache store" do
    test_key = "dd"
    output_str = "{}"
    expect(Rails.cache).to receive(:read).with(test_key) {output_str}
    CachedModel.load_cache(test_key)
  end

  it "deletes the keys of the cache store" do
    test_key = "dd"
    output_str = "{}"
    expect(Rails.cache).to receive(:delete).with(test_key) {output_str}
    CachedModel.delete_cache(test_key)
  end


end
