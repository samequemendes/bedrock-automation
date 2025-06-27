





📦 infra
├── 📁 environments
│   ├── hml.tfvars  # Variáveis para ambiente staging (us-east-2)
│   ├── prd.tfvars  # Variáveis para ambiente produção (us-east-1)
│   ├── README.md
├── backend.tf      # Configuração do state remoto no S3
├── main.tf         # Definição dos recursos AWS (Beanstalk, S3, IAM, ALB)
├── outputs.tf      # Exibir o DNS do ALB
├── provider.tf     # Configuração do provedor AWS
├── terraform.tfvars # Valores padrão
├── variables.tf    # Definição das variáveis
└── README.md
