# Normal Forms (Formas Normais) em Bancos de Dados

Quando se fala em NF no contexto de bancos de dados, estamos nos referindo às "Formas Normais" (Normal Forms) que são usadas para avaliar e melhorar a qualidade do design de um banco de dados relacional. Existem várias formas normais, mas as mais comuns são a Primeira Forma Normal (1NF), a Segunda Forma Normal (2NF) e a Terceira Forma Normal (3NF). Vamos analisar se a tabela de gastos para departamentos de filiais de uma empresa está em cada uma dessas formas normais.

## Primeira Forma Normal (1NF)
Uma tabela está na Primeira Forma Normal (1NF) se:
- Todos os atributos contêm apenas valores atômicos (não divisíveis).
- Não há repetição de grupos de atributos.

**Análise:**
- A tabela fornecida não possui valores repetidos ou não atômicos. Cada célula contém um valor único e indivisível.
- Não há repetição de grupos de atributos.

Portanto, a tabela está na **Primeira Forma Normal (1NF)**.

## Segunda Forma Normal (2NF)
Uma tabela está na Segunda Forma Normal (2NF) se:
- Está na 1NF.
- Todos os atributos não chave são totalmente dependentes de toda a chave primária (não apenas uma parte dela).

Para uma tabela estar na 2NF, ela deve estar na 1NF e, se a chave primária for composta (mais de um atributo), cada atributo não chave deve depender da chave inteira.

**Análise:**
- A chave primária da tabela é composta por `id_filial` e `id_departamento`.
- `descricao` e `valor` são dependentes de ambos os atributos da chave primária (`id_filial` e `id_departamento`).
- `id_cidade` e `cidade` são dependentes apenas de `id_filial`, não de `id_departamento`.

Portanto, a tabela **não está na Segunda Forma Normal (2NF)**, pois `id_cidade` e `cidade` são dependentes parcialmente de `id_filial`.

## Terceira Forma Normal (3NF)
Uma tabela está na Terceira Forma Normal (3NF) se:
- Está na 2NF.
- Nenhum atributo não chave é transitivamente dependente da chave primária.

**Análise:**
- Como a tabela não está na 2NF, ela também não pode estar na 3NF.

## Resumo
- **1NF**: Sim, a tabela está na 1NF, pois todos os atributos são atômicos e não há repetição de grupos de atributos.
- **2NF**: Não, a tabela não está na 2NF, pois `id_cidade` e `cidade` são dependentes apenas de `id_filial` e não de toda a chave primária.
- **3NF**: Não, a tabela não está na 3NF, pois ela não atende aos requisitos da 2NF.

## Justificativa
Para normalizar a tabela e movê-la para a 2NF e 3NF, poderíamos separar as dependências parciais e transitivas. Por exemplo:

- Criar uma tabela separada para cidades:
  ```sql
  CREATE TABLE cidade (
      id_cidade INT PRIMARY KEY,
      cidade VARCHAR(255)
  );
  ```

- E modificar a tabela original para:
  ```sql
  CREATE TABLE gastos (
      id_filial INT,
      id_departamento INT,
      descricao VARCHAR(255),
      valor DECIMAL(10, 2),
      id_cidade INT,
      PRIMARY KEY (id_filial, id_departamento),
      FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
  );
  ```

Com essa separação, podemos garantir que todas as dependências sejam totais e não transitivas, movendo a tabela para a 2NF e 3NF.

Este markdown explica os conceitos de 1NF, 2NF e 3NF, aplica esses conceitos à tabela fornecida e justifica a necessidade de normalização para alcançar 2NF e 3NF.