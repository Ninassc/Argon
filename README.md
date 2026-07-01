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

### Funcionalidades Implementadas

- Cadastro de usuários
- Consulta de processos minerários
- Pesquisa de processos minerários
- Visualização de informações detalhadas de processos minerários
- Cadastro de ativos minerários
- Edição de ativos minerários
- Edição de informações do perfil do usuário
- Restrição da edição de ativos minerários aos seus respectivos proprietários
- Integração entre Flutter Web e API REST desenvolvida em Flask

---

# Estrutura do Projeto

```text
Argon/
│
├── backend/
│   ├── controllers/
│   │   ├── ativo_minerario_controller.py
│   │   ├── processo_minerario_controller.py
│   │   └── usuario_controller.py
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
│   │   └── usuario.py
│   │
│   ├── repositories/
│   │   ├── ativo_repository.py
│   │   └── usuario_repository.py
│   │
│   ├── scripts/
│   │   ├── seed.py
│   │   └── sincronizar_anm.py
│   │
│   ├── services/
│   │   ├── ativo_minerario/
│   │   │   ├── atualizar_ativo_service.py
│   │   │   ├── buscar_ativo_service.py
│   │   │   ├── criar_ativo_service.py
│   │   │   ├── deletar_ativo_service.py
│   │   │   └── listar_ativos_usuario_service.py
│   │   │
│   │   ├── processo_minerario/
│   │   │   ├── buscar_processo_id_service.py
│   │   │   ├── importar_processos_anm_service.py
│   │   │   ├── listar_processos_service.py
│   │   │   └── pesquisar_processos_service.py
│   │   │
│   │   ├── sincronizacao/
│   │   │   ├── baixar_dbf_service.py
│   │   │   ├── ler_dbf_service.py
│   │   │   └── sincronizar_base_anm.py
│   │   │
│   │   └── usuario/
│   │       ├── atualizar_usuario_service.py
│   │       ├── buscar_usuario_service.py
│   │       ├── criar_usuario_service.py
│   │       ├── deletar_usuario_service.py
│   │       └── listar_usuarios_service.py
│   │
│   ├── app.py
│   ├── config.py
│   ├── requirements.txt
│   └── .env
│
├── frontend/
│   ├── assets/
│   │
│   ├── lib/
│   │   ├── data/
│   │   │   └── processos_test.dart
│   │   │
│   │   ├── models/
│   │   │   ├── ativo_minerario.dart
│   │   │   ├── processo_minerario.dart
│   │   │   └── usuario.dart
│   │   │
│   │   ├── pages/
│   │   │   ├── auth/
│   │   │   │   ├── cadastro_page.dart
│   │   │   │   └── login_page.dart
│   │   │   │
│   │   │   ├── home/
│   │   │   │   └── home_page.dart
│   │   │   │
│   │   │   └── welcome/
│   │   │       └── welcome_page.dart
│   │   │
│   │   ├── services/
│   │   │   ├── api_service.dart
│   │   │   ├── ativo_service.dart
│   │   │   ├── processo_service.dart
│   │   │   └── usuario_service.dart
│   │   │
│   │   ├── widgets/
│   │   │   ├── buttons/
│   │   │   ├── cards/
│   │   │   │   └── card_processo_minerario.dart
│   │   │   ├── onboarding/
│   │   │   └── textfields/
│   │   │       ├── campo_input.dart
│   │   │       ├── pesquisar_input.dart
│   │   │       └── tipo_conta.dart
│   │   │
│   │   └── main.dart
│   │
│   ├── android/
│   ├── ios/
│   ├── linux/
│   ├── macos/
│   ├── web/
│   └── windows/
│
├── README.md
└── .gitignore
```

---

# Organização das Pastas

## Backend

### controllers/

Responsáveis por receber as requisições HTTP, chamar os services e retornar as respostas da API.

### services/

Contêm toda a regra de negócio da aplicação.

Os serviços estão organizados por domínio:

- usuário
- processo minerário
- ativo minerário
- sincronização

### models/

Representam as entidades do sistema e realizam operações de persistência no banco.

### repositories/

Responsáveis por consultas específicas ao banco de dados.

### scripts/

Scripts auxiliares utilizados durante o desenvolvimento, como população do banco e sincronização da base da ANM.

---

## Frontend

### pages/

Telas da aplicação.

### widgets/

Componentes reutilizáveis da interface.

### services/

Responsáveis pela comunicação com a API Flask.

### models/

Representação das entidades consumidas pela API.

### data/

Arquivos auxiliares utilizados durante o desenvolvimento.

---

# Comunicação da Aplicação

```text
Flutter
        │
        ▼
 Services (Dart)
        │
      HTTP
        │
        ▼
Controllers (Flask)
        │
        ▼
Services (Python)
        │
        ▼
Models
        │
        ▼
MySQL
```

---

# Como Executar o Projeto

## Pré-requisitos

- Flutter SDK
- Python 3.11+
- MySQL
- Git

---

## Clonar o Repositório

```bash
git clone https://github.com/Ninassc/Argon.git
cd Argon
```

---

## Backend

Entre na pasta do backend.

```bash
cd backend
```

Instale as dependências.

```bash
pip install -r requirements.txt
```

Configurar o arquivo `.env` com as credenciais do MySQL.

Executar a API:

```bash
python app.py
```

Opcionalmente, popular o banco de dados para testes:

```bash
python scripts/seed.py
```

---

## Frontend

Entre na pasta do frontend.

```bash
cd frontend
```

Instale as dependências.

```bash
flutter pub get
```

Executar a aplicação:

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

Projeto acadêmico em desenvolvimento para a disciplina de Projeto de Software.

Atualmente o sistema possui integração entre frontend e backend utilizando API REST, permitindo consulta e gerenciamento de usuários, processos minerários e ativos minerários.
