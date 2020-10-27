provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "firstdemo" {
  key_name                    = "nag-NVirginia"
  ami                         = "ami-011b3ccf1bd6db744"
  instance_type               = "t2.micro"
  vpc_security_group_ids      =  ["sg-00319e8b7cfa57448"]
  #vpc_id = aws_vpc.default.id
  subnet_id                   = var.subnet
  associate_public_ip_address = true

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install python3-pip",
      "sudo yum  install  https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y",
      "sudo yum update -y",
      "sudo yum repolist",
      "sudo yum install ansible -y",
      "sudo yum install git -y",
      "git clone https://github.com/Nagendra-ch/test2.git /tmp/ans",
      "sleep 30; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook /tmp/ans/ngnixplay.yml"
      ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        =  self.public_ip
      private_key = var.keyfile
    }
  }
}