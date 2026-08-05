# Infra Banco

Repositório responsável pelo provisionamento da infraestrutura de banco de dados da plataforma Vehicle Sales.

## Recursos Provisionados

- AWS RDS PostgreSQL
- AWS Security Group
- AWS Secrets Manager

## Estrutura

```text
infra-banco

|-- modules
|   `-- postgres
|       |-- main.tf
|       |-- variables.tf
|       `-- outputs.tf
|
|-- .github
|   `-- workflows
|       `-- terraform.yml
|
|-- provider.tf
|-- variables.tf
|-- terraform.tfvars
|-- main.tf
|-- outputs.tf
|-- .gitignore
`-- README.md
```

## Secrets Necessários

Adicionar os seguintes secrets no GitHub:

```text
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
DB_USERNAME
DB_PASSWORD
```

### AWS_ACCESS_KEY_ID

AWS Console:

```text
IAM
  -> Users
      -> Seu Usuário
          -> Security Credentials
              -> Create Access Key
```

### AWS_SECRET_ACCESS_KEY

Gerado junto com a Access Key.

A AWS só exibe esse valor uma única vez.

### AWS_REGION

Exemplo:

```text
sa-east-1
```

### DB_USERNAME

Exemplo:

```text
postgres
```

### DB_PASSWORD

Exemplo:

```text
VehicleSales@2025!
```

## Fluxo de Deploy

Após merge na branch main:

```text
GitHub Actions
      |
      v
Terraform Init
      |
      v
Terraform Validate
      |
      v
Terraform Plan
      |
      v
Terraform Apply
      |
      v
AWS RDS PostgreSQL
```

## Observação

A criação das tabelas não é responsabilidade deste repositório.

A API executa automaticamente:

```csharp
dbContext.Database.Migrate();
```

====================================================================
OBSERVAÇÃO DE ARQUITETURA
====================================================================

O PostgreSQL será provisionado dentro da VPC criada pelo
repositório infra-cluster.

O módulo de banco consumirá:

- VPC ID
- Private Subnets
- Security Group

exportados pelo cluster.

Dessa forma o banco ficará privado e acessível
somente a partir do EKS.

durante sua inicialização.

Portanto este repositório provisiona apenas a infraestrutura do banco de dados.