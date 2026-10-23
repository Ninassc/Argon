# Argon

# Plataforma de Organização e Compartilhamento Controlado de Direitos Minerários

O **Argon** é uma plataforma multiplataforma desenvolvida para organizar, consultar e compartilhar informações relacionadas a processos minerários utilizando dados públicos da **Agência Nacional de Mineração (ANM)**.

O sistema integra uma API REST desenvolvida em **Flask** com uma interface em **Flutter (Web e Android)**, permitindo que usuários consultem processos minerários, organizem seus ativos, acompanhem informações detalhadas e gerenciem seus direitos minerários de forma estruturada e segura.

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
- Supabase Storage (armazenamento privado de documentos)
- File Picker (seleção de arquivos)

---

# Visão Geral

O Argon foi desenvolvido para facilitar o gerenciamento de direitos minerários por meio de uma plataforma web integrada à base pública da Agência Nacional de Mineração (ANM).

Além da consulta aos processos minerários, o sistema permite que cada usuário organize seus próprios ativos minerários, registre descrições personalizadas, visualize detalhes completos dos processos e acompanhe informações atualizadas provenientes da ANM.

A arquitetura foi construída seguindo a separação em camadas, promovendo organização, reutilização de código e facilidade de manutenção.

---

# Funcionalidades

As funcionalidades estão organizadas abaixo por área do sistema. A relação formal dos **20 requisitos funcionais implementados (RF01 a RF20)**, com suas descrições individuais, está na seção **Requisitos Funcionais**. Esta divisão por áreas não representa uma segunda lista de requisitos.

## Usuários

**Requisitos relacionados:** RF01, RF04, RF11 e RF12.

- Cadastro de usuários
- Login
- Autenticação por JWT
- Consulta de perfil
- Atualização de perfil
- Alteração de senha
- Exclusão de conta

---

## Processos Minerários

**Requisitos relacionados:** RF02, RF03, RF05, RF07, RF14 e RF16.

- Exportação dos dados de processos para planilha
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

**Requisito relacionado:** RF06.

- Salvamento de processos para acesso posterior
- Listagem dos processos salvos pelo usuário
- Verificação de processos já salvos
- Remoção de processos salvos

---

## Compartilhamento de Processos

**Requisito relacionado:** RF10 (compartilhamento de ativos), além do compartilhamento de processos entre usuários.

- Compartilhamento de processos entre usuários
- Compartilhamento por meio do e-mail do destinatário
- Visualização de processos recebidos
- Visualização de processos enviados
- Identificação dos usuários de origem e destino

---

## Ativos Minerários

**Requisitos relacionados:** RF08, RF09, RF10, RF11, RF13 e RF15.

- Compartilhamento de ativos com outros usuários
- Filtros de visualização de ativos minerários
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

**Requisitos relacionados:** RF11 e RF17.

O sistema possui um mecanismo de controle de acesso às informações privadas associadas aos ativos minerários, como documentos e arquivos anexados pelo proprietário.

- Solicitação de acesso às informações privadas de um ativo
- Aprovação e recusa de solicitações pelo proprietário
- Verificação do status de acesso do usuário
- Listagem de solicitações pendentes recebidas
- Histórico de solicitações recebidas
- Listagem de solicitações enviadas
- Controle de permissão para visualização e download de documentos associados ao ativo

---

## Documentos e Arquivos de Ativos Minerários

**Requisitos relacionados:** RF17, RF18, RF19 e RF20.

Os documentos ficam associados a um ativo minerário e são armazenados em um bucket privado do **Supabase Storage**. O MySQL mantém os metadados de cada documento, como nome original, tipo, tamanho, data de cadastro e caminho interno no armazenamento. O caminho interno não é exposto na resposta pública de listagem.

- Anexação de documentos pelo proprietário do ativo;
- Aceitação de PDF, JPG, JPEG, PNG e DOCX;
- Limite configurado de 10 MB por arquivo;
- Listagem de documentos associados ao ativo;
- Download do arquivo original mediante autenticação e autorização;
- Acesso permitido ao proprietário e a usuários com solicitação de acesso aprovada;
- Separação entre os metadados no MySQL e os arquivos no Supabase Storage.

