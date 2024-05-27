Claro! Vou criar um conjunto de exercícios com enunciados e soluções detalhadas em Spark, utilizando diferentes tipos de RDDs.

### Exercício 1: Contagem de Palavras em um RDD de Strings

**Enunciado**:
Dado um RDD de linhas de texto, crie uma função `contar_palavras` que conta a ocorrência de cada palavra no RDD e retorna as palavras e suas contagens.

**Solução**:
```python
from pyspark import SparkContext

# Inicializar SparkContext
sc = SparkContext("local", "WordCount")

def contar_palavras(rdd):
    # Dividir cada linha em palavras
    palavras = rdd.flatMap(lambda linha: linha.split())
    
    # Mapear cada palavra para um par (palavra, 1)
    pares_palavras = palavras.map(lambda palavra: (palavra, 1))
    
    # Reduzir para contar as palavras
    contagem_palavras = pares_palavras.reduceByKey(lambda a, b: a + b)
    
    # Coletar o resultado e retornar como uma lista de pares (palavra, contagem)
    return contagem_palavras.collect()

# Exemplo de uso
linhas = [
    "Spark é ótimo para processamento de dados",
    "Spark pode processar grandes volumes de dados rapidamente",
    "RDD é uma estrutura de dados fundamental no Spark"
]

rdd = sc.parallelize(linhas)
print(contar_palavras(rdd))
```

**Comentários do Código**:
1. **flatMap**: Divide cada linha em palavras.
2. **map**: Converte cada palavra em um par (palavra, 1).
3. **reduceByKey**: Soma as contagens de cada palavra.
4. **collect**: Coleta o resultado final como uma lista de pares (palavra, contagem).

### Exercício 2: Filtrar e Somar Valores em um RDD de Números

**Enunciado**:
Dado um RDD de números inteiros, crie uma função `filtrar_e_somar` que filtra os números pares e retorna a soma desses números.

**Solução**:
```python
from pyspark import SparkContext

# Inicializar SparkContext
sc = SparkContext("local", "FilterAndSum")

def filtrar_e_somar(rdd):
    # Filtrar números pares
    pares = rdd.filter(lambda x: x % 2 == 0)
    
    # Somar os números pares
    soma = pares.reduce(lambda a, b: a + b)
    
    return soma

# Exemplo de uso
numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
rdd = sc.parallelize(numeros)
print(filtrar_e_somar(rdd))
```

**Comentários do Código**:
1. **filter**: Filtra os números pares.
2. **reduce**: Soma os números filtrados.

### Exercício 3: Média de Valores em um RDD de Tuplas

**Enunciado**:
Dado um RDD de tuplas onde cada tupla contém um identificador e um valor, crie uma função `media_valores` que calcula a média dos valores para cada identificador.

**Solução**:
```python
from pyspark import SparkContext

# Inicializar SparkContext
sc = SparkContext("local", "AverageValues")

def media_valores(rdd):
    # Mapear cada tupla para (id, (valor, 1))
    pares = rdd.map(lambda x: (x[0], (x[1], 1)))
    
    # Reduzir para somar os valores e contar as ocorrências
    soma_e_contagem = pares.reduceByKey(lambda a, b: (a[0] + b[0], a[1] + b[1]))
    
    # Calcular a média para cada identificador
    medias = soma_e_contagem.mapValues(lambda x: x[0] / x[1])
    
    # Coletar o resultado e retornar como uma lista de pares (id, média)
    return medias.collect()

# Exemplo de uso
dados = [
    ("A", 10), ("B", 20), ("A", 30), ("B", 40), ("A", 50), ("B", 60)
]

rdd = sc.parallelize(dados)
print(media_valores(rdd))
```

**Comentários do Código**:
1. **map**: Converte cada tupla em um par (id, (valor, 1)).
2. **reduceByKey**: Soma os valores e conta as ocorrências para cada id.
3. **mapValues**: Calcula a média dividindo a soma dos valores pelo número de ocorrências.
4. **collect**: Coleta o resultado final como uma lista de pares (id, média).

