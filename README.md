# Argon

# Plataforma de Organização e Compartilhamento Controlado de Direitos Minerários

O **Argon** é uma plataforma web desenvolvida para organizar, consultar e compartilhar informações relacionadas a processos minerários utilizando dados públicos da **Agência Nacional de Mineração (ANM)**.

O sistema integra uma API REST desenvolvida em **Flask** com uma interface em **Flutter Web**, permitindo que usuários consultem processos minerários, organizem seus ativos, acompanhem informações detalhadas e gerenciem seus direitos minerários de forma estruturada e segura.

O projeto foi desenvolvido como parte da disciplina de **Projeto de Software**.

---

## Repositório

https://github.com/Ninassc/Argon

---

# Equipe

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
- Stored Procedures

## Ferramentas

- Git
- GitHub
- Postman

---

# Visão Geral

O Argon foi desenvolvido para facilitar o gerenciamento de direitos minerários por meio de uma plataforma web integrada à base pública da Agência Nacional de Mineração (ANM).

Além da consulta aos processos minerários, o sistema permite que cada usuário organize seus próprios ativos minerários, registre descrições personalizadas, visualize detalhes completos dos processos e acompanhe informações atualizadas provenientes da ANM.

A arquitetura foi construída seguindo a separação em camadas, promovendo organização, reutilização de código e facilidade de manutenção.

---

# Funcionalidades

## Usuários

- Cadastro de usuários
- Login
- Autenticação
- Consulta de perfil
- Atualização de perfil
- Alteração de senha
- Exclusão de conta

---

## Processos Minerários

- Consulta paginada
- Pesquisa por texto
- Visualização detalhada
- Paginação infinita (Infinite Scroll)
- Filtro por fase
- Filtro por substância mineral
- Consulta utilizando dados oficiais da ANM

---

## Ativos Minerários

- Cadastro de ativos
- Edição de ativos
- Exclusão de ativos
- Associação entre usuário e processo minerário
- Validação para impedir ativos duplicados
- Restrição de edição apenas ao proprietário

---

## Sincronização

- Importação automática da base da ANM
- Atualização de processos existentes
- Inserção de novos processos
- Scheduler para sincronização periódica

---

# Arquitetura

O projeto segue uma arquitetura em camadas.

```text
Flutter Web
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
Repositories
        │
        ▼
Stored Procedures
        │
        ▼
MySQL
```

Cada camada possui responsabilidades específicas, facilitando manutenção, testes e evolução da aplicação.

---

# Organização do Backend

## Controllers

Recebem as requisições HTTP, validam parâmetros, chamam os serviços responsáveis e retornam as respostas da API.

---

## Services

Contêm toda a regra de negócio da aplicação.

Os serviços estão organizados por domínio:

- Usuário
- Processo Minerário
- Ativo Minerário
- Autenticação
- Sincronização

---

## Repositories

Responsáveis pelo acesso aos dados.

Centralizam consultas SQL, execução de Stored Procedures e comunicação com o banco de dados.

---

## Models

Representam as entidades persistidas no banco de dados através do SQLAlchemy.

---

## Scripts

Contêm scripts auxiliares utilizados durante o desenvolvimento, como sincronização da base da ANM e população do banco.

---

# Organização do Frontend

## Pages

Contêm as telas da aplicação.

- Welcome
- Login
- Cadastro
- Home
- Perfil
- Editar Perfil
- Detalhes do Processo
- Pesquisa de Ativos

---

## Widgets

Componentes reutilizáveis da interface.

Entre eles:

- Cards
- Buttons
- Bottom Sheets
- TextFields

---

## Services

Responsáveis pela comunicação entre Flutter e API REST.

---

## Models

Representam as entidades retornadas pela API.

---

## Storage

Gerenciamento das informações persistidas localmente.

---

# Estrutura do Projeto

A estrutura do Argon foi organizada separando frontend, backend, regras de negócio, persistência, sincronização de dados e componentes reutilizáveis.

