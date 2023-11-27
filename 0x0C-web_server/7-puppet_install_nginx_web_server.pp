# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure => running,
  enable => true,
}

# Configure Nginx server block for default site
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => '
    server {
      listen 80 default_server;
      listen [::]:80 default_server;

      root /var/www/html;
      index index.html;

      location / {
        try_files $uri $uri/ =404;
        add_header X-Hello-World "Hello World!";
      }

      location /redirect_me {
        return 301 https://www.example.com/redirected_page;
      }

      location /redirected_page {
        return 200 "Hello, this is the redirected page!";
      }
    }
  ',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Create HTML file for the default page
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}