### Exercício 4: Encontrar o Máximo e o Mínimo em um RDD de Números

**Enunciado**:
Dado um RDD de números inteiros, crie uma função `encontrar_max_min` que retorna o valor máximo e mínimo do RDD.

**Solução**:
```python
from pyspark import SparkContext

# Inicializar SparkContext
sc = SparkContext("local", "MaxMin")

def encontrar_max_min(rdd):
    # Encontrar o valor máximo
    max_val = rdd.max()
    
    # Encontrar o valor mínimo
    min_val = rdd.min()
    
    return (max_val, min_val)

# Exemplo de uso
numeros = [3, 5, 7, 2, 8, 1, 4, 10, 6, 9]
rdd = sc.parallelize(numeros)
print(encontrar_max_min(rdd))
```

**Comentários do Código**:
1. **max**: Encontra o valor máximo no RDD.
2. **min**: Encontra o valor mínimo no RDD.

### Exercício 5: Agrupar Palavras por Tamanho em um RDD de Strings

**Enunciado**:
Dado um RDD de palavras, crie uma função `agrupar_por_tamanho` que agrupa as palavras pelo seu comprimento e retorna um dicionário onde as chaves são os comprimentos e os valores são listas de palavras com aquele comprimento.

**Solução**:
```python
from pyspark import SparkContext

# Inicializar SparkContext
sc = SparkContext("local", "GroupByLength")

def agrupar_por_tamanho(rdd):
    # Mapear cada palavra para um par (comprimento, palavra)
    pares = rdd.map(lambda palavra: (len(palavra), palavra))
    
    # Agrupar palavras por comprimento
    grupos = pares.groupByKey()
    
    # Converter os grupos para dicionário
    resultado = grupos.mapValues(list).collectAsMap()
    
    return resultado

# Exemplo de uso
palavras = ["Spark", "é", "ótimo", "para", "processamento", "de", "dados"]
rdd = sc.parallelize(palavras)
print(agrupar_por_tamanho(rdd))
```

**Comentários do Código**:
1. **map**: Converte cada palavra em um par (comprimento, palavra).
2. **groupByKey**: Agrupa as palavras pelo comprimento.
3. **mapValues(list)**: Converte cada grupo de palavras em uma lista.
4. **collectAsMap**: Coleta o resultado como um dicionário.

### Exercício 6: Filtrar e Contar Ocorrências em um RDD de Tuplas

**Enunciado**:
Dado um RDD de tuplas onde cada tupla contém um identificador e um valor, crie uma função `filtrar_e_contar` que filtra os valores maiores que um determinado limite e retorna a contagem de valores para cada identificador.

**Solução**:
```python
from pyspark import SparkContext

# Inicializar SparkContext
sc = SparkContext("local", "FilterAndCount")

def filtrar_e_contar(rdd, limite):
    # Filtrar valores maiores que o limite
    filtrados = rdd.filter(lambda x: x[1] > limite)
    
    # Mapear cada tupla para (id, 1)
    pares = filtrados.map(lambda x: (x[0], 1))
    
    # Contar os valores para cada identificador
    contagem = pares.reduceByKey(lambda a, b: a + b)
    
    # Coletar o resultado e retornar como uma lista de pares (id, contagem)
    return contagem.collect()

# Exemplo de uso
dados = [
    ("A", 10), ("B", 20), ("A", 5), ("B", 15), ("A", 25), ("B", 30)
]

rdd = sc.parallelize(dados)
print(filtrar_e_contar(rdd, 15))
```

**Comentários do Código**:
1. **filter**: Filtra as tuplas com valores maiores que o limite.
2. **map**: Converte cada tupla filtrada em um par (id, 1).
3. **reduceByKey**: Conta os valores para cada identificador.
4. **collect**: Coleta o resultado final como uma lista de pares (id, contagem).