```text
Argon/
│
├── backend/
│   │
│   ├── controllers/
│   │   ├── __init__.py
│   │   ├── ativo_minerario_controller.py
│   │   ├── auth_controller.py
│   │   ├── processo_minerario_controller.py
│   │   └── usuario_controller.py
│   │
│   ├── database/
│   │   ├── create_database.sql
│   │   └── procedures.sql
│   │
│   ├── models/
│   │   ├── __init__.py
│   │   ├── acesso.py
│   │   ├── ativo_minerario.py
│   │   ├── documento.py
│   │   ├── favorito.py
│   │   ├── processo_minerario.py
│   │   └── usuario.py
│   │
│   ├── repositories/
│   │   ├── __init__.py
│   │   ├── ativo_minerario_repository.py
│   │   ├── processo_minerario_repository.py
│   │   └── usuario_repository.py
│   │
│   ├── scripts/
│   │   ├── seed.py
│   │   └── sincronizar_anm.py
│   │
│   ├── services/
│   │   │
│   │   ├── ativo_minerario/
│   │   │   ├── atualizar_ativo_service.py
│   │   │   ├── buscar_ativo_service.py
│   │   │   ├── criar_ativo_service.py
│   │   │   ├── deletar_ativo_service.py
│   │   │   └── listar_ativos_usuario_service.py
│   │   │
│   │   ├── auth/
│   │   │   └── login_service.py
│   │   │
│   │   ├── processo_minerario/
│   │   │   ├── buscar_detalhes_processo_service.py
│   │   │   ├── deletar_processo_service.py
│   │   │   ├── importar_processos_anm_service.py
│   │   │   ├── listar_fases_service.py
│   │   │   ├── listar_processos_service.py
│   │   │   ├── listar_substancias_service.py
│   │   │   └── pesquisar_processos_service.py
│   │   │
│   │   ├── sincronizacao/
│   │   │   ├── buscar_dados_anm_service.py
│   │   │   └── sincronizar_base_anm.py
│   │   │
│   │   └── usuario/
│   │       ├── alterar_senha_service.py
│   │       ├── atualizar_usuario_service.py
│   │       ├── buscar_usuario_service.py
│   │       ├── criar_usuario_service.py
│   │       ├── deletar_usuario_service.py
│   │       └── listar_usuarios_service.py
│   │
│   ├── __init__.py
│   ├── app.py
│   ├── config.py
│   ├── requirements.txt
│   ├── scheduler.py
│   └── .env
│
├── frontend/
│   │
│   ├── android/
│   ├── assets/
│   ├── build/
│   ├── ios/
│   ├── linux/
│   ├── macos/
│   ├── web/
│   ├── windows/
│   │
│   ├── lib/
│   │   │
│   │   ├── data/
│   │   │
│   │   ├── models/
│   │   │   ├── ativo_minerario.dart
│   │   │   ├── filtro_processo.dart
│   │   │   ├── processo_minerario.dart
│   │   │   └── usuario.dart
│   │   │
│   │   ├── pages/
│   │   │   │
│   │   │   ├── auth/
│   │   │   │   ├── cadastro_page.dart
│   │   │   │   └── login_page.dart
│   │   │   │
│   │   │   ├── home/
│   │   │   │   └── home_page.dart
│   │   │   │
│   │   │   ├── processo/
│   │   │   │   ├── detalhe_processo_page.dart
│   │   │   │   ├── editar_ativo_page.dart
│   │   │   │   └── pesquisar_processo_ativo_page.dart
│   │   │   │
│   │   │   ├── usuario/
│   │   │   │   ├── editar_perfil_page.dart
│   │   │   │   └── perfil_page.dart
│   │   │   │
│   │   │   └── welcome/
│   │   │       └── welcome_page.dart
│   │   │
│   │   ├── services/
│   │   │   ├── api_service.dart
│   │   │   ├── ativo_service.dart
│   │   │   ├── auth_service.dart
│   │   │   ├── processo_service.dart
│   │   │   └── usuario_service.dart
│   │   │
│   │   ├── storage/
│   │   │   └── auth_storage.dart
│   │   │
│   │   ├── widgets/
│   │   │   │
│   │   │   ├── bottom_sheets/
│   │   │   │   ├── filtro_bottom_sheet.dart
│   │   │   │   └── selecionar_substancia_bottom_sheet.dart
│   │   │   │
│   │   │   ├── buttons/
│   │   │   │   ├── action_button.dart
│   │   │   │   ├── button_speed_child.dart
│   │   │   │   ├── buttons_detalhe_processo.dart
│   │   │   │   └── buttons.dart
│   │   │   │
│   │   │   ├── cards/
│   │   │   │   └── card_processo_minerario.dart
│   │   │   │
│   │   │   ├── onboarding/
│   │   │   │
│   │   │   └── textfields/
│   │   │       ├── campo_input.dart
│   │   │       ├── pesquisar_input.dart
│   │   │       └── tipo_conta.dart
│   │   │
│   │   └── main.dart
│   │
│   ├── pubspec.yaml
│   └── analysis_options.yaml
│
├── README.md
└── .gitignore
```

