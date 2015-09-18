te_fpm::build { 'test_module':
  version  => '0.1.0',
  repo     => 'https://github.com/WhatsARanjit/test_module.git',
  provider => 'git',
}

te_fpm::build { 'test_module_puppet':
  version  => '0.1.1',
  repo     => 'https://github.com/WhatsARanjit/test_module.git',
  type     => 'deb',
  provider => 'git',
}
