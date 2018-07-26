exec { "apt-update":
    command => "/usr/bin/apt-get update"
}
package { ["openjdk-8-jre", "tomcat7"]:
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

file { '/var/lib/tomcat7/webapp/vrapvraptor-musicjungle.war':
    source => '/vagrant/manifests/vrapvraptor-musicjungle.war',
    owner  => "tomcat7",
    group  => "tomcat7",
    mode   => 0644,
    require => Package["tomcat7"],
    notify => Service["tomcat7"]
}