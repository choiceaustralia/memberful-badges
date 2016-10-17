
class Memberful::MemberfulController < ApplicationController
  protect_from_forgery unless: -> { true } # TODO

  def status
    version = Plugin::Metadata.parse(File.open('plugins/memberful/plugin.rb', 'r')).version
    render json: { version: version }
  end

  def test
    render json: params
  end
end