As operações de documentos integram o módulo de gerenciamento de arquivos do Argon. A implementação é apresentada como concluída conforme o escopo informado pela equipe; testes de compatibilidade e validação final permanecem atividades de qualidade.

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
- Favorito
- Compartilhamento de Processo
- Controle de Acesso
- IA
- Documentos e armazenamento de arquivos

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
│   │   ├── usuario_controller.py
│   │   └── documento_controller.py
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
│   │   │   ├── aprovar_acesso_service.py
│   │   │   ├── listar_enviadas_service.py
│   │   │   ├── listar_historico_recebido_service.py
│   │   │   ├── listar_solicitacoes_recebidas_service.py
│   │   │   ├── recusar_acesso_service.py
│   │   │   ├── solicitar_acesso_service.py
│   │   │   └── verificar_acesso_service.py
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
│   │   │   ├── acesso.dart
│   │   │   ├── ativo_minerario.dart
│   │   │   ├── compartilhamento_processo.dart
│   │   │   ├── favorito.dart
│   │   │   ├── filtro_processo.dart
│   │   │   ├── processo_minerario.dart
│   │   │   ├── usuario.dart
│   │   │   └── documento.dart
│   │   │
│   │   ├── pages/
│   │   │   │
│   │   │   ├── acesso/
│   │   │   │   ├── acesso_page.dart
│   │   │   │   ├── historico_solicitacoes_acesso_page.dart
│   │   │   │   ├── solicitacoes_acesso_enviadas_tab.dart
│   │   │   │   └── solicitacoes_acesso_tab.dart
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
│   │   │   ├── documento/
│   │   │   ├── baixar_documento_service.py
│   │   │   └── [serviços de cadastro e listagem de documentos]
│   │   │
│   │   ├── usuario/
│   │   │   │   ├── editar_perfil_page.dart
│   │   │   │   ├── perfil_page.dart
│   │   │   │   └── processos_salvos_page.dart
│   │   │   │
│   │   │   └── welcome/
│   │   │       └── welcome_page.dart
│   │   │
│   │   ├── services/
│   │   │   ├── acesso_service.dart
│   │   │   ├── api_service.dart
│   │   │   ├── ativo_service.dart
│   │   │   ├── auth_service.dart
│   │   │   ├── compartilhamento_processo_service.dart
│   │   │   ├── favorito_service.dart
│   │   │   ├── processo_service.dart
│   │   │   ├── usuario_service.dart
│   │   │   └── documento_service.dart
│   │   │
│   │   ├── viewmodels/
│   │   │   └── documento_viewmodel.dart
│   │   │
│   │   ├── storage/
│   │   │   └── auth_storage.dart
│   │   │
│   │   ├── widgets/
│   │   │   │
│   │   │   ├── bottom_sheets/
│   │   │   │
│   │   │   ├── buttons/
│   │   │   │
│   │   │   ├── cards/
│   │   │   │
│   │   │   ├── onboarding/
│   │   │   │
│   │   │   └── textfields/
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

Responsável pelo controle de acesso às informações privadas vinculadas aos ativos minerários, especialmente documentos e arquivos disponibilizados pelo proprietário.

Inclui:

- solicitação de acesso;
- aprovação e recusa pelo proprietário do ativo;
- verificação das permissões do usuário;
- listagem de solicitações pendentes;
- histórico de solicitações recebidas;
- listagem de solicitações enviadas;
- prevenção de solicitações duplicadas.

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

#### `documento/` e `storage_service.py`

O domínio de documentos valida a associação com o ativo, as permissões do usuário e as operações de listagem e download. O `StorageService` centraliza a comunicação com o bucket privado do Supabase, incluindo envio, exclusão no armazenamento e recuperação de bytes.

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

#### `acesso/`

- tela principal de gerenciamento de acessos;
- aba de solicitações pendentes recebidas;
- histórico de solicitações aprovadas e recusadas;
- aba de solicitações enviadas pelo usuário.

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
- `AcessoService`: solicitação, aprovação, recusa, verificação e consulta das solicitações de acesso;

---

### `viewmodels/`

Os ViewModels fazem a mediação entre páginas e serviços, mantêm estados de carregamento e notificam a interface quando os dados mudam. O `DocumentoViewModel` oferece operações de cadastro, listagem e obtenção dos bytes para download.

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

---
## Controle de Acesso

```text
POST /acessos/{id_ativo}/solicitar

GET  /acessos/recebidas

GET  /acessos/historico

GET  /acessos/enviadas

GET  /acessos/{id_ativo}/verificar

PUT  /acessos/{id_acesso}/aprovar

PUT  /acessos/{id_acesso}/recusar
```
---


## Documentos

```text
POST /ativos/{id_ativo}/documentos
GET  /ativos/{id_ativo}/documentos
GET  /documentos/{id_documento}/download
```

O envio exige autenticação e propriedade do ativo. A listagem e o download exigem que o usuário seja o proprietário ou tenha acesso aprovado. O download retorna o arquivo binário com o nome e o tipo MIME originais. A API não fornece diretamente uma URL pública para o bucket privado.

---

# Fonte dos Dados

O Argon utiliza dados públicos disponibilizados pela **Agência Nacional de Mineração (ANM)**.

A sincronização foi projetada para importar periodicamente os arquivos oficiais disponibilizados pela agência, mantendo a base de processos minerários sempre atualizada.

---

# Seção 3 – Requisitos Funcionais (RF01–RF20)

