# Repositório de dados sobre casos e óbitos decorrentes do COVID-19 nos municípios do Estado de São Paulo e sobre leitos e internações por Departamento Regional de Saúde

## Apresentação e dados

O SEADE mantém um painel de dados sobre casos e óbitos relacionados ao coronavírus no Estado de São Paulo a partir de dados oficiais da Secretaria de Estado da Saúde de São Paulo (SES). Os dados estão disponíveis em https://www.seade.gov.br/coronavirus/.

#### Casos e óbitos 

Para desenvolvedoras e desenvolvedores interessados em utilizar os dados de casos e óbitos por municípios e data, disponibilizamos a base em arquivo .csv. **Download dos dados de casos e óbitos**: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv).

#### Leitos e Internações

A partir do dia 08 de Junho, o SEADE disponibiliza informações sobre o leitos e internações por Departamento Regional de Saúde desde o dia 18 de junho segundo os critérios utilizados no Plano SP. **Download dos dados de leitos e internações**: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/plano_sp_leitos_internacoes.csv).

#### SRAG

A partir do dia 22 de Junho estão disponíveis dados sobre hospitalizados por Síndrome Respiratória Aguda Grave (SRAG). Fonte: SIVEP-Gripe. **Download dos dados de casos de SRAG**: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/SRAG_2020.csv). Última atualização: 15/06/2020

Dicionário dos dados de hospitalizados por SRAG [AQUI](https://github.com/seade-R/dados-covid-sp/blob/master/data/dicionario_de_dados_srag_hospitalizado_atual-sivepgripe.pdf)

#### Casos, óbitos e doenças pré-existentes.

A partir do dia 23 de Junho estão disponíveis dados sobre casos e óbitos com doenças pré-existentes, sexo e idade. Fonte: SIVEP-Gripe. A contagem de casos e óbitos feita diariamente pelo SEADE provém deste arquivo. **Download dos dados de casos, óbitos e doenças pré-existentes**: [FORMATO .zip](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/casos_obitos_doencas_preexistentes.csv.zip). A partir de 09 de Agosto de 2020 o arquivo será disponibilizado em formato .zip por conta dos limites de tamanho de arquivo no github.

## Dicionário de variáveis, fontes primárias e demais informações técnicas

#### Dicionário para o arquivo de casos e óbitos

|Variável|Descrição|
|---|---|
|nome_munic| Nome do município|
|codigo_ibge| Código do município no IBGE (7 dígitos)|
|dia| Dia|
|mes| Mês|
|datahora| Data no formato YYYY-MM-DD|
|casos| Casos totais registrados até a data|
|casos_novos| Casos novos registrados na data|
|casos_pc| Casos totais por 100 mil habitantes|
|casos_mm7d| Média móvel dos últimos 7 dias dos novos casos|
|obitos| Óbitos totais registrados até a data|
|obitos_novos| Óbitos novos registrados na data|
|obitos_pc| Óbitos totais por 100 mil habitantes|
|obitos_mm7d| Média móvel dos últimos 7 dias dos novos óbitos|
|letalidade| casos / obitos|
|nome_ra| Nome da Região Administrativa|
|cod_ra| Código da Região Administrativa|
|nome_drs| Nome do Dpto. Regional de Saúde|
|cod_drs| Código do Dpto. Regional de Saúde|
|pop| População Estimada (fonte: SEADE)|
|pop60| População Estimada (fonte: SEADE)|
|area| Área do município em Km2|
|map_leg| Rótulo da legenda para mapa|
|map_leg_s| Código da legenda para mapa|
|latitude| Latitude|
|longitude| Longitude|
|semana_epidem| Semana Epidemológica|

#### Dicionário para o arquivo de leitos e internações

|Variável|Descrição|
|---|---|
|datahora| Data no formato YYYY-MM-DD|
|nome_drs| DRS ou região da Grande São Paulo|
|total_covid_uti_mm7d| Média móvel para 7 dias do Total de Leitos de UTI Destinados para COVID-19 no dia|
|pop| População da DRS ou região da Grande São Paulo (Fonte: SEADE)|
|leitos_pc| Leitos Covid-19 UTI por 100 mil habitantes (total_covid_uti_mm7d / pop)|
|internacoes_7d| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 nos últimos 7 dias|
|internacoes_7d_l| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 nos 7 dias anteriores|
|internacoes_7v7| Variação no número de novas internações ((internacoes_7d - internacoes_7d_l) / internacoes_7d_l)|

### Notas

[11.06.2020] NOTA: As informações sobre leitos e internações em dias anteriores podem conter pequenas variações em novas versões publicadas em virtude de atualizações no banco de dados do Censo Covid.

#### Fontes

Casos e óbitos: SIVEP, SIMI-SP e SEADE

Leitos e internações: Censo COVID (SES) e SEADE

#### Encoding

Encoding dos arquivos: UTF-8

## Atualizações

#### [20.05.20]

A partir do dia 20.05.20, combinamos os arquivos enviados à imprensa pela Secretaria de Estado de Saúde com os dados organizados pelo Sistema de Monitoramento Inteligente (SIMI-SP), cuja fonte é também a Secretaria de Estado de Saúde.

Há novas variáveis e correções em relação às versões anteriores. As variáveis existentes desde a primeira versão e seus respectivos nomes foram mantidos.

####  [21.05.20]

A partir do dia 21.05.20, o SEADE eliminou incosistências nos dados de casos e óbitos totais acumulados, corrigindo decréscimos eventuais entre dias consecutivos.

####  [08.06.20]

A partir do dia 08.06.20, o SEADE passou a publicar as informações sobre leitos destinados ao tratamento da COVID-19 e novas internações seguindo os critérios adotados pelo Plano SP.

####  [09.08.20]

O arquivo de casos, óbitos e doenças pré-existentes será disponibilizado em formato .zip a partir desta data por ultrapassar o limite de tamanho de arquivos do github.

## Informações adicionais

Atualização: diária, definida pelo horário de recebimento dos dados.

Autoria: [Fundação SEADE](https://www.seade.gov.br/)

Dúvidas, críticas e sugestões sobre os dados de casos e óbitos municipais: enviar e-mail para Leonardo [leonardobarone@seade.gov.br](leonardobarone@seade.gov.br) e Cássia [cassiaadduci@seade.gov.br](cassiaadduci@seade.gov.br).

Por favor, pedimos a gentileza para que solicitações de dados não disponibilizados neste repositório sejam enviadas diretamente às fontes primárias.