Claro, aqui estão mais alguns exemplos de exercícios utilizando `flatMap` e `join` em Spark.

### Exercício 7: Expandir Frases em Palavras com `flatMap`

**Enunciado**:
Dado um RDD de frases, crie uma função `expandir_frases` que expande cada frase em palavras individuais e retorna um novo RDD contendo todas as palavras.

**Solução**:
```python
from pyspark import SparkContext

# Inicializar SparkContext
sc = SparkContext("local", "ExpandPhrases")

def expandir_frases(rdd):
    # Usar flatMap para expandir cada frase em palavras
    palavras = rdd.flatMap(lambda frase: frase.split())
    
    return palavras.collect()

# Exemplo de uso
frases = [
    "Spark é incrível",
    "Processamento de dados em grande escala",
    "Big Data com Spark"
]

rdd = sc.parallelize(frases)
print(expandir_frases(rdd))
```

**Comentários do Código**:
1. **flatMap**: Divide cada frase em palavras individuais, criando um novo RDD contendo todas as palavras.
2. **collect**: Coleta o resultado final como uma lista de palavras.

### Exercício 8: Realizar um Join entre Dois RDDs

**Enunciado**:
Dado dois RDDs, um contendo informações de produtos (`id_produto`, `nome`) e outro contendo vendas (`id_venda`, `id_produto`, `quantidade`), crie uma função `juntar_produtos_vendas` que realiza um join entre os dois RDDs para associar o nome do produto às vendas.

**Solução**:
```python
from pyspark import SparkContext

# Inicializar SparkContext
sc = SparkContext("local", "JoinExample")

def juntar_produtos_vendas(rdd_produtos, rdd_vendas):
    # Mapear rdd_produtos para (id_produto, nome)
    produtos = rdd_produtos.map(lambda x: (x[0], x[1]))
    
    # Mapear rdd_vendas para (id_produto, (id_venda, quantidade))
    vendas = rdd_vendas.map(lambda x: (x[1], (x[0], x[2])))
    
    # Realizar o join entre os dois RDDs
    join_rdd = produtos.join(vendas)
    
    # Transformar o resultado em (id_venda, nome_produto, quantidade)
    resultado = join_rdd.map(lambda x: (x[1][1][0], x[1][0], x[1][1][1]))
    
    return resultado.collect()

# Exemplo de uso
produtos = [
    (1, "Produto A"),
    (2, "Produto B"),
    (3, "Produto C")
]

vendas = [
    (101, 1, 10),
    (102, 2, 20),
    (103, 3, 30),
    (104, 1, 5)
]

rdd_produtos = sc.parallelize(produtos)
rdd_vendas = sc.parallelize(vendas)
print(juntar_produtos_vendas(rdd_produtos, rdd_vendas))
```

**Comentários do Código**:
1. **map**: Mapeia os RDDs para criar pares (chave, valor).
2. **join**: Realiza um join entre os dois RDDs com base na chave `id_produto`.
3. **map**: Transforma o resultado do join para o formato desejado.
4. **collect**: Coleta o resultado final como uma lista de tuplas.

### Exercício 9: Analisar Logs com `flatMap` e `join`

**Enunciado**:
Dado um RDD de logs de acesso (`ip`, `url`, `timestamp`) e um RDD de geolocalização (`ip`, `país`), crie uma função `analisar_logs` que associa cada acesso ao país de origem e conta o número de acessos por país.

