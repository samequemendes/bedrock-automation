# 4Linux DevOps - Provisionamento e Deploy no AWS Elastic Beanstalk

Este projeto utiliza **Terraform** para provisionar a infraestrutura necessária e **GitHub Actions** para automação do deploy da aplicação no **Bedrock**.

## 📋 **Pré-requisitos**

Antes de começar, certifique-se de que você tem os seguintes requisitos instalados:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) (versão recomendada: `>= 1.0.0`)
- [AWS CLI](https://aws.amazon.com/cli/) configurado (`aws configure`)
- [GitHub CLI](https://cli.github.com/)
- Permissões adequadas no **AWS IAM** para criar recursos no **Elastic Beanstalk**
- Um bucket S3 para armazenar os pacotes da aplicação

---

## 🚀 **1. Como Provisionar a Infraestrutura**

O provisionamento da infraestrutura é feito com **Terraform**.

### **1️⃣ Inicializar Terraform**

```sh
cd infra
terraform init
```

### **2️⃣ Validar Configuração**

```sh
terraform validate
```

### **3️⃣ Criar o Plano de Execução**

```sh
terraform plan -var-file=environments/hml.tfvars
```

### **4️⃣ Aplicar o Terraform**

Para **staging** (`us-east-2`):

```sh
terraform apply -var-file=environments/hml.tfvars -auto-approve
```

Para **produção** (`us-east-1`):

```sh
terraform apply -var-file=environments/prd.tfvars -auto-approve
```

---

## 🚀 **2. Como Realizar o Deploy da Aplicação**

O deploy é automatizado via **GitHub Actions**, mas também pode ser feito manualmente.

### **1️⃣ Criar um pacote ZIP da aplicação**

```sh
cd src
zip -r ../app.zip . -x ".git/*" "__pycache__/*" "venv/*" "*.DS_Store"
```

### **2️⃣ Fazer Upload do ZIP para o S3**

```sh
aws s3 cp ../app.zip s3://meu-bucket-deploy/app.zip
```

### **3️⃣ Criar uma Nova Versão da Aplicação no Elastic Beanstalk**

```sh
aws elasticbeanstalk create-application-version \
  --application-name 4linux-devops-samequemendes \
  --version-label app-$(date +%Y%m%d%H%M%S) \
  --source-bundle S3Bucket=meu-bucket-deploy,S3Key=app.zip
```

### **4️⃣ Atualizar o Ambiente no Beanstalk**

```sh
aws elasticbeanstalk update-environment \
  --environment-name 4linux-devops-samequemendes-env \
  --version-label app-$(date +%Y%m%d%H%M%S)
```

---

## 🛠️ **3. Como Funciona a Pipeline do GitHub Actions**

A pipeline do **GitHub Actions** é dividida em quatro etapas principais:

1. **Lint & Testes** → Valida a qualidade do código.
2. **Deploy da Infraestrutura** → Provisiona a infraestrutura na AWS via Terraform.
3. **Deploy da Aplicação** → Faz upload do pacote para o S3 e atualiza o Beanstalk.
4. **Destroy Manual (Opcional)** → Pode ser acionado manualmente para destruir a infraestrutura.

### **Executar a Pipeline Manualmente**

Se precisar rodar a pipeline manualmente:

1. Vá até **GitHub → Actions**.
2. Escolha o workflow **"Deploy Infra & App"**.
3. Clique em **"Run workflow"** e selecione o ambiente (`staging` ou `prod`).

---

## 🔥 **4. Como Destruir o Ambiente**

A destruição do ambiente **precisa ser aprovada manualmente**.

### **1️⃣ Rodar Manualmente pelo GitHub Actions**

1. Vá até **GitHub → Actions**.
2. Escolha o workflow **"Destroy Infra"**.
3. Clique em **"Run workflow"** e aprove a execução.

### **2️⃣ Rodar Manualmente pelo Terraform**

Para **staging**:

```sh
terraform destroy -var-file=environments/hml.tfvars -auto-approve
```

Para **produção**:

```sh
terraform destroy -var-file=environments/prd.tfvars -auto-approve
```

---

## 📚 **5. Tecnologias Utilizadas**

- **Terraform** → Provisionamento da infraestrutura.
- **AWS Elastic Beanstalk** → Hospedagem da aplicação.
- **AWS S3** → Armazenamento do pacote da aplicação.
- **GitHub Actions** → Automação de deploys.
- **Python** (Flask) → Aplicação backend.

---

## 🔧 **6. Variáveis de Ambiente Utilizadas**

Para clonar e rodar este projeto corretamente, configure as seguintes variáveis de ambiente:

- `AWS_ACCESS_KEY_ID` → Chave de acesso AWS
- `AWS_SECRET_ACCESS_KEY` → Chave secreta AWS
- `AWS_REGION` → Região da AWS (`us-east-1` ou `us-east-2`)
- `S3_BUCKET` → Nome do bucket S3 onde os pacotes serão armazenados
- `APP_NAME` → Nome da aplicação no Elastic Beanstalk
- `ENVIRONMENT_NAME` → Nome do ambiente no Beanstalk (`hml` ou `prd`)

---

## ✨ **7. Melhorias Futuras**

- Implementar **monitoramento com CloudWatch**.
- Configurar **Auto Scaling** para otimizar custos.
- Adicionar **tests unitários e integração** na pipeline.

Se tiver dúvidas ou quiser contribuir, fique à vontade! 🚀🔥

