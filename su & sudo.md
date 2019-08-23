`su *username*`​ - запустить терминальную сессию из под пользователя *username*

*P.s. если имя пользователя отсутствует то по умолчанию **root***

`sudo *commd* [args]` - выполнить команду с правами root-пользователя

`su` - запращивает пароль пользователя из подкоторого будет запускаться сессия, `sudo` заправщивает пароль текущего пользователя

Любому пользователю можно добавить права на выполнения команд, требующих права **root**

В Debian `sudo` по-умолчанию не установлен, поэтому:

```sh
apt-get install sudo
```

Управление правами производится в `/etc/sudoers`​ с помощью `visudo`​.

*P.s. править **/etc/sudoers** желательно именно **visudo**, т.к. от проверяет синтаксис*

```sh
ФАЙЛ /etc/sudoers
#
# This file MUST be edited with the 'visudo' command as root.
#
# Please consider adding local content in /etc/sudoers.d/ instead of
# directly modifying this file.
#
# See the man page for details on how to write a sudoers file.
#
Defaults	env_reset
Defaults	mail_badpass
Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Host alias specification

# User alias specification
User_Alias	GRONE = test
# Cmnd alias specification

# User privilege specification
root	ALL=(ALL:ALL) ALL
ujyzene ALL=(ALL:ALL) ALL
GRONE	ALL=NOPASSWD: /usr/bin/apt-get update, PASSWD: /usr/bin/apt-get upgrade

# Allow members of group sudo to execute any command
%sudo	ALL=(ALL:ALL) ALL

# See sudoers(5) for more information on "#include" directives:

#includedir /etc/sudoers.d

```

`:10`​ - сбрасывает все пользовательские переменные окружения (мера безопасности)

`:12` - пути для поиска комманд для операций **sudo**

`:23`​ - `NOPASSWD`​ - не будет спрашивать пароль пользователя, `PASSWD`​ - будет спрашивать

**Настройка прав пользователей** (*после строки 20*) 

имеет структуру

`**пользователь** хост = (другой_пользователь:группа) **команды**`

```

```

(Например, `*username *ALL = (ALL:ALL) ALL`​)

`**Пользователь**` указывает пользователя или группу, для которых мы создаем правило, `хост` - компьютер, для которого будет действовать это правило. `другой_пользователь` - под видом какого пользователя первый может выполнять команды, и последнее - разрешенные `**команды**`

**Алиасы**

`тип **имя\_алиаса** = элемент1, элемент2, элемент3`​

(Пример на строке 17)

`тип` указывает какого типа нужно создать алис, **`имя_алиаса`** - имя, которое будет использовано, а список элементов - те элементы, которые будут подразумеваться при обращении к этому имени.

### REF

[sudo](https://losst.ru/nastrojka-sudo-v-linux)

[еще статья](https://www.8host.com/blog/redaktirovanie-fajla-sudoers-v-ubuntu-i-centos/)

