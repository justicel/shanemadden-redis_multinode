class redis_multinode (
  $version     = '2.8.3',
  $use_github  = false, # if this is true, $version should be a branch name on the git repo https://github.com/antirez/redis
  $use_haproxy = true,
)
{
  include redis_multinode::prereqs
  include redis_multinode::install
  include redis_multinode::sentinel

  if $use_haproxy {
    include redis_multinode::haproxy
  }

  $instances = hiera_array('redis_multinode::instances', [])
  redis_multinode::instance{ $instances: }
}
