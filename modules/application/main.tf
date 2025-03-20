resource "aws_instance" "app_server_1" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_1_id
  security_groups = [var.security_group_id]

   user_data = <<-EOF
    <powershell>
    # Instalar o IIS (Servidor Web)
    Install-WindowsFeature -name Web-Server -IncludeManagementTools

    # Criar um arquivo HTML com "Hello World1"
    $sitePath = "C:\\inetpub\\wwwroot\\index.html"
    Set-Content -Path $sitePath -Value "<html><body><h1>Hello World1 - EC2 I</h1></body></html>"
	
	New-NetFirewallRule -DisplayName "Allow HTTP Inbound" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow
    New-NetFirewallRule -DisplayName "Allow HTTPS Inbound" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow
    New-NetFirewallRule -DisplayName "Allow HTTP Outbound" -Direction Outbound -Protocol TCP -LocalPort 80 -Action Allow
    New-NetFirewallRule -DisplayName "Allow HTTPS Outbound" -Direction Outbound -Protocol TCP -LocalPort 443 -Action Allow

    # Reiniciar o IIS para aplicar as mudanças
    Restart-Service W3SVC
    </powershell>
EOF
tags = { Name = "AppServer1" }
}

resource "aws_instance" "app_server_2" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_2_id
  security_groups = [var.security_group_id]
  

   user_data = <<-EOF
    <powershell>
    # Instalar o IIS (Servidor Web)
    Install-WindowsFeature -name Web-Server -IncludeManagementTools

    # Criar um arquivo HTML com "Hello World2"
    $sitePath = "C:\\inetpub\\wwwroot\\index.html"
    Set-Content -Path $sitePath -Value "<html><body><h1>Hello World2 - EC2 II</h1></body></html>"
	
	New-NetFirewallRule -DisplayName "Allow HTTP Inbound" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow
    New-NetFirewallRule -DisplayName "Allow HTTPS Inbound" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow
    New-NetFirewallRule -DisplayName "Allow HTTP Outbound" -Direction Outbound -Protocol TCP -LocalPort 80 -Action Allow
    New-NetFirewallRule -DisplayName "Allow HTTPS Outbound" -Direction Outbound -Protocol TCP -LocalPort 443 -Action Allow

    # Reiniciar o IIS para aplicar as mudanças
    Restart-Service W3SVC
    </powershell>
EOF
tags = { Name = "AppServer2" }
}
