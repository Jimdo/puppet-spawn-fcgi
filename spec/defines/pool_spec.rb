require 'spec_helper'

describe 'spawn_fcgi::pool', :type => :define do
  
  context 'with pool_name => undef, socket => undef' do
    let(:title) { 'some_pool' }
    let(:params) {{
      :fcgi_app => '/usr/bin/php-cgi',
      :fcgi_app_args => '--test',
      :ip => '127.0.0.1',
      :children => 10
    }}

    it 'should generate a generic pool with IP listening' do
      should contain_file('/etc/spawn-fcgi/500-some_pool') \
        .with_mode('0644') \
        .with_owner('root') \
        .with_content(/^-- \/usr\/bin\/php-cgi$/) \
        .with_content(/^--test$/) \
        .with_content(/^-a 127.0.0.1$/) \
        .with_content(/^-p 9000$/) \
        .with_content(/^-F 10$/)
    end
  end

  context 'with pool_name => php-pool, socket => undef' do
    let(:title) { 'some_pool' }
    let(:params) {{
      :pool_name => 'php-pool',
      :fcgi_app => '/usr/bin/php-cgi',
      :fcgi_app_args => '--test',
      :ip => '127.0.0.1',
      :children => 10
    }}

    it 'should generate a php-pool with IP listening' do
      should contain_file('/etc/spawn-fcgi/500-some_pool') \
        .with_mode('0644') \
        .with_owner('root') \
        .with_content(/^-- \/usr\/bin\/php-cgi$/) \
        .with_content(/^--test$/) \
        .with_content(/^-a 127.0.0.1$/) \
        .with_content(/^-p 9000$/) \
        .with_content(/^-C 10$/)
    end
  end

  context 'with pool_name => php-pool, socket => /tmp/mysocket' do
    let(:title) { 'some_pool' }
    let(:params) {{
      :pool_name => 'php-pool',
      :fcgi_app => '/usr/bin/php-cgi',
      :fcgi_app_args => '--test',
      :socket => '/tmp/mysocket',
      :children => 10
    }}

    it 'should generate a php-pool with IP listening' do
      should contain_file('/etc/spawn-fcgi/500-some_pool') \
        .with_mode('0644') \
        .with_owner('root') \
        .with_content(/^-- \/usr\/bin\/php-cgi$/) \
        .with_content(/^--test$/) \
        .with_content(/^-s \/tmp\/mysocket$/) \
        .with_content(/^-C 10$/)
    end
  end

end
