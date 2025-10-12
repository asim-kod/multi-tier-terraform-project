#!/bin/bash
set -e # If any command fails then stop the script immediately.

sudo yum update -y
sudo yum install java -y

# Create tomcat directory
sudo mkdir -p /opt/tomcat9

# Download Tomcat tarball to specific path
sudo wget https://github.com/asim-kod/terraform-3tier-architecture-project/raw/refs/heads/main/artifacts/tomcat9.tar.gz \
  -O /opt/tomcat9/tomcat9.tar.gz

# Extract the tarball
sudo tar -xvzf /opt/tomcat9/tomcat9.tar.gz -C /opt/tomcat9 --strip-components=1

# Remove the tarball after extraction
sudo rm -f /opt/tomcat9/tomcat9.tar.gz

# Download WAR file from GitHub
sudo wget https://github.com/asim-kod/terraform-3tier-architecture-project/raw/refs/heads/main/artifacts/student-login.war \
  -O /opt/tomcat9/webapps/student-login.war

# Download JDBC driver from GitHub
sudo wget https://github.com/asim-kod/terraform-3tier-architecture-project/raw/refs/heads/main/artifacts/mariadb-java-client-3.5.3.jar \
  -O /opt/tomcat9/lib/mariadb-java-client-3.5.3.jar

# Edit Context.xml
sudo sed -i '/<\/Context>/i \
  <Resource name="jdbc/TestDB" auth="Container"\
            type="javax.sql.DataSource"\
            username="${db_username}"\
            password="${db_password}"\
            driverClassName="org.mariadb.jdbc.Driver"\
            url="jdbc:mariadb://${db_endpoint}:3306/${db_name}"\
            maxActive="100" maxIdle="30" maxWait="10000"/>' /opt/tomcat9/conf/context.xml

# # Set executable permissions on Tomcat scripts
# sudo chmod +x /opt/tomcat9/bin/*.sh

# Start Tomcat
sudo /opt/tomcat9/bin/startup.sh
