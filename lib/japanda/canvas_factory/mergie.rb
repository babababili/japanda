require 'hashie/extensions/deep_merge'

class Mergie < Hash
  include Hashie::Extensions::DeepMerge

  def self.deep_merge(default_hash, given_hash, should_merge)
    should_merge ? Mergie[default_hash].deep_merge(Mergie[given_hash]).to_h: given_hash
  end
end