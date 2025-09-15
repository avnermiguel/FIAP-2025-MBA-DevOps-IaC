# FIAP-2025-MBA-DevOps-IaC Avner Santos
Este projeto foi desenvolvido como trabalho final para a disciplina de Infraestrutura como Código (IaC) do MBA em DevOps da FIAP (turma 2025).

# Descrição do projeto
A estrutura do projeto é organizada da seguinte forma:

```
FIAP-2025-MBA-DevOps-IaC/
│
├── .github/workflows/          # Arquivos de automação CI/CD (GitHub Actions, etc)
|
├── Ansible/            # Playbook do Ansible e arquivos html
|
├── IAC/                # Infraestrutura como Código (Terraform, módulos, states)
│
└── README.md           # Documentação do projeto
```
# Pré-requisitos
- Criar os secrets em seu projeto no GitHub com os valores da sua conta da AWS:
    -   `AWS_ACCESS_KEY_ID`
    -   `AWS_SECRET_ACCESS_KEY`
    -   `AWS_SESSION_TOKEN`
- Criar um par de chaves na sua conta AWS.
- Criar um segredo no AWS Secrets Manager com a chave **privada** criada, no formato de texto simples.
- Definir um nome único para o bucket S3 nos arquivos `./IaC/S3/main.tf` e `./IaC/backend.tf`.

# Pipeline
Definição das atividades realizadas no pipeline:

1.  O primeiro job cria um bucket S3, caso não exista, para armazenar o `tfstate` do Terraform principal.
2.  O segundo job executa o Terraform, que cria os seguintes recursos:
    *   **Módulo VPC:** Cria VPC, Subnet, Internet Gateway e Tabela de Roteamento.
    *   **Módulo EC2:** É utilizado para criar uma instância para homologação e outra para produção.
    *   **Módulo Ansible:** É utilizado para criar uma instância e executar comandos via `remote-exec` para instalar o Ansible, criar o arquivo de inventário, copiar a chave SSH e executar o playbook.

# Ansible
O playbook do Ansible é utilizado para copiar os arquivos `index.html` para as respectivas instâncias de homologação e produção.

# Observações
O AWS Secrets Manager foi utilizado para preencher a variável `ssh_key` e permitir a conexão com as instâncias.
