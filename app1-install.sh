#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable --now httpd

# Variables
HOSTNAME=$(hostname)
OS_NAME=$(grep "^PRETTY_NAME=" /etc/os-release | cut -d= -f2 | tr -d '"')
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id)
INSTANCE_TYPE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-type)

sudo mkdir -p /var/www/html/app1

# app1/index.html (root) 
# Extras = <tee -a> will append the data
cat <<EOF | sudo tee /var/www/html/app1/index.html > /dev/null
<html>
  <body style="margin:0; height:100vh; font-family:sans-serif; background:#fff; color:#0066a0; position:relative;">
    <img 
      src="https://octodex.github.com/images/spidertocat.png" 
      alt="Spidertocat" 
      style="width:300px; position:absolute; left:50%; transform:translateX(-50%) translateY(-118%); top:50%;"
    />
    <div style="display:flex; justify-content:center; align-items:center; height:100%;">
      <div style="text-align:center; background:#e6f3fc; padding:20px 30px; border-radius:8px; box-shadow:0 2px 6px #0000001a;">
        <h1 style='font-size:2rem; margin:0;'>APP-1 Deployed Successfully</h1>
      </div>
    </div>
  </body>
</html>
EOF

# /app1/index.html detailed info page
cat <<EOF | sudo tee /var/www/html/app1/metadata.html > /dev/null
<html>
<body style="font-family:sans-serif;background:#f5faff;color:#1e293b;padding:50px;margin:0;display:flex;justify-content:center;align-items:center;height:100vh;">
  <div style="background:#fff;padding:30px 40px;border-radius:8px;box-shadow:0 4px 8px rgba(0,0,0,0.1);min-width:320px;">
    <h1 style="color:#0066a0;margin-bottom:25px;text-align:center;">APP-1 Instances Overview</h1>
    <table style="width:100%;border-collapse: collapse;">
      <tbody>
        <tr style="background:#f9fafb;">
          <td style="padding:8px 12px;font-weight:bold;">Deployment:</td>
          <td style="padding:8px 12px;color:#0066a0;font-weight:bold;">Terraform</td>
        </tr>
        <tr>
          <td style="padding:8px 12px;font-weight:bold;">Hostname:</td>
          <td style="padding:8px 12px;">$HOSTNAME</td>
        </tr>
        <tr  style="background:#f9fafb;">
          <td style="padding:8px 12px;font-weight:bold;">Operating System:</td>
          <td style="padding:8px 12px;">$OS_NAME</td>
        </tr>
        <tr>
          <td style="padding:8px 12px;font-weight:bold;">Instance ID:</td>
          <td style="padding:8px 12px;">$INSTANCE_ID</td>
        </tr>
        <tr style="background:#f9fafb;">
          <td style="padding:8px 12px;font-weight:bold;">Instance Type:</td>
          <td style="padding:8px 12px;">$INSTANCE_TYPE</td>
        </tr>        
        <tr>
          <td style="padding:8px 12px;font-weight:bold;">Availability Zone:</td>
          <td style="padding:8px 12px;">$AZ</td>
        </tr>
      </tbody>
    </table>
  </div>
</body>
</html>
EOF
