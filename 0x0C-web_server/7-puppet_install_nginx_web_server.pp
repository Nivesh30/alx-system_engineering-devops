# Define Nginx class
class { 'nginx':
  manage_repo => true,
  listen_port => 80,
}

# Set up default Nginx vhost
nginx::resource::vhost { 'default':
  www_root     => '/var/www/html',
  listen_port  => 80,
  index_files  => ['index.html'],
}

# Create Hello World index page
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

# Set up redirection for /redirect_me
nginx::resource::vhost { 'redirect_me':
  ensure       => present,
  www_root     => '/var/www/html',
  listen_port  => 80,
  server_name  => 'localhost',
  locations    => {
    '/' => {
      ensure       => present,
      location     => '/redirected_page',
      return       => '301',
    },
    '/redirected_page' => {
      ensure       => present,
      content      => 'Hello, this is the redirected page!',
    },
  },
}