**Solução**:
```python
from pyspark import SparkContext

# Inicializar SparkContext
sc = SparkContext("local", "LogAnalysis")

def analisar_logs(rdd_logs, rdd_geo):
    # Mapear rdd_logs para (ip, (url, timestamp))
    logs = rdd_logs.map(lambda x: (x[0], (x[1], x[2])))
    
    # Mapear rdd_geo para (ip, país)
    geo = rdd_geo.map(lambda x: (x[0], x[1]))
    
    # Realizar o join entre os logs e as geolocalizações
    join_rdd = logs.join(geo)
    
    # Transformar o resultado em (país, 1)
    paises = join_rdd.map(lambda x: (x[1][1], 1))
    
    # Contar os acessos por país
    acessos_por_pais = paises.reduceByKey(lambda a, b: a + b)
    
    return acessos_por_pais.collect()

# Exemplo de uso
logs = [
    ("192.168.1.1", "http://example.com", "2024-05-01 10:00:00"),
    ("192.168.1.2", "http://example.org", "2024-05-01 10:05:00"),
    ("192.168.1.1", "http://example.net", "2024-05-01 10:10:00"),
    ("192.168.1.3", "http://example.com", "2024-05-01 10:15:00")
]

geo = [
    ("192.168.1.1", "Brasil"),
    ("192.168.1.2", "Argentina"),
    ("192.168.1.3", "Chile")
]

rdd_logs = sc.parallelize(logs)
rdd_geo = sc.parallelize(geo)
print(analisar_logs(rdd_logs, rdd_geo))
```

**Comentários do Código**:
1. **map**: Mapeia os RDDs para criar pares (chave, valor).
2. **join**: Realiza um join entre os logs e as geolocalizações com base na chave `ip`.
3. **map**: Transforma o resultado do join para pares (país, 1).
4. **reduceByKey**: Conta o número de acessos por país.
5. **collect**: Coleta o resultado final como uma lista de pares (país, contagem).

### Exercício 10: Encontrar Produtos com `flatMap` e `join`

**Enunciado**:
Dado um RDD de transações de compra (`id_transacao`, `id_produto`, `quantidade`, `preco_unitario`) e um RDD de produtos (`id_produto`, `nome_produto`), crie uma função `encontrar_produtos` que retorna o nome dos produtos comprados e o total gasto em cada um.

**Solução**:
```python
from pyspark import SparkContext

# Inicializar SparkContext
sc = SparkContext("local", "ProductAnalysis")

def encontrar_produtos(rdd_transacoes, rdd_produtos):
    # Mapear rdd_transacoes para (id_produto, (quantidade, preco_unitario))
    transacoes = rdd_transacoes.map(lambda x: (x[1], (x[2], x[3])))
    
    # Mapear rdd_produtos para (id_produto, nome_produto)
    produtos = rdd_produtos.map(lambda x: (x[0], x[1]))
    
    # Realizar o join entre transações e produtos
    join_rdd = transacoes.join(produtos)
    
    # Calcular o total gasto por produto
    gastos_por_produto = join_rdd.map(lambda x: (x[1][1], x[1][0][0] * x[1][0][1]))
    
    # Somar os gastos por produto
    total_gastos = gastos_por_produto.reduceByKey(lambda a, b: a + b)
    
    return total_gastos.collect()

# Exemplo de uso
transacoes = [
    (1, 101, 2, 50.0),
    (2, 102, 1, 30.0),
    (3, 101, 1, 50.0),
    (4, 103, 5, 10.0)
]

produtos = [
    (101, "Produto A"),
    (102, "Produto B"),
    (103, "Produto C")
]

rdd_transacoes = sc.parallelize(transacoes)
rdd_produtos = sc.parallelize(produtos)
print(encontrar_produtos(rdd_transacoes, rdd_produtos))
```

**Comentários do Código**:
1. **map**: Mapeia os RDDs para criar pares (chave, valor).
2. **join**: Realiza um join entre as transações e os produtos com base na chave `id_produto`.
3. **map**: Calcula o total gasto por produto.
4. **reduceByKey**: Soma os gastos para cada produto.
5. **collect**: Coleta o resultado final como uma lista de pares (produto, total gasto).

Espero que esses exemplos adicionais ajudem você a se preparar para sua prova. Boa sorte!