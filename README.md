[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/hardwareontrial/backend-php-migisapp/graphs/commit-activity)
![Maintainer](https://img.shields.io/badge/Maintainer-IT%20MIG-blue)
[![PHP](https://img.shields.io/badge/PHP-7.4-1abc9c.svg)](https://www.php.net/releases/7_4_0.php)
[![Composer](https://img.shields.io/badge/Composer-2.2.LTS-907f61.svg)](https://getcomposer.org/download/)

## Backend-PHP

Provide MIG-IS logical as backend served by Laravel 8 querying database. It's controlling most of all application menu inside. Completely using powerfull other library to take best performing.

### Features

- Use [Laravel 8](https://laravel.com/docs/8.x),
- Use Sanctum for Auth Token Support,
- Using 2 databases, for storage and attendance logs,
- Serve logic for Phonebook, Quiz& Achivement, Todo, User Management, Presence Monitoring, Delivery Note, and Inventaris Data.
- On going: Reservation.

### Installation
- Import sql file (on supporting_files folder) to database, it's contain database structure.
```
mysql database_name < structure_db.sql
```
- Before build dockerize app, Dockerfile contain own Image based on Debian, clone it first:
```
cd root-project
git clone https://github.com/hardwareontrial/baseOS-v1.git base-image
cd base-image
docker build -t mig/debian:bullseye .
```
- Clone this project to folder root & build dockerize:
```
mkdir -p root-project/app
cd root-project/app
git clone https://github.com/hardwareontrial/backend-php-migisapp.git backend-php
cd backend-php
docker build -t migisapp/backend-php:latest .
```
- Copy docker compose file and edit if needed, adjust to INTERNAL configuration:
```
cp root-project/app/supporting_files/docker-compose.yaml root-project/backend-php.yaml
```
- Create folder to store data and config
```
mkdir -p root-project/config/backend-php
mkdir -p root-project/data/backend-php
```
- Copy configuration file at supporting_files and supervisord folder to root-project/config:
```
cp -R supervisord/ root-project/config/backend-php
cp 10-phpini-overrides.ini root-project/config/backend-php
cp nginx.conf root-project/config/backend-php
cp www.conf root-project/config/backend-php
cp supervisor.conf root-project/config/backend-php
```
- Data inside express public folder can be accessed in this folder.
```
root-project/data/backend-php
```
- Start docker using:
```
docker compose -f "root-project/backend-php.yaml" up -d
```
- Enter docker using command below, then do this:
```
docker exec -it <container_name> bash
php artisan cache:clear
php artisan config:clear
php artisan config:cache
php artisan storage:link
```
- Check using postman.