Esta seção apresenta os **20 requisitos funcionais do Argon**, considerados implementados no escopo do projeto. A validação operacional completa em todos os ambientes é uma etapa distinta da implementação.
| ID | Requisito | Situação documentada |
|---|---|---|
| RF01 | Cadastro e login | Implementado |
| RF02 | Verificação de processo pelo número | Implementado |
| RF03 | Detalhes de processo validado | Implementado |
| RF04 | Perfil de outro usuário | Implementado |
| RF05 | Exportação para planilha | Implementado |
| RF06 | Salvar processos | Implementado |
| RF07 | Confirmação de validação | Implementado |
| RF08 | Cadastro de ativo | Implementado |
| RF09 | Edição de ativo | Implementado |
| RF10 | Compartilhamento de ativo | Implementado |
| RF11 | Restrição de edição | Implementado |
| RF12 | Edição do próprio perfil | Implementado |
| RF13 | Busca de ativos | Implementado |
| RF14 | Filtros de busca | Implementado |
| RF15 | Filtros de visualização de ativos | Implementado |
| RF16 | Veracidade das informações | Implementado |
| RF17 | Solicitação de acesso à documentação | Implementado |
| RF18 | Anexação de arquivos | Implementado |
| RF19 | Download de arquivos | Implementado |
| RF20 | Gerenciamento de arquivos | Implementado |

## Descrição detalhada dos requisitos

### RF01 — Cadastro e login

Permitir cadastro e autenticação por credenciais válidas, com sessão protegida por JWT.

**Situação:** Implementado.

### RF02 — Verificação de processo pelo número

Consultar o número informado na base de processos obtida de fontes oficiais da ANM.

**Situação:** Implementado.

### RF03 — Detalhes de processo validado

Exibir os dados disponíveis do processo minerário consultado.

**Situação:** Implementado.

### RF04 — Perfil de outro usuário

Permitir visualizar o perfil público do autor/proprietário de um ativo.

**Situação:** Implementado.

### RF05 — Exportação para planilha

Exportar dados de processos minerários em formato de planilha.

**Situação:** Implementado.

### RF06 — Salvar processos

Adicionar processos à lista de favoritos e recuperá-los posteriormente.

**Situação:** Implementado.

### RF07 — Confirmação de validação

Solicitar confirmação do usuário antes de cadastrar como ativo um processo validado.

**Situação:** Implementado.

### RF08 — Cadastro de ativo

Vincular um processo validado ao usuário proprietário como ativo minerário.

**Situação:** Implementado.

### RF09 — Edição de ativo

Permitir alterar as informações editáveis de ativos cadastrados.

**Situação:** Implementado.

### RF10 — Compartilhamento de ativo

Permitir disponibilizar um ativo minerário a outros usuários, respeitando o modelo de acesso definido.

**Situação:** Implementado.

### RF11 — Restrição de edição

Impedir que usuários alterem ativos e perfis que não lhes pertencem.

**Situação:** Implementado.

### RF12 — Edição do próprio perfil

Permitir atualização dos dados de perfil do usuário autenticado.

**Situação:** Implementado.

### RF13 — Busca de ativos

Pesquisar ativos por palavras-chave ou número do processo.

**Situação:** Implementado.

### RF14 — Filtros de busca

Refinar resultados de pesquisa com filtros disponíveis, como fase e substância.

**Situação:** Implementado.

### RF15 — Filtros de visualização de ativos

Aplicar filtros específicos à apresentação dos ativos minerários.

**Situação:** Implementado.

### RF16 — Veracidade das informações

Conferir informações de processos com base nos dados oficiais disponibilizados pela ANM.

**Situação:** Implementado.

### RF17 — Solicitação de acesso à documentação

Permitir solicitar acesso a documentos privados, com aprovação ou recusa pelo proprietário.

**Situação:** Implementado.

### RF18 — Anexação de arquivos

Permitir ao proprietário anexar arquivos aos ativos, com validação de tipo e tamanho.

**Situação:** Implementado.

### RF19 — Download de arquivos

Permitir a usuários autorizados baixar documentos associados a ativos.

**Situação:** Implementado.

### RF20 — Gerenciamento de arquivos

Permitir organizar e administrar arquivos associados aos próprios ativos.

**Situação:** Implementado.

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
SUPABASE_URL=https://seu-projeto.supabase.co
SUPABASE_SECRET_KEY=sua_chave_privada
SUPABASE_BUCKET=argon-documentos
```

> **Segurança:** nunca envie o `.env` ao GitHub nem coloque a `SUPABASE_SECRET_KEY` no aplicativo Flutter. O bucket de documentos deve permanecer privado.

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

Para executar em um emulador Android iniciado:

```bash
flutter run -d emulator-5554
```

---

## Requisitos

Antes de executar o projeto, é necessário possuir:

- Python 3.11 ou superior;
- Flutter SDK instalado e configurado;
- MySQL Server em execução;
- Banco de dados `argon` criado;
- Chave da API do Google Gemini;
- Projeto Supabase com bucket privado `argon-documentos` e credenciais configuradas no backend.

# Status do Projeto

O projeto encontra-se funcional e em constante evolução.

Atualmente contempla autenticação de usuários, gerenciamento de ativos minerários, consulta de processos da ANM, sincronização da base de dados, controle de acesso e gerenciamento de documentos privados. A interface Flutter é integrada à API REST Flask e ao armazenamento de arquivos no Supabase. Os 20 requisitos funcionais previstos estão documentados como implementados na seção RF01–RF20; testes e melhorias contínuas permanecem parte da evolução do sistema.
