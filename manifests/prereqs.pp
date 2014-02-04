class redis_multinode::prereqs {
  case $osfamily {
    redhat: {
      $packages = [
        'gcc',
        'make',
        'wget',
        'augeas',
        'haproxy',
        # EPEL required for this!
        'python-pip',
      ]
      package { $packages:
        ensure => latest,
      }
      package { "redis":
        ensure   => installed,
        provider => pip,
        require  => Package["python-pip"],
      }
    }
    debian: {
      $packages = [
        'build-essential',
        'wget',
        'haproxy',
        'python-pip',
      ]
      package { $packages:
        ensure => installed,
      }
      package { "redis":
        ensure   => installed,
        provider => pip,
        require  => Package["python-pip"],
      }
    }
  }
}
