define rhodecode::install($instance_path, $data_path, $python_env) {

  file { $instance_path :
    ensure  => directory,
    mode    => "777",
  }
  file { $data_path :
    require => File[$instance_path],
    ensure  => directory,
    mode    => "777",
  }

  class { 'python' :
    require => File[$data_path],
    version => 'system',
    dev     => true,
    virtualenv => true,
  }
  python::virtualenv { $python_env :
    require => Class['python'],
    ensure => present,
    version => 'system',
    systempkgs => false,
  }

  python::pip { "rhodecode" :
    virtualenv => $python_env,
  }
}
