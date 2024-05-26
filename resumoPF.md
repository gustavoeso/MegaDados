# Formas Normais (Normal Forms) em Bancos de Dados

A normalização de bancos de dados é um processo de organização das tabelas e colunas de um banco de dados relacional para minimizar a redundância e dependência. O objetivo da normalização é dividir as grandes tabelas em tabelas menores e ligá-las usando relacionamentos. As Formas Normais (Normal Forms) são usadas para avaliar e melhorar a qualidade do design do banco de dados. Aqui estão as formas normais mais comuns:

## Primeira Forma Normal (1NF)
### Definição:
Uma tabela está na Primeira Forma Normal (1NF) se:
- Todos os atributos contêm apenas valores atômicos (não divisíveis).
- Não há repetição de grupos de atributos.

### Como Verificar:
1. **Valores Atômicos**: Certifique-se de que cada coluna da tabela contém valores únicos e indivisíveis. Por exemplo, uma coluna "endereço" deve ser dividida em "rua", "cidade", "estado" etc.
2. **Ausência de Grupos Repetidos**: Verifique se a tabela não contém grupos de colunas repetidas. Cada coluna deve representar um único atributo do objeto que a tabela está modelando.

### Exemplo:
Uma tabela de clientes com uma única coluna para telefones que contém vários números de telefone violaria a 1NF. Para estar na 1NF, você deve criar uma tabela separada para números de telefone.

```sql
-- Tabela violando a 1NF
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    telefones VARCHAR(255)  -- Pode conter vários números
);

-- Tabela normalizada na 1NF
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE telefones (
    id_cliente INT,
    telefone VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);
```

## Segunda Forma Normal (2NF)
### Definição:
Uma tabela está na Segunda Forma Normal (2NF) se:
- Está na 1NF.
- Todos os atributos não chave são totalmente dependentes de toda a chave primária (não apenas uma parte dela).

### Como Verificar:
1. **1NF**: Verifique se a tabela está na 1NF.
2. **Dependência Total**: Se a chave primária for composta (mais de um atributo), cada atributo não chave deve depender da chave inteira, não apenas de uma parte dela.

### Exemplo:
Uma tabela de pedidos com `id_pedido` e `id_produto` como chave primária composta deve garantir que todos os atributos não chave dependem de ambos `id_pedido` e `id_produto`.

```sql
-- Tabela violando a 2NF
CREATE TABLE pedidos_produtos (
    id_pedido INT,
    id_produto INT,
    nome_produto VARCHAR(100),  -- Depende apenas de id_produto
    quantidade INT,
    PRIMARY KEY (id_pedido, id_produto)
);

-- Tabela normalizada na 2NF
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    data_pedido DATE
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(100)
);

CREATE TABLE pedidos_produtos (
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
```

## Terceira Forma Normal (3NF)
### Definição:
Uma tabela está na Terceira Forma Normal (3NF) se:
- Está na 2NF.
- Nenhum atributo não chave é transitivamente dependente da chave primária.

### Como Verificar:
1. **2NF**: Verifique se a tabela está na 2NF.
2. **Dependência Transitiva**: Certifique-se de que nenhum atributo não chave depende de outro atributo não chave. Todos os atributos não chave devem depender apenas da chave primária.

### Exemplo:
Uma tabela de funcionários onde `id_departamento` determina `nome_departamento` deve ser normalizada para remover a dependência transitiva.

```sql
-- Tabela violando a 3NF
CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome_funcionario VARCHAR(100),
    id_departamento INT,
    nome_departamento VARCHAR(100)  -- Depende de id_departamento, não da chave primária
);

-- Tabela normalizada na 3NF
CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY,
    nome_departamento VARCHAR(100)
);

CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome_funcionario VARCHAR(100),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);
```

## Conclusão
As Formas Normais (1NF, 2NF e 3NF) são etapas críticas na normalização de bancos de dados. Cada forma normal ajuda a garantir que o banco de dados seja eficiente, eliminando redundâncias e melhorando a integridade dos dados. A normalização pode inicialmente parecer complexa, mas é essencial para manter um design de banco de dados robusto e escalável.