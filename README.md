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
- Autenticação por JWT
- Consulta de perfil
- Atualização de perfil
- Alteração de senha
- Exclusão de conta

---

## Processos Minerários

- Consulta paginada
- Pesquisa por texto e número do processo
- Visualização detalhada
- Paginação infinita (Infinite Scroll)
- Filtro por fase
- Filtro por substância mineral
- Consulta utilizando dados oficiais da ANM
- Validação de processos antes do cadastro como ativo
- Análise de processos com Inteligência Artificial

---

## Processos Salvos

- Salvamento de processos para acesso posterior
- Listagem dos processos salvos pelo usuário
- Verificação de processos já salvos
- Remoção de processos salvos

---

## Compartilhamento de Processos

- Compartilhamento de processos entre usuários
- Compartilhamento por meio do e-mail do destinatário
- Visualização de processos recebidos
- Visualização de processos enviados
- Identificação dos usuários de origem e destino

---

## Ativos Minerários

- Cadastro de ativos
- Edição de ativos
- Exclusão de ativos
- Associação entre usuário e processo minerário
- Validação para impedir ativos duplicados
- Restrição de edição apenas ao proprietário
- Consulta dos ativos pertencentes ao usuário
- Pesquisa de ativos minerários

---

## Controle de Acesso

- Solicitação de acesso a ativos minerários (em desenvolvimento)
- Controle de permissões para acesso a informações privadas (em desenvolvimento)

---

## Inteligência Artificial

- Integração com a API do Google Gemini
- Análise de dados de processos minerários
- Geração de análise estruturada do processo
- Exibição da análise na página de detalhes

---

## Sincronização

- Importação da base oficial da ANM
- Atualização de processos existentes
- Inserção de novos processos
- Tentativa de consulta pela API oficial da ANM
- Utilização do Shapefile como fonte alternativa
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
- Processos Salvos
- Detalhes do Processo
- Pesquisa de Ativos
- Processos Compartilhados
- Compartilhamentos Recebidos
- Compartilhamentos Enviados

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

A estrutura do Argon foi organizada separando frontend, backend, regras de negócio, persistência, autenticação, sincronização de dados, Inteligência Artificial, compartilhamento e componentes reutilizáveis.

