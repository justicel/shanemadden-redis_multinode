class redis_multinode::prereqs {

  #Bulk install of haproxy if required
  if $redis_multinode::use_haproxy {
    package { 'haproxy': ensure => latest, }
  }

  case $osfamily {
    redhat: {
      $packages = [
        'gcc',
        'make',
        'wget',
        'augeas',
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
  }
}
