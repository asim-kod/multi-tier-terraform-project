resource "null_resource" "name" {
  depends_on = [module.ec2_public, module.rdsdb]
  #Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ec2-user"
    private_key = file("private-key/NVirginia_key.pem")
  }

  # File Provisioners: Copies the pem key file to /tmp/NVirginia_key.pem
  provisioner "file" {
    source      = "private-key/NVirginia_key.pem"
    destination = "/tmp/NVirginia_key.pem"
  }

  # Remote Exec Provisioners: Using remote-exec provisioner fix the private key permissio on Bastion Host
  provisioner "remote-exec" {
    inline = ["sudo chmod 400 /tmp/NVirginia_key.pem"]
  }

  # Copy SQL file to Bastion
  provisioner "file" {
    source      = "scripts/init.sql"
    destination = "/tmp/init.sql"
  }

  # Execute SQL using MySQL CLI
  provisioner "remote-exec" {
    inline = [
      "mysql -h ${module.rdsdb.db_instance_address} -u ${var.db_username} -p${var.db_password} -D ${var.db_name} < /tmp/init.sql"
    ]
  }
}