```text
Argon/
│
├── backend/
│   │
│   ├── controllers/
│   │   ├── __init__.py
│   │   ├── acesso_controller.py
│   │   ├── ativo_minerario_controller.py
│   │   ├── auth_controller.py
│   │   ├── compartilhamento_processo_controller.py
│   │   ├── favorito_controller.py
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
│   │   ├── compartilhamento_processo.py
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
│   │   ├── sincronizar_anm.py
│   │   └── teste.py
│   │
│   ├── services/
│   │   │
│   │   ├── acesso/
│   │   │   └── solicitar_acesso_service.py
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
│   │   ├── compartilhamento_processo/
│   │   │   ├── compartilhar_processo_service.py
│   │   │   ├── listar_processos_enviados_service.py
│   │   │   └── listar_processos_recebidos_service.py
│   │   │
│   │   ├── favorito/
│   │   │   ├── criar_favorito_service.py
│   │   │   ├── deletar_favorito_service.py
│   │   │   ├── listar_favoritos_service.py
│   │   │   └── verificar_favorito_service.py
│   │   │
│   │   ├── ia/
│   │   │   └── analisar_processo_ia_service.py
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
│   ├── .env.example
│   ├── app.py
│   ├── config.py
│   ├── requirements.txt
│   └── scheduler.py
│
├── frontend/
│   │
│   ├── android/
│   ├── assets/
│   │   └── images/
│   │       ├── ArgON.png
│   │       ├── onboarding1.png
│   │       ├── onboarding2.png
│   │       └── onboarding3.png
│   │
│   ├── ios/
│   ├── linux/
│   ├── macos/
│   ├── web/
│   ├── windows/
│   │
│   ├── lib/
│   │   │
│   │   ├── data/
│   │   │   └── processos_test.dart
│   │   │
│   │   ├── models/
│   │   │   ├── ativo_minerario.dart
│   │   │   ├── compartilhamento_processo.dart
│   │   │   ├── favorito.dart
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
│   │   │   ├── compartilhamentos/
│   │   │   │   ├── compartilhamentos_enviados_tab.dart
│   │   │   │   ├── compartilhamentos_recebidos_tab.dart
│   │   │   │   └── processos_compartilhados_page.dart
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
│   │   │   │   ├── perfil_page.dart
│   │   │   │   └── processos_salvos_page.dart
│   │   │   │
│   │   │   └── welcome/
│   │   │       └── welcome_page.dart
│   │   │
│   │   ├── services/
│   │   │   ├── api_service.dart
│   │   │   ├── ativo_service.dart
│   │   │   ├── auth_service.dart
│   │   │   ├── compartilhamento_processo_service.dart
│   │   │   ├── favorito_service.dart
│   │   │   ├── processo_service.dart
│   │   │   └── usuario_service.dart
│   │   │
│   │   ├── storage/
│   │   │   └── auth_storage.dart
│   │   │
│   │   ├── widgets/
│   │   │   │
│   │   │   ├── bottom_sheets/
│   │   │   │   ├── compartilhar_processo_bottom_sheet.dart
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
├── .gitignore
└── README.md
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
- favorito;
- compartilhamento de processo;
- acesso;
- documento.

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

#### `acesso/`

Responsável pelo controle de acesso aos ativos minerários.

Inclui:

- solicitação de acesso a ativos;
- validação do usuário solicitante;
- prevenção de solicitações duplicadas;
- gerenciamento das permissões de acesso.

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
- gerenciamento da autenticação por JWT.

#### `compartilhamento_processo/`

Responsável pelo compartilhamento de processos minerários entre usuários.

Inclui:

- compartilhamento de processos;
- listagem de processos recebidos;
- listagem de processos enviados;
- identificação dos usuários envolvidos no compartilhamento.

#### `favorito/`

Responsável pelo gerenciamento dos processos salvos pelos usuários.

Inclui:

- salvamento de processos;
- remoção de processos salvos;
- listagem dos favoritos;
- verificação do status de favorito.

#### `ia/`

Responsável pela integração dos processos minerários com recursos de Inteligência Artificial.

Inclui:

- análise de processos minerários;
- geração de informações estruturadas a partir dos dados do processo;
- integração com a API do Google Gemini.

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

- tentativa de consulta à API da ANM;
- utilização do Shapefile como fonte alternativa;
- leitura e tratamento dos dados;
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
- `Favorito`;
- `CompartilhamentoProcesso`;
- `FiltroProcesso`.

O modelo `FiltroProcesso` agrupa os filtros utilizados na consulta dos processos minerários.

---

### `pages/`

Contém as telas da aplicação, separadas por domínio.

#### `auth/`

- tela de login;
- tela de cadastro.

#### `compartilhamentos/`

- tela de processos compartilhados;
- aba de processos recebidos;
- aba de processos enviados.

#### `home/`

- listagem dos processos;
- busca;
- filtros;
- paginação infinita;
- acesso rápido às principais funcionalidades.

#### `processo/`

- detalhes do processo;
- análise do processo com Inteligência Artificial;
- edição de ativo;
- busca de processo para cadastro como ativo;
- compartilhamento de processos.

#### `usuario/`

- perfil;
- edição do perfil;
- processos salvos.

#### `welcome/`

- apresentação inicial da aplicação.
  
---

### `services/`

Camada responsável pelas requisições HTTP ao backend.

Principais serviços:

- `ApiService`: configuração geral da API e cabeçalhos de autenticação;
- `AuthService`: autenticação;
- `UsuarioService`: operações de usuário;
- `ProcessoService`: consulta, pesquisa, filtros, detalhes e análise com IA;
- `AtivoService`: gerenciamento dos ativos;
- `FavoritoService`: gerenciamento dos processos salvos;
- `CompartilhamentoProcessoService`: envio e consulta de processos compartilhados.

---

### `storage/`

Responsável pela persistência local de informações de autenticação e sessão do usuário.

---

### `widgets/`

Contém componentes reutilizáveis da interface.

#### `bottom_sheets/`

Componentes utilizados em ações contextuais, seleção e filtragem:

- compartilhamento de processos;
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

## Favoritos

```text
POST   /favoritos/{id_processo}

GET    /favoritos/

GET    /favoritos/{id_processo}

DELETE /favoritos/{id_processo}
```

---
## Compartilhamento Processo

```text
POST /compartilhamentos/{id_processo}

GET  /compartilhamentos/recebidos

