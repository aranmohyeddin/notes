# Django 

### .git/info/exclude
> glassacademy/password.txt                                                               
> glassacademy/secret_key.txt                                                             
> glassacademy/db.py  

### glassacademy/db.py
> def get_db(passwd):
>     return {
>         "default": {
>             "ENGINE": "django.db.backends.postgresql",
>             "NAME": "name",
>             "USER": "uname",
>             "PASSWORD": passwd,
>             "HOST": "host",
>             "PORT": "port",
>         }
>     }

# Database

## enable remote connection

### postgresql.conf
> listen_address = 'localhost,homeaddress' / '*'
> port = ...
    
    netstat -nlt

### pg_hba.conf
> host all all 0.0.0.0/0 md5
> host all all ::/0 md5


