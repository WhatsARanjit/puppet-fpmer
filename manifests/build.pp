define fpmer::build (
  $version,
  $repo,
  $provider = 'local',
  $content  = "/tmp/${title}",
  $package  = $title,
  $source   = 'dir',
  $arch     = 'all',
  $type     = 'rpm',
  $dest     = '/tmp',
  $prefix   = '/',
) {

  $fpm_cmd = [
    "fpm -s ${source}",
    "-t ${type}",
    "-n ${package}",
    "-a ${arch}",
    "-v ${version}",
    "--prefix ${prefix}",
    "-C ${content}",
  ]
  $_fpm_cmd = join($fpm_cmd, ' ')

  # Name of the package uses 'noarch' if you don't specify
  if $arch == 'all' {
    $_arch = 'noarch'
  } else {
    $_arch = $arch
  }
  
  $package_name = "${package}-${version}-1.${_arch}.${type}"

  case $provider {
    'local': {
      file { $content:
        source  => $repo,
        recurse => true,
        notify  => Exec["build ${title}"],
      }
    }
    'tar', 'zip', 'gz': {
      staging::deploy { $content:
        source => $repo,
        target => $content,
        notify => Exec["build ${title}"],
      }
    }
    'git', 'svn': {
      vcsrepo { $content:
        ensure   => present,
        provider => $provider,
        source   => $repo,
        revision => $version,
        notify   => Exec["build ${title}"],
      }
    }
  }

  exec { "build ${title}":
    command     => $_fpm_cmd,
    cwd         => $dest,
    path        => $::path,
    creates     => "${dest}/${package_name}",
  }

}

