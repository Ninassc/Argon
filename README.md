# Argon

## Plataforma de Organização e Compartilhamento de Direitos Minerários

### Repositório

https://github.com/Ninassc/Argon

### Integrantes da Equipe

* Nina Sepúlveda Soares Carvalho
* Victor Emanuel Pancote
* Antônio Franco Silva
* André Yuri Moreira
* Rafael Muniz de Holanda
* Thomas Andrew Schafer de Souza

---

## Tecnologias Utilizadas

### Frontend

* Flutter Web
* Dart

### Backend

* Python
* Flask

### Banco de Dados

* MySQL

---

## Sobre o Projeto

O Argon é uma plataforma web desenvolvida para organizar, validar e compartilhar informações relacionadas a processos minerários ativos em Minas Gerais.

O sistema utiliza dados oficiais da Agência Nacional de Mineração (ANM) para verificar processos minerários e permitir que seus titulares organizem informações complementares em um ambiente estruturado e seguro.

A plataforma possibilita o cadastro de ativos minerários, gerenciamento de documentos, controle de acesso às informações, sistema de favoritos e acompanhamento de interações, oferecendo maior organização e confiabilidade no compartilhamento de dados.

---

## Principais Funcionalidades

* Cadastro e autenticação de usuários
* Verificação de processos minerários
* Cadastro de ativos minerários
* Busca e filtragem de ativos
* Sistema de favoritos
* Upload e gerenciamento de documentos
* Solicitação de acesso a documentos
* Compartilhamento controlado de informações
* Registro de acessos e interações
* Visualização de perfis de usuários
* Exportação de dados para planilhas

---

## Estrutura do Projeto

```text
argon/
├── frontend/
│   └── Flutter
│
├── backend/
│   ├── controllers/
│   ├── models/
│   ├── routes/
│   ├── services/
│   └── app.py
│
├── database/
│   └── MySQL
│
└── docs/
```

---

## Como Executar o Projeto

### Pré-requisitos

* Flutter SDK
* Python 3.11 ou superior
* MySQL Server
* Git

---

### Clonar o Repositório

```bash
git clone https://github.com/Ninassc/Argon.git
cd Argon
```

---

### Executar o Backend

Instalar dependências:

```bash
pip install -r requirements.txt
```

Configurar a conexão com o banco de dados MySQL.

Executar o servidor:

```bash
python app.py
```

---

### Executar o Frontend

Instalar dependências:

```bash
flutter pub get
```

Executar aplicação:

```bash
flutter run -d chrome
```

---

## Fonte dos Dados

O sistema utiliza informações públicas disponibilizadas pela Agência Nacional de Mineração (ANM) para validação e consulta de processos minerários.

---

## Objetivo

Centralizar informações sobre direitos minerários, reduzir retrabalho na organização de documentos e oferecer um ambiente estruturado para compartilhamento controlado de dados e arquivos relacionados a ativos minerários.

---

## Status do Projeto

Projeto acadêmico desenvolvido para a disciplina de Projeto de Software.