GET  /compartilhamentos/enviados
```

---
## IA

```text
POST /processos/{id_processo}/analisar-ia
```

# Fonte dos Dados

O Argon utiliza dados públicos disponibilizados pela **Agência Nacional de Mineração (ANM)**.

A sincronização foi projetada para importar periodicamente os arquivos oficiais disponibilizados pela agência, mantendo a base de processos minerários sempre atualizada.

---

# Funcionalidades Implementadas

1. **Cadastro e autenticação de usuários**
   - Cadastro de novos usuários.
   - Login utilizando credenciais válidas.
   - Autenticação por JWT.

2. **Consulta de processos minerários**
   - Consulta de processos utilizando dados oficiais da Agência Nacional de Mineração (ANM).
   - Sincronização da base oficial da ANM.
   - Utilização de Shapefile como alternativa em caso de indisponibilidade da API da ANM.

3. **Visualização de detalhes dos processos**
   - Exibição das informações detalhadas de um processo minerário.
   - Consulta dos dados oficiais associados ao processo.

4. **Pesquisa e filtros**
   - Pesquisa por número do processo ou palavras-chave.
   - Filtro por fase do processo.
   - Filtro por substância mineral.
   - Paginação dos resultados e carregamento por Infinite Scroll.

5. **Validação de processos minerários**
   - Verificação do processo com base nos dados oficiais da ANM.
   - Confirmação da validação antes do cadastro como ativo minerário.

6. **Gerenciamento de ativos minerários**
   - Cadastro de ativos minerários a partir de processos validados.
   - Associação do ativo ao usuário proprietário.
   - Prevenção de cadastro duplicado.
   - Exclusão de ativos minerários.

7. **Consulta de ativos minerários**
   - Pesquisa de ativos cadastrados.
   - Consulta dos ativos pertencentes ao usuário.

8. **Edição de ativos minerários**
   - Atualização das informações dos ativos cadastrados.
   - Restrição da edição ao proprietário do ativo.

9. **Gerenciamento de perfil**
   - Visualização do perfil do usuário.
   - Atualização das informações do perfil.
   - Alteração de senha.
   - Exclusão da conta.
   - Restrição da edição do perfil ao próprio usuário.

10. **Processos salvos**
    - Salvamento de processos minerários como favoritos.
    - Listagem dos processos salvos pelo usuário.
    - Verificação se um processo já está salvo.
    - Remoção de processos dos favoritos.

11. **Compartilhamento de processos**
    - Compartilhamento de processos minerários entre usuários da plataforma.
    - Compartilhamento utilizando o e-mail do usuário destinatário.
    - Visualização dos processos recebidos.
    - Visualização dos processos enviados.
    - Identificação do usuário que enviou ou recebeu o processo.

12. **Análise de processos com Inteligência Artificial**
    - Geração de análise de processos minerários utilizando Inteligência Artificial.
    - Integração do backend com a API do Google Gemini.
    - Exibição da análise diretamente na página de detalhes do processo.

13. **Sincronização da base da ANM**
    - Importação dos processos minerários oficiais.
    - Atualização de processos existentes.
    - Inserção de novos processos.
    - Sincronização periódica através de Scheduler.
    - Fallback para Shapefile quando a API da ANM está indisponível.
      
---

# Como Executar

## 1. Clonar o projeto

```bash
git clone https://github.com/Ninassc/Argon.git

cd Argon
```

---

## 2. Configurar o Backend

Acesse a pasta do backend:

```bash
cd backend
```

### Criar o arquivo `.env`

Utilize o arquivo de exemplo como base:

**Windows (PowerShell):**

```powershell
Copy-Item .env.example .env
```

**Linux/macOS:**

```bash
cp .env.example .env
```

Abra o arquivo `.env` e preencha as variáveis necessárias:

```env
DATABASE_URL=mysql+pymysql://usuario:senha@localhost:3306/argon
GEMINI_API_KEY=sua_chave_do_gemini
JWT_SECRET_KEY=chave_secreta
```

> **Importante:** antes de iniciar o projeto, certifique-se de que o MySQL esteja em execução e que o banco de dados `argon` já tenha sido criado.

### Instalar as dependências

```bash
pip install -r requirements.txt
```

### Iniciar o backend

```bash
python app.py
```

---

## 3. Sincronizar a base da ANM (opcional)

Caso deseje atualizar os processos minerários manualmente:

```bash
python scripts/sincronizar_anm.py
```

> A sincronização utiliza a API da ANM e, caso ela esteja indisponível, utiliza automaticamente o arquivo Shapefile como alternativa.

---

## 4. Configurar o Frontend

Em outro terminal:

```bash
cd frontend
```

Instale as dependências:

```bash
flutter pub get
```

Execute a aplicação:

```bash
flutter run -d chrome
```

---

## Requisitos

Antes de executar o projeto, é necessário possuir:

- Python 3.11 ou superior;
- Flutter SDK instalado e configurado;
- MySQL Server em execução;
- Banco de dados `argon` criado;
- Chave da API do Google Gemini.

# Status do Projeto

O projeto encontra-se funcional e em constante evolução.

Atualmente contempla autenticação de usuários, gerenciamento de ativos minerários, consulta de processos da ANM, sincronização da base de dados e interface web desenvolvida em Flutter integrada a uma API REST em Flask.
