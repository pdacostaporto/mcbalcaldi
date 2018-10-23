María del Carmen Balcaldi ― Fotografía
======================================

Fotografías de María del Carmen Balcaldi.

## Cómo contribuir

### Requerimientos

El ambiente de desarrollo corre sobre una máquina virtual y requiere que la virtualización por hardware esté habilitada, lo cual se hace a través del BIOS o la UEFI. En caso de duda, verificar que el hardware soporta virtualización; en Ubuntu, se puede verificar a través de la herramienta `kvm-ok`.
```
$ sudo apt install cpu-checker
...
$ sudo kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used
```

La máquina virtual se configura a través [Vagrant](https://www.vagrantup.com/), el cual se instala a través de los paquetes distribuidos en su web.

En particular, se usa [VirtualBox](https://www.virtualbox.org/) como proveedor de Vagrant; en Ubuntu se puede instalar a través de los paquetes oficiales.
```
$ sudo apt install virtualbox
```

Para desplegar en producción hay que tener instalado [Ansible](https://www.ansible.com/). Para instalar la última versión en Ubuntu:
```
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt update
$ sudo apt install ansible
```

### Configuración

Para aceptar automáticamente los certificados de TLS de la aplicación en el entorno de desarrollo es necesario agregar el certificado `ca.crt` contenido en la raíz del repositorio como autoridad de confianza del navegador o del cliente que se esté usando.

Para iniciar la máquina virtual se corre el comando `vagrant up` dentro del repositorio. Al final del proceso se puede acceder al sitio en la URL http://localhost:10666.  En caso de error se puede reintentar el proceso de aprovisionamiento mediante el comando `vagrant provision` o `vagrant up --provision`. (Tener en cuenta que para que el sitio se instale es necesario borrar el archivo `web/sites/default/settings.php` si es que existe.) Para apagar la máquina virtual se corre el comando `vagrant halt` y para borrarla `vagrant destroy`. Se puede acceder a la máquina virtual mediante el comando `vagrant ssh`. Dentro de ella el repositorio se encuentra en la ruta `/var/www/mcbalcaldi`.

Los directorios compartidos entre el anfitrión y la máquina virtual se sincronizan mediante `rsync` desde el anfitrión hacia la máquina virtual, salvo por el directorio `config` que se sincroniza automáticamente para ambos lados. Para sincronizar todos los directorios compartidos menos `config` es necesario correr el comando `vagrant rsync`. También se puede correr el comando `vagrant rsync-auto` después de iniciar la máquina virtual para que la sincronización se haga de forma automática. Hay que tener en cuenta que algunos de los archivos de la aplicación de la máquina virtual no se sincronizan con el anfitrión, como por ejemplo el directorio `vendor` o los archivos de la distribución de Drupal.

### Despliegue

Para desplegar el contenido de `master` en el servidor primero es necesario crear el archivo `provision/environments/production/group_vars/all/credentials` y configurar en él las credenciales con el mismo formato que el archivo `provision/environments/production/group_vars/all/credentials`.
Luego, correr el script `deploy.sh` para desplegar.