---

# Responsabilidade das Principais Pastas

## Backend

### `controllers/`

Camada responsável por receber as requisições HTTP, extrair parâmetros, acionar os services e devolver respostas em JSON.

Principais responsabilidades:

- leitura de parâmetros da URL;
- validação inicial das requisições;
- definição dos códigos HTTP;
- serialização das respostas;
- encaminhamento para a regra de negócio.

---

### `database/`

Contém os scripts SQL utilizados para criação e configuração do banco.

Arquivos principais:

- `create_database.sql`: criação inicial do banco;
- `procedures.sql`: Stored Procedures utilizadas em listagem, pesquisa, contagem e filtros.

As procedures são utilizadas principalmente nas consultas de grande volume, como paginação de processos minerários e pesquisa textual.

---

### `models/`

Representam as entidades do domínio no banco de dados por meio do SQLAlchemy.

Entidades existentes:

- usuário;
- processo minerário;
- ativo minerário;
- acesso;
- documento;
- favorito.

Esses modelos definem campos, relacionamentos, chaves estrangeiras e métodos de serialização.

---

### `repositories/`

Camada responsável pelo acesso aos dados.

Os repositories executam:

- consultas SQLAlchemy;
- Stored Procedures;
- filtros;
- paginação;
- buscas específicas;
- operações de persistência.

Essa separação evita que regras de acesso ao banco fiquem espalhadas entre controllers e services.

---

### `scripts/`

Contém scripts auxiliares para manutenção e desenvolvimento.

Principais usos:

- popular o banco com dados iniciais;
- importar dados da ANM;
- executar sincronizações manualmente.

---

### `services/`

Camada que concentra as regras de negócio da aplicação.

Os services estão separados por domínio:

#### `ativo_minerario/`

Responsável pelo gerenciamento dos ativos associados aos usuários.

Inclui:

- criação;
- consulta;
- edição;
- exclusão;
- listagem dos ativos por usuário;
- validação de propriedade;
- prevenção de duplicidade.

#### `auth/`

Responsável pelo processo de autenticação.

Inclui:

- login;
- validação de credenciais;
- retorno dos dados da sessão.

#### `processo_minerario/`

Responsável pelas operações relacionadas aos processos da ANM.

Inclui:

- listagem paginada;
- pesquisa textual;
- consulta de detalhes;
- listagem de fases;
- listagem de substâncias;
- filtros combinados;
- importação de processos;
- exclusão de registros.

#### `sincronizacao/`

Responsável pela obtenção e atualização da base oficial da ANM.

Inclui:

- busca dos dados;
- leitura da base;
- inserção de novos processos;
- atualização de processos existentes.

#### `usuario/`

Responsável pelas operações de gerenciamento de usuários.

Inclui:

- cadastro;
- consulta;
- atualização;
- alteração de senha;
- exclusão;
- listagem.

---

### `app.py`

Arquivo principal da aplicação Flask.

Responsável por:

- criar a aplicação;
- carregar configurações;
- registrar blueprints;
- inicializar extensões;
- configurar CORS;
- iniciar a API.

---

### `config.py`

Centraliza as configurações da aplicação, como conexão com o banco de dados e variáveis de ambiente.

---

### `scheduler.py`

Responsável pelo agendamento de tarefas automáticas, especialmente a sincronização periódica da base da ANM.

---

## Frontend

### `models/`

Contém as classes Dart que representam os dados recebidos da API.

Modelos principais:

- `Usuario`;
- `ProcessoMinerario`;
- `AtivoMinerario`;
- `FiltroProcesso`.

O modelo `FiltroProcesso` agrupa os filtros de fase e substância, facilitando futuras expansões.

---

### `pages/`

Contém as telas da aplicação, separadas por domínio.

#### `auth/`

- tela de login;
- tela de cadastro.

#### `home/`

- listagem dos processos;
- busca;
- filtros;
- paginação infinita;
- acesso rápido às principais funcionalidades.

#### `processo/`

- detalhes do processo;
- edição de ativo;
- busca de processo para cadastro como ativo.

#### `usuario/`

