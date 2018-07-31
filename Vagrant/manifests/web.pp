define file_line($file, $line) {
    exec { "/bin/echo '${line}' >> '${file}'":
        unless => "/bin/grep -qFx '${line}' '${file}'"
    }
}

exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

exec { 'musicjungle':
    command => "mysqladmin -uroot create musicjungle",
    unless => "mysql -u root musicjungle",
    path => "/usr/bin",
    require => Service["mysql"]
}

package { ["openjdk-8-jre", "tomcat7", "mysql-server"]:
    ensure => installed,
    require => Exec["apt-update"]
}

service { "tomcat7":
    ensure     => running, # Verifica se o serviço esta em execução.
    enable     => true, #  Verifica se esta ligado.
    hasrestart => true, # Verifica se o serviço de restart esta disponivel.
    hasstatus  => true, # Verifica se o serviço de status esta disponivel.
    require => Package["tomcat7"] # Verifica se o pacote de tomcat7 esta instalado.
}

service { "mysql":
    ensure     => running, # Verifica se o serviço esta em execução.
    enable     => true, #  Verifica se esta ligado.
    hasrestart => true, # Verifica se o serviço de restart esta disponivel.
    hasstatus  => true, # Verifica se o serviço de status esta disponivel.
    require => Package["mysql-server"] # Verifica se o pacote de tomcat7 esta instalado.
}

file { "/var/lib/tomcat7/webapps/vraptor-musicjungle.war":
    source => '/vagrant/manifests/vraptor-musicjungle.war',
    owner  => "tomcat7",
    group  => "tomcat7",
    mode   => 0644,
    require => Package["tomcat7"],
    notify => Service["tomcat7"]
}

file_line { "production":
    file => "/etc/default/tomcat7",
    line => "JAVA_OPTS=\"\$JAVA_OPTS -Dbr.com.caelum.vraptor.environment=production\"",
    require => Package["tomcat7"],
    notify => Service["tomcat7"]
}

