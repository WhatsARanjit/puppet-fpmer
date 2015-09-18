class fpmer {
  package { [
    'rpm-build',
    'git',
    'ruby-devel',
  ]:
    ensure => installed,
  }
  package { 'fpm':
    ensure   => installed,
    provider => 'gem',
  }
}