- perfil;
- edição do perfil.

#### `welcome/`

- apresentação inicial da aplicação.

---

### `services/`

Camada responsável pelas requisições HTTP ao backend.

Principais serviços:

- `ApiService`: configuração geral da API;
- `AuthService`: autenticação;
- `UsuarioService`: operações de usuário;
- `ProcessoService`: consulta, pesquisa, filtros e detalhes;
- `AtivoService`: gerenciamento dos ativos.

---

### `storage/`

Responsável pela persistência local de informações de autenticação e sessão do usuário.

---

### `widgets/`

Contém componentes reutilizáveis da interface.

#### `bottom_sheets/`

Componentes de seleção e filtragem:

- filtro por fase;
- filtro por substância;
- seleção pesquisável de substâncias.

#### `buttons/`

Botões reutilizáveis utilizados em diferentes telas.

#### `cards/`

Cards para exibição de processos minerários.

#### `textfields/`

Campos reutilizáveis de entrada, pesquisa e formulários.

#### `onboarding/`

Componentes utilizados nas telas iniciais da aplicação.

---

# Fluxo Entre as Camadas

```text
Usuário
   │
   ▼
Página Flutter
   │
   ▼
Service Dart
   │
   ▼
Requisição HTTP
   │
   ▼
Controller Flask
   │
   ▼
Service Python
   │
   ▼
Repository
   │
   ▼
SQLAlchemy / Stored Procedure
   │
   ▼
MySQL
```

O retorno percorre o caminho inverso até ser transformado em objetos Dart e exibido na interface.

---


# Endpoints Principais

## Usuários

```
POST   /usuarios

GET    /usuarios/{id}

GET    /usuarios/me

PUT    /usuarios/{id}

PUT    /usuarios/me

PUT    /usuarios/me/senha

DELETE /usuarios/{id}
```

---

## Autenticação

```
POST /login
```

---

## Processos Minerários

```
GET /processos

GET /processos/pesquisar

GET /processos/fases

GET /processos/substancias

GET /processos/{id}/detalhes
```

---

## Ativos Minerários

```
POST   /ativos

GET    /ativos/meus

PUT    /ativos/{id}

DELETE /ativos/{id}
```

---

# Fonte dos Dados

O Argon utiliza dados públicos disponibilizados pela **Agência Nacional de Mineração (ANM)**.

A sincronização foi projetada para importar periodicamente os arquivos oficiais disponibilizados pela agência, mantendo a base de processos minerários sempre atualizada.

---

# Funcionalidades Implementadas

1. **Cadastro e autenticação de usuários**
   - Cadastro de novos usuários.
   - Login utilizando credenciais válidas.

2. **Consulta de processos minerários**
   - Pesquisa de processos minerários utilizando dados oficiais da Agência Nacional de Mineração (ANM).

3. **Visualização de detalhes dos processos**
   - Exibição de informações completas de um processo minerário selecionado.

4. **Pesquisa e filtros**
   - Pesquisa por número do processo ou palavras-chave.
   - Filtros por fase e substância mineral.

5. **Validação de processos minerários**
   - Confirmação da validação de um processo antes do cadastro como ativo.

6. **Gerenciamento de ativos minerários**
   - Cadastro de ativos minerários vinculados a processos validados.

7. **Consulta de ativos minerários**
   - Pesquisa de ativos cadastrados por número do processo ou palavras-chave.

8. **Edição de ativos minerários**
   - Atualização das informações dos ativos cadastrados.

9. **Gerenciamento de perfil**
   - Atualização das informações do perfil do usuário.

10. **Controle de acesso**
    - Restrição da edição de ativos minerários e perfis apenas aos seus respectivos proprietários.

---

# Como Executar

## Clonar o projeto

```bash
git clone https://github.com/Ninassc/Argon.git

cd Argon
```

---

## Backend

```bash
cd backend

pip install -r requirements.txt

python app.py
```

Caso deseje sincronizar a base da ANM manualmente:

```bash
python scripts/sincronizar_anm.py
```

---

## Frontend

```bash
cd frontend

flutter pub get

flutter run -d chrome
```

---

# Status do Projeto

O projeto encontra-se funcional e em constante evolução.

Atualmente contempla autenticação de usuários, gerenciamento de ativos minerários, consulta de processos da ANM, sincronização da base de dados e interface web desenvolvida em Flutter integrada a uma API REST em Flask.