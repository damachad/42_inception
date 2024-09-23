# Inception

## 🌟 Overview

This project aims to provide a robust and scalable environment using Docker Compose. 
Each service is encapsulated within its own container, ensuring modularity and ease of management. 
The setup includes:

- **NGINX**: Configured with TLSv1.2 or TLSv1.3 for secure connections.
- **WordPress**: Running with PHP-FPM, excluding NGINX.
- **MariaDB**: As the database service for WordPress.
- **Volumes**: Persistent storage for WordPress files and database.
- **Custom Network**: For seamless inter-container communication.

## ⚙️ Prerequisites

- Docker
- Docker Compose
- Make

## 🚀 Installation
1. **Clone the repository**
   ```sh
   git clone https://github.com/damachad/42_inception.git
   cd 42_inception
   ```
2. **Update .env file with your variables**
   ```
   DOMAIN_NAME=login.42.fr
    # MDB SETUP
    DB_NAME=*******
    DB_HOST=*******
    DB_USER=*******
    DB_PWD=*******
    DB_R_PWD=*******
    
    # WP SETUP
    WP_ADMIN_N=*******
    WP_ADMIN_P=*******
    WP_TITLE=*******
    WP_ADMIN_E=*******
    
    # WP NEW USER SETUP
    WP_U_NAME=*******
    WP_U_PASS=*******
    WP_U_ROLE=*******
    WP_U_EMAIL=*******
    WP_URL=https://login.42.fr
   ```
3. **Update the the volumes' paths**   
Update the Makefile where it says WP_DATA and DB_DATA, with /home/login/data/wordpress/ and /home/login/data/mariadb/ respectively (updating with your login).
Update the **docker-compile.yml** file with this information in the volumes section.
4. **Stop MariaDB and NGINX from your machine**   
 If you have mariadb or NGINX running on your machine, stop them before running by running:
``` sh
sudo systemctl mariadb stop
sudo systemctl nginx stop
```
5. **Run the Makefile**
   ```sh
   make
   ```
6. **Access the domain name on your browser**

## 🗒️ Notes
[Documentation](https://spicy-dirigible-2b6.notion.site/Inception-b663a32e459b46c3b32874241c08e582)
