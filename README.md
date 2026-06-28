# Argon

## Plataforma de Organização e Compartilhamento de Direitos Minerários

O **Argon** é uma plataforma web desenvolvida para organizar, validar e compartilhar informações relacionadas a direitos minerários. A aplicação utiliza dados públicos da Agência Nacional de Mineração (ANM) para disponibilizar uma base confiável de consulta e permitir que usuários organizem seus ativos minerários em um ambiente seguro e estruturado.

---

## Repositório

https://github.com/Ninassc/Argon

---

## Integrantes da Equipe

- Nina Sepúlveda Soares Carvalho
- Victor Emanuel Pancote
- Antônio Franco Silva
- André Yuri Moreira
- Rafael Muniz de Holanda
- Thomas Andrew Schafer de Souza

---

# Tecnologias Utilizadas

## Frontend

- Flutter
- Dart

## Backend

- Python
- Flask
- SQLAlchemy

## Banco de Dados

- MySQL

---

## Sobre o Projeto

O Argon é uma plataforma web desenvolvida para organizar, validar e compartilhar informações relacionadas a processos minerários ativos em Minas Gerais.

O sistema utiliza dados oficiais da Agência Nacional de Mineração (ANM) para verificar processos minerários e permitir que seus titulares organizem informações complementares em um ambiente estruturado e seguro.

A plataforma possibilita o cadastro de ativos minerários, gerenciamento de documentos, controle de acesso às informações, sistema de favoritos e acompanhamento de interações, oferecendo maior organização e confiabilidade no compartilhamento de dados.

---

# Funcionalidades

## Implementadas

- Cadastro de usuários
- Consulta de processos minerários
- Pesquisa de processos minerários
- Cadastro de ativos minerários
- Gerenciamento de ativos minerários
- Estrutura para sincronização automática da base da ANM

## Em desenvolvimento

- Autenticação de usuários
- Sistema de favoritos
- Upload e gerenciamento de documentos
- Solicitação de acesso a documentos
- Compartilhamento controlado de informações
- Registro de acessos
- Exportação de dados

---

# Arquitetura

O backend foi desenvolvido seguindo uma arquitetura em camadas, separando as responsabilidades da aplicação.

- **Controllers:** recebem as requisições HTTP e retornam respostas da API.
- **Services:** implementam as regras de negócio do sistema.
- **Models:** representam as entidades e realizam operações de persistência utilizando SQLAlchemy.
- **Scripts:** executam processos internos, como população do banco e sincronização da base da ANM.

---

# Estrutura do Projeto

```text
Argon/
│
├── frontend/
│   ├── assets/
│   │   └── images/
│   │
│   ├── lib/
│   │   ├── data/
│   │   ├── models/
│   │   ├── pages/
│   │   │   ├── auth/
│   │   │   ├── home/
│   │   │   └── welcome/
│   │   ├── widgets/
│   │   └── main.dart
│   │
│   ├── android/
│   ├── ios/
│   ├── linux/
│   ├── macos/
│   ├── web/
│   ├── windows/
│   └── test/
│
├── backend/
│   ├── controllers/
│   │   ├── usuario_controller.py
│   │   ├── processo_minerario_controller.py
│   │   └── ativo_minerario_controller.py
│   │
│   ├── database/
│   │   └── create_database.sql
│   │
│   ├── models/
│   │   ├── acesso.py
│   │   ├── ativo_minerario.py
│   │   ├── documento.py
│   │   ├── favorito.py
│   │   ├── processo_minerario.py
│   │   ├── usuario.py
│   │   └── __init__.py
│   │
│   ├── scripts/
│   │   ├── seed.py
│   │   └── sincronizar_anm.py
│   │
│   ├── services/
│   │   ├── ativo_minerario/
│   │   ├── processo_minerario/
│   │   ├── sincronizacao/
│   │   └── usuario/
│   │
│   ├── app.py
│   ├── config.py
│   ├── requirements.txt
│   └── .env
│
├── README.md
└── .gitignore
```

---

# Organização das Pastas

## Frontend

Responsável pela interface da aplicação desenvolvida em Flutter.

- **pages/**: telas da aplicação.
- **widgets/**: componentes reutilizáveis da interface.
- **models/**: modelos utilizados pelo frontend.
- **data/**: dados temporários utilizados durante o desenvolvimento.
- **assets/**: imagens e demais recursos gráficos.

## Backend

Responsável pela API e pelas regras de negócio.

- **controllers/**: endpoints da API REST.
- **services/**: implementação das regras de negócio.
- **models/**: entidades e operações de acesso ao banco de dados.
- **scripts/**: scripts auxiliares para desenvolvimento e sincronização da base da ANM.
- **database/**: scripts SQL do projeto.

---

# Como Executar o Projeto

## Pré-requisitos

- Flutter SDK
- Python 3.11 ou superior
- MySQL Server
- Git

---

## Clonar o Repositório

```bash
git clone https://github.com/Ninassc/Argon.git
cd Argon
```

---

# Executando o Backend

Entre na pasta do backend.

```bash
cd backend
```

Instale as dependências.

```bash
pip install -r requirements.txt
```

Configure a conexão com o banco de dados no arquivo `.env`.

Crie o banco de dados executando o script:

```text
backend/database/create_database.sql
```

Execute a API.

```bash
python app.py
```

Caso queira popular o banco com dados fictícios para testes, execute:

```bash
python scripts/seed.py
```

---

# Executando o Frontend

Entre na pasta do frontend.

```bash
cd frontend
```

Instale as dependências.

```bash
flutter pub get
```

Execute a aplicação.

```bash
flutter run -d chrome
```

---

# Banco de Dados

O projeto utiliza o MySQL como sistema gerenciador de banco de dados.

As tabelas são criadas automaticamente pela aplicação utilizando SQLAlchemy, enquanto o script presente em `database/create_database.sql` é responsável pela criação inicial do banco.

---

# Fonte dos Dados

O Argon utiliza dados públicos disponibilizados pela **Agência Nacional de Mineração (ANM)**.

A sincronização da base de processos minerários foi projetada para importar periodicamente os arquivos oficiais disponibilizados pela ANM, permitindo manter a base da plataforma sempre atualizada.

---

# Status do Projeto

Projeto acadêmico desenvolvido para a disciplina de Projeto de Software.

Atualmente encontra-se em desenvolvimento contínuo, com funcionalidades de gerenciamento de usuários, processos minerários e ativos minerários implementadas e novas funcionalidades sendo desenvolvidas.