require 'spec_helper'

describe 'spawn_fcgi' do
  
  it 'should install the spawn-fcgi package' do
    should contain_package('spawn-fcgi') \
      .with_ensure('installed')
  end

  it 'should install an init script for spawn-fcgi daemon' do
    should contain_file('/etc/init.d/spawn-fcgi') \
      .with_ensure('present') \
      .with_mode('0755') \
      .with_owner('root') \
      .with_group('root')
  end

  it 'should enable and enforce running state of spawn-fcgi daemon' do
    should contain_service('spawn-fcgi') \
      .with_ensure('running') \
      .with_enable(true)
  end

  it 'should create a directory for spawn-fcgi pools' do
    should contain_file('/etc/spawn-fcgi') \
      .with_ensure('directory')
  end

end

