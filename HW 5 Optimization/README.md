## Домашее задание № 5 Оптимизация WordPress

### Занятие 10. Оптимизация производительности веб-сервисов // ДЗ 

#### Цель

- настроить клиентские и серверные механизмы оптимизации в Angie для повышения производительности веб-приложения.

#### Описание домашнего задания

Инструкция:

Рассмотрите, какие возможности по клиентской оптимизации вы можете применить для текущей конфигурации.
Внесите изменения в настройки сайта.
Настройте серверное кэширование одной страницы сайта.
Обоснуйте использование тех или иных решений.
Дополнительно: проведите тестирование сайта до и после оптимизации, сделайте выводы об эффективности шагов.


#### Ход работы

1. Создали ВМ в Яндекс.Облако и развернули Angie

2. Установка php-fpm 8.3 с расширениями

3. Установка и настройка MariaDB

4. Установка и настройка портала CMS Wordpress

5. Клиентская оптимизация портала

```
# 1. Настройка современного сжатия (в блоке http или server)
gzip on;
gzip_comp_level 5;
gzip_types text/plain text/css application/javascript application/json text/xml image/svg+xml;

# Использование Brotli — в Angie модуль встроен по умолчанию
brotli on;
brotli_comp_level 4;
brotli_types text/plain text/css application/javascript application/json text/xml image/svg+xml;

server {
    listen 80;
    server_name _;
    root /var/www/wordpress;
    index index.php;

    # 2. Кэширование статики в браузере пользователя
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|otf)$ {
        expires 30d;
        add_header Cache-Control "public, no-transform";
        access_log off;
        log_not_found off;
    }

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```

#### Обоснование:
- Алгоритм Brotli сжимает файлы стилей и скриптов в среднем на 15–20% лучше старого Gzip, ускоряя рендеринг страницы на смартфонах. Gzip оставлен как фолбек.
- Директива expires 30d заставляет браузер сохранять тяжелую статику локально. При переходах по страницам сайта пользователь не скачивает повторно логотипы и CSS.
- access_log off; убирает лишние операции записи на диск (I/O) сервера для каждого запроса картинки.

6. Сереверное кэширование одной страницы сайта

```
angie.conf: 
proxy_cache_valid 1m; 
proxy_cache_key $scheme$host$request_uri; 
proxy_cache_path /cache levels=1:2 keys_zone=one:10m:file=/etc/angie/cache.state inactive=48h max_size=800m; 
server.conf: 
location / {    
    proxy_cache one;    
    proxy_cache_valid 200 1h;    
    proxy_cache_lock on;    
    proxy_cache_min_uses 2;    
    proxy_ignore_headers "Cache-Control" "Expires";    
    proxy_cache_use_stale updating error timeout invalid_header http_500 http_502 http_504;    
    proxy_cache_background_update on; }
```

#### Результат

Проведена клиентская оптимизация портала. Настроено серверное кэширование корня сайта.




