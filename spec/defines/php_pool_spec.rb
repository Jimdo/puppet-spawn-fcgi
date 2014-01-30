require 'spec_helper'

describe 'spawn_fcgi::php_pool', :type => :define do

  let(:title) { 'some_php-pool' }
  let(:params) {{
    :ip => '127.0.0.1',
    :socket => '/tmp/mysocket',
    :mode => '0644',
    :children => 10,
    :chroot => '/opt/myapp',
  }}

  it 'should create a spawn_fcgi::pool' do
    should contain_spawn_fcgi__pool('some_php-pool') \
      .with_ensure('present') \
      .with_pool_name('php-pool') \
      .with_fcgi_app('/usr/bin/php-cgi') \
      .with_content('') \
      .with_order('500') \
      .with_ip('127.0.0.1') \
      .with_port('9000') \
      .with_socket('/tmp/mysocket') \
      .with_mode('0644') \
      .with_children(10) \
      .with_chroot('/opt/myapp') \
      .with_user('www-data') \
      .with_group('www-data')
  end

end

