# Repositório de dados sobre casos e óbitos decorrentes do COVID-19 nos municípios do Estado de São Paulo e sobre leitos e internações por Departamento Regional de Saúde

## Apresentação e dados

O SEADE mantém um painel de dados sobre casos e óbitos relacionados ao coronavírus no Estado de São Paulo a partir de dados oficiais da Secretaria de Estado da Saúde de São Paulo (SES). Os dados estão disponíveis em https://www.seade.gov.br/coronavirus/.

### NOTA 10.03.2023

A partir de 11 de março de 2023 os conjuntos de dados não serão atualizados nos finais de semana e feriados. Os dados não publicados serão incluídos no dia útil subsequente.

### NOTA 01.03.2023

A partir de 01.03.23, as atualizações bancos de dados completos de [casos e óbitos por municípios e data](https://repositorio.seade.gov.br/dataset/b4bd5b75-0c6c-44d9-8fc4-9c5d9a480647/resource/d2bad7a1-6c38-4dda-b409-656bff3fa56a/download/dados_covid_sp.csv.zip); [casos, óbitos e doenças pré-existentes](https://repositorio.seade.gov.br/dataset/b4bd5b75-0c6c-44d9-8fc4-9c5d9a480647/resource/5ba14ec6-dd19-4568-9625-b074c0a9c87e/download/casos_obitos_doencas_preexistentes.csv.zip); [casos, óbitos por raça/cor e município](https://repositorio.seade.gov.br/dataset/b4bd5b75-0c6c-44d9-8fc4-9c5d9a480647/resource/a730d5c1-7899-4455-8649-68e7e8cc1753/download/casos_obitos_raca_cor.csv.zip) também serão divulgados no Repositório do SEADE.

**A partir de 08.03.23, as atualizações dos arquivos anteriormente referidos não serão mais disponibilizados via GitHub, e serão disponibilizados somente via Repositório do SEADE**.

A partir de 01.03.23, o [arquivo de casos e óbitos](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv) passa a ser publicado sem as seguintes variáveis: `casos_pc`, `obitos_pc`, `nome_drs`, `cod_drs`.

As colunas excluídas continuarão a ser publicadas no arquivo informado acima: [AQUI link para arquivo no Repositório do SEADE](https://repositorio.seade.gov.br/dataset/b4bd5b75-0c6c-44d9-8fc4-9c5d9a480647/resource/d2bad7a1-6c38-4dda-b409-656bff3fa56a/download/dados_covid_sp.csv.zip).

### Casos e óbitos 

Casos e óbitos por municípios e data: **Download dos dados de casos e óbitos**: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv).

### Leitos e Internações

Leitos e internações por Departamento Regional de Saúde segundo os critérios utilizados no Plano SP.

**Série antiga (variação mensal)**: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/plano_sp_leitos_internacoes_serie_nova.csv).

**Série antiga (variação semanal)**: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/plano_sp_leitos_internacoes.csv).

**Série em uso (variação semanal e Grande São Paulo unificada)**: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/plano_sp_leitos_internacoes_serie_nova_variacao_semanal.csv).

### SRAG

Hospitalizados por Síndrome Respiratória Aguda Grave (SRAG). Fonte: SIVEP-Gripe. **Download dos dados de casos de SRAG**: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/SRAG_2020.csv). Última atualização: 15/06/2020

Dicionário dos dados de hospitalizados por SRAG [AQUI](https://github.com/seade-R/dados-covid-sp/blob/master/data/dicionario_de_dados_srag_hospitalizado_atual-sivepgripe.pdf)

### Casos, óbitos e doenças pré-existentes

Casos e óbitos por doenças pré-existentes, sexo e idade. Fonte: SIVEP-Gripe. **Download dos dados de casos, óbitos e doenças pré-existentes**: [FORMATO .zip](https://repositorio.seade.gov.br/dataset/b4bd5b75-0c6c-44d9-8fc4-9c5d9a480647/resource/5ba14ec6-dd19-4568-9625-b074c0a9c87e/download/casos_obitos_doencas_preexistentes.csv.zip).

### Casos, óbitos por raça/cor e município.

Casos e óbitos por doenças pré-existentes e município. Fonte: SIVEP-Gripe. **Download dos dados casos, óbitos por raça/cor e município**: [FORMATO .zip](https://repositorio.seade.gov.br/dataset/b4bd5b75-0c6c-44d9-8fc4-9c5d9a480647/resource/a730d5c1-7899-4455-8649-68e7e8cc1753/download/casos_obitos_raca_cor.csv.zip).

## Dicionário de variáveis, fontes primárias e demais informações técnicas

### Dicionário para o arquivo de casos e óbitos

|Variável|Descrição|
|---|---|
|nome_munic| Nome do município|
|codigo_ibge| Código do município no IBGE (7 dígitos)|
|datahora| Data no formato YYYY-MM-DD|
|casos| Casos totais registrados até a data|
|casos_novos| Casos novos registrados na data|
|casos_mm7d| Média móvel dos últimos 7 dias dos novos casos|
|obitos| Óbitos totais registrados até a data|
|obitos_novos| Óbitos novos registrados na data|
|obitos_mm7d| Média móvel dos últimos 7 dias dos novos óbitos|
|letalidade| casos / obitos|
|pop| População Estimada (fonte: SEADE)|
|semana_epidem| Semana Epidemológica|

### Dicionário para o arquivo de leitos e internações

Série antiga

|Variável|Descrição|
|---|---|
|datahora| Data no formato YYYY-MM-DD|
|nome_drs| DRS ou região da Grande São Paulo|
|pacientes_uti_mm7d| Média móvel para 7 dias do Pacientes Internados em Leitos de UTI Destinados para COVID-19 no dia|
|total_covid_uti_mm7d| Média móvel para 7 dias do Total de Leitos de UTI Destinados para COVID-19 no dia|
|ocupacao_leitos| Ocupação de leitos de UTI destinados para COVID-19 (pacientes_uti_mm7d / total_covid_uti_mm7d)|
|pop| População da DRS ou região da Grande São Paulo (Fonte: SEADE)|
|leitos_pc| Leitos Covid-19 UTI por 100 mil habitantes (total_covid_uti_mm7d / pop)|
|internacoes_7d| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 nos últimos 7 dias|
|internacoes_7d_l| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 nos 7 dias anteriores|
|internacoes_7v7| Variação no número de novas internações ((internacoes_7d - internacoes_7d_l) / internacoes_7d_l)|
|pacientes_uti_ultimo_dia| Pacientes Internados em Leitos de UTI Destinados para COVID-19 no último dia|
|total_covid_uti_ultimos_dia| Total de Leitos de UTI Destinados para COVID-19 no último dia|
|ocupacao_leitos_ultimos_dia| Ocupação de leitos de UTI destinados para COVID-19 no último dia (pacientes_uti / total_covid_uti)|
|internacoes_ultimo_dia| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 no último dia|
|pacientes_enf_mm7d| Média móvel para 7 dias do Pacientes Internados em Leitos de Enfermaria Destinados para COVID-19 no dia|
|total_covid_enf_mm7d| Média móvel para 7 dias do Total de Leitos de Enfermaria Destinados para COVID-19 no dia|
|pacientes_enf_ultimo_dia| Pacientes Internados em Leitos de Enfermaria Destinados para COVID-19 no último dia|
|total_covid_enf_ultimos_dia| Total de Leitos de Enfermaria Destinados para COVID-19 no último dia|

Série nova variação semanal

|Variável|Descrição|
|---|---|
|datahora| Data no formato YYYY-MM-DD|
|nome_drs| DRS|
|pacientes_uti_mm7d| Média móvel para 7 dias do Pacientes Internados em Leitos de UTI Destinados para COVID-19 no dia|
|total_covid_uti_mm7d| Média móvel para 7 dias do Total de Leitos de UTI Destinados para COVID-19 no dia|
|ocupacao_leitos| Ocupação de leitos de UTI destinados para COVID-19 (pacientes_uti_mm7d / total_covid_uti_mm7d)|
|pop| População da DRS ou região da Grande São Paulo (Fonte: SEADE)|
|leitos_pc| Leitos Covid-19 UTI por 100 mil habitantes (total_covid_uti_mm7d / pop)|
|internacoes_7d| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 nos últimos 7 dias|
|internacoes_7d_l| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 nos 7 dias anteriores|
|internacoes_7v7| Variação no número de novas internações ((internacoes_7d - internacoes_7d_l) / internacoes_7d_l)|
|pacientes_uti_ultimo_dia| Pacientes Internados em Leitos de UTI Destinados para COVID-19 no último dia|
|total_covid_uti_ultimos_dia| Total de Leitos de UTI Destinados para COVID-19 no último dia|
|ocupacao_leitos_ultimos_dia| Ocupação de leitos de UTI destinados para COVID-19 no último dia (pacientes_uti / total_covid_uti)|
|internacoes_ultimo_dia| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 no último dia|
|pacientes_enf_mm7d| Média móvel para 7 dias do Pacientes Internados em Leitos de Enfermaria Destinados para COVID-19 no dia|
|total_covid_enf_mm7d| Média móvel para 7 dias do Total de Leitos de Enfermaria Destinados para COVID-19 no dia|
|pacientes_enf_ultimo_dia| Pacientes Internados em Leitos de Enfermaria Destinados para COVID-19 no último dia|
|total_covid_enf_ultimos_dia| Total de Leitos de Enfermaria Destinados para COVID-19 no último dia|

Série nova

|Variável|Descrição|
|---|---|
|datahora| Data no formato YYYY-MM-DD|
|nome_drs| DRS ou região da Grande São Paulo|
|pacientes_uti_mm7d| Média móvel para 7 dias do Pacientes Internados em Leitos de UTI Destinados para COVID-19 no dia|
|total_covid_uti_mm7d| Média móvel para 7 dias do Total de Leitos de UTI Destinados para COVID-19 no dia|
|ocupacao_leitos| Ocupação de leitos de UTI destinados para COVID-19 (pacientes_uti_mm7d / total_covid_uti_mm7d)|
|pop| População da DRS ou região da Grande São Paulo (Fonte: SEADE)|
|leitos_pc| Leitos Covid-19 UTI por 100 mil habitantes (total_covid_uti_mm7d / pop)|
|internacoes_28d| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 nos últimos 28 dias|
|internacoes_28d_l| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 nos 28 dias anteriores|
|internacoes_28v28| Variação no número de novas internações ((internacoes_28d - internacoes_28d_l) / internacoes_28d_l)|
|internacoes_ultimo_dia| Número de novas internações (UTI e Enfermaria) de pacientes confirmados ou com suspeita de COVID-19 no último dia|
|pacientes_enf_mm7d| Média móvel para 7 dias do Pacientes Internados em Leitos de Enfermaria Destinados para COVID-19 no dia|
|total_covid_enf_mm7d| Média móvel para 7 dias do Total de Leitos de Enfermaria Destinados para COVID-19 no dia|
|pacientes_enf_ultimo_dia| Pacientes Internados em Leitos de Enfermaria Destinados para COVID-19 no último dia|
|total_covid_enf_ultimos_dia| Total de Leitos de Enfermaria Destinados para COVID-19 no último dia|


### Dicionário para o arquivo de Casos, óbitos e doenças pré-existentes

|Variável|Descrição|
|---|---|
|codigo_ibge| Código do município no IBGE (7 dígitos) de residência do paciente|
|nome_munic| Nome do município de residência do paciente|
|idade|Idade do paciente|
|cs_sexo|Sexo do paciente|
|diagnostico_covid19|Confirmação de COVID-19|
|data_inicio_sintomas|Data de início dos sintomas|
|obito|Indica se o paciente veio a óbito por COVID-19|
|asma|Paciente apresenta esse fator de risco (asma)|
|cardiopatia|Paciente apresenta esse fator de risco (cardiopatia)|
|diabetes|Paciente apresenta esse fator de risco (diabetes)|
|doenca_hematologica|Paciente apresenta esse fator de risco (doença hematológica)|
|doenca_hepatica|Paciente apresenta esse fator de risco (doença hepática)|
|doenca_neurologica|Paciente apresenta esse fator de risco (doença neurológica)|
|doenca_renal|Paciente apresenta esse fator de risco (doença renal)|
|imunodepressao|Paciente apresenta esse fator de risco (imunodepressão)|
|obesidade|Paciente apresenta esse fator de risco (obesidade)|
|outros_fatores_de_risco|Paciente apresenta outros fatores de risco|
|pneumopatia|Paciente apresenta esse fator de risco (pneumopatia)|
|puerpera|Paciente se encontra nesse estágio (puérpera)|
|sindrome_de_down|Paciente apresenta esse fator de risco (síndrome de down)|

### Casos, óbitos por raça/cor e município

|Variável|Descrição|
|---|---|
|codigo_ibge| Código do município no IBGE (7 dígitos) de residência do paciente|
|nome_munic| Nome do município de residência do paciente|
|nome_drs| Nome do Dpto. Regional de Saúde de residência do paciente|
|obito|Indica se o paciente veio a óbito por COVID-19|
|raca_cor| Cor ou raça do paciente|
|idade|Idade do paciente|
|cs_sexo|Sexo do paciente|
|diagnostico_covid19|Confirmação de COVID-19|
|asma|Paciente apresenta esse fator de risco (asma)|
|cardiopatia|Paciente apresenta esse fator de risco (cardiopatia)|
|diabetes|Paciente apresenta esse fator de risco (diabetes)|
|doenca_hematologica|Paciente apresenta esse fator de risco (doença hematológica)|
|doenca_hepatica|Paciente apresenta esse fator de risco (doença hepática)|
|doenca_neurologica|Paciente apresenta esse fator de risco (doença neurológica)|
|doenca_renal|Paciente apresenta esse fator de risco (doença renal)|
|imunodepressao|Paciente apresenta esse fator de risco (imunodepressão)|
|obesidade|Paciente apresenta esse fator de risco (obesidade)|
|pneumopatia|Paciente apresenta esse fator de risco (pneumopatia)|
|puerpera|Paciente se encontra nesse estágio (puérpera)|
|sindrome_de_down|Paciente apresenta esse fator de risco (síndrome de down)|

### Notas

[11.06.2020] NOTA: As informações sobre leitos e internações em dias anteriores podem conter pequenas variações em novas versões publicadas em virtude de atualizações no banco de dados do Censo Covid.

[02.09.2020] NOTA: O arquivo do histórico de leitos e internações foi atualizado para se adequar aos critérios utilizados no Plano São Paulo.

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

####  [22.08.20]

Inclusão do arquivo de casos, óbitos e raça/cor. Atualização dos dicionários das bases de casos, óbitos e doenças pré-existentes e de casos, óbitos e raça/cor. Inclusão de variáveis de taxa de ocupação de leitos e pacientes internados por DRS (média de 7 dias) no arquivo de Leitos e Internações.

####  [09.10.20]

Para acompanhar as mudanças do Plano São Paulo, adicionamos uma segunda versão do arquivo de leitos e internações com a nova regionalização da Grande São Paulo, reagrupada, e as variáveis calculadas para períodos de 28 dias.

####  [06.11.20]

Não houve atualização das informações de casos e óbitos no dia 06 de Novembro de 2020 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

####  [07.11.20]

Não houve atualização das informações de casos e óbitos no dia 07 de Novembro de 2020 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

####  [08.11.20]

Não houve atualização das informações de casos e óbitos no dia 08 de Novembro de 2020 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

####  [09.11.20]

Não houve atualização das informações de casos e óbitos no dia 09 de Novembro de 2020 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

####  [10.11.20]

Não houve atualização das informações de casos e óbitos no dia 09 de Novembro de 2020 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

####  [11.11.20]

A SES-SP retomou a extração de dados após normalização dos dados do sistema federal SIVEP, onde ocorre a notificação de casos graves e óbitos

Os dados foram atualizados na manhã do dia 11.11.20, após normalização do sistema de notificação do Ministério da Saúde que esteve inacessível desde a última sexta-feira (6) por problemas técnicos, segundo o governo federal.

Mais informações em [https://www.saopaulo.sp.gov.br/noticias-coronavirus/sp-registra-399-mil-obitos-e-115-milhao-casos-de-coronavirus/](https://www.saopaulo.sp.gov.br/noticias-coronavirus/sp-registra-399-mil-obitos-e-115-milhao-casos-de-coronavirus/)

####  [13.11.20]

Não houve atualização das informações de casos e óbitos no dia 09 de Novembro de 2020 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

####  [11.03.21]

Incluímos nos arquivos de leitos e internações as informações sobre pacientes, leitos e ocupação de leitos relativos a Covid-19 do útimos dia, ademais das médias móveis dos últimos 7 dias

####  [27.05.21]

Em razão de atualizações no sistema de organização de dados do Censo Covid, os indicadores sobre ocupação de leitos, pacientes e internações não foram disponibilizados hoje, 27/maio.

####  [28.05.21]

Em virtude de indisponibilidade do e-SUS Notifica, ferramenta online de registro de casos de COVID-19 do Ministério da Saúde, há uma variação atípica no número de novos casos em 28/maio.

####  [29.05.21]

Em razão de atualizações no sistema de organização de dados do Censo Covid, os indicadores sobre ocupação de leitos, pacientes e internações não foram disponibilizados hoje, 29/maio.

####  [30.05.21]

Em razão de atualizações no sistema de organização de dados do Censo Covid, os indicadores sobre ocupação de leitos, pacientes e internações não foram disponibilizados hoje, 30/maio.

####  [31.05.21]

Em razão de atualizações no sistema de organização de dados do Censo Covid, os indicadores sobre ocupação de leitos, pacientes e internações não foram disponibilizados hoje, 31/maio.

####  [01.06.21]

Em razão de atualizações no sistema de organização de dados do Censo Covid, os indicadores sobre ocupação de leitos, pacientes e internações não foram disponibilizados hoje, 01/junho.

####  [02.06.21]

Em razão de atualizações no sistema de organização de dados do Censo Covid, os indicadores sobre ocupação de leitos, pacientes e internações não foram disponibilizados hoje, 02/junho.

####  [17.07.21]

Não houve atualização das informações de casos e óbitos em 17/Julho/2021 por indisponibilidade dos dados.

####  [12.11.21]

Não houve atualização das informações de casos e óbitos em 12/Dezembro/2021 por indisponibilidade dos dados.

####  [14.11.21]

Em razão de problemas de instabilidade na rede externa do SEADE, os indicadores sobre ocupação de leitos, pacientes e internações foram disponibilizados hoje, 14/nov/21, após as 18h30.

#### [11.12.21]

Não houve atualização das informações de casos e óbitos no dias 11 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [12.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 e 12 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [13.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11, 12 e 13 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [14.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11, 12, 13 e 14 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [15.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 15 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [16.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 16 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [17.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 17 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [18.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 18 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [19.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 19 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [20.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 20 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [21.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 21 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [22.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 22 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [23.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 23 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [24.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 24 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [25.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 25 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [26.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 26 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [27.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 27 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [28.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 28 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [29.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 29 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [30.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 30 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [31.12.21]

Não houve atualização das informações de casos e óbitos nos dias 11 a 30 de Dezembro de 2021 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [01.01.22]

Não houve atualização das informações de casos e óbitos nos dias 11 de Dezembro de 2021 a 01 de Janeiro de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [02.01.22]

Não houve atualização das informações de casos e óbitos nos dias 11 de Dezembro de 2021 a 02 de Janeiro de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

##### [03.01.22]

Não houve atualização das informações de casos e óbitos nos dias 11 de Dezembro de 2021 a 03 de Janeiro de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [28.01.22]

Em razão de alteração nas informações no sistema federal de notificação de dados de Covid-19, os dados de casos e óbitos foram alterados às 17h, após a atualização realizada hoje, 28 de Janeiro, às 14:00h.

#### [31.01.22]

Em razão de alteração nas informações no sistema federal de notificação de dados de Covid-19, os dados de casos e óbitos foram alterados às 17h, após a atualização realizada hoje, 31 de Janeiro, às 14:00h.

#### [07.02.22]

A partir de 07.02.2022, o [arquivo de casos e óbitos](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv) passa a ser publicado sem as seguintes variáveis: `dia`, `mes`, `pop_60`, `area`, `map_leg`, `map_leg_s`, `latitude`, `longitude`.

As colunas excluídas continuarão a ser publicadas em um arquivo compactado disponível no link: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv.zip).

#### [11.04.22]

Em razão de alteração nas informações no sistema federal de notificação de dados de Covid-19, os dados de casos e óbitos foram alterados às 19h, após a atualização realizada hoje, 11 de abril, às 15h.

#### [22.05.22]

Não houve atualização das informações nos dias 21 e 22 de Maio de 2022 em virtude de problemas nos sistemas de dados da Covid-19.

#### [03.06.22]

Não houve atualização das informações de casos e óbitos no dia 03 de Junho de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [04.06.22]

Não houve atualização das informações de casos e óbitos nos dias 03 e 04 de Junho de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [05.06.22]

Não houve atualização das informações de casos e óbitos nos dias 03 a 05 de Junho de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [06.06.22]

Não houve atualização das informações de casos e óbitos nos dias 03 a 06 de Junho de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [14.06.22]

Não houve atualização das informações no dia 14 de Junho de 2022 em virtude de problemas nos sistemas de dados da Covid-19.

#### [11.07.22]

A partir de 11.07.2022, o [arquivo de casos e óbitos](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv) passa a ser publicado sem as seguintes variáveis: `cod_ra`, `nome_ra`.

As colunas excluídas continuarão a ser publicadas em um arquivo compactado disponível no link: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv.zip).

#### [11.08.22]

Não houve atualização das informações no dia 11 de Agosto de 2022 em virtude de problemas nos sistemas de dados da Covid-19.

#### [29.09.22]

Não houve atualização das informações de óbitos nos dias 28 e 29 de Setembro de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [30.09.22]

Não houve atualização das informações de óbitos entre os dias 28 e 30 de Setembro de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [16.10.22]

Não houve atualização das informações de casos e óbitos no dia 16 de Outubro de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [20.10.22]

Não houve atualização das informações de casos e óbitos no dia 20 de Outubro de 2022 em virtude de problemas nos sistemas de dados da Covid-19.

#### [21.10.22]

Não houve atualização das informações de casos e óbitos nos dias 20 e 21 de Outubro de 2022 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [29.10.22]

Não houve atualização das informações de casos e óbitos no dia 29 de Outubro de 2022 em virtude de problemas nos sistemas de dados da Covid-19.

#### [30.10.22]

A partir de 30.10.2022, o [arquivo de casos e óbitos](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv) passa a ser publicado sem a seguinte variável: `letalidade`.

As colunas excluídas continuarão a ser publicadas em um arquivo compactado disponível no link: [AQUI](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv.zip).

#### [09.12.22]

Não houve atualização das informações de casos e óbitos no dia 09 de Dezembro de 2022 em virtude de problemas nos sistemas de dados da Covid-19.

#### [10.12.22]

Não houve atualização das informações de casos e óbitos no dia 10 de Dezembro de 2022 em virtude de problemas nos sistemas de dados da Covid-19. As informações de casos e óbitos referentes ao dia 09 de Dezembro de 2022 foram atualizadas.

#### [01.01.23]

Não houve atualização das informações no dia 01 de Janeiro de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [10.01.23]

Não houve atualização das informações de óbitos no dia 10 de Janeiro de 2023 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [11.01.23]

Não houve atualização das informações de óbitos nos dias 10 e 11 de Janeiro de 2023 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [12.01.23]

Não houve atualização das informações de óbitos nos dias 10 a 12 de Janeiro de 2023 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [13.01.23]

Não houve atualização das informações de óbitos nos dias 10 a 13 de Janeiro de 2023 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [14.01.23]

Não houve atualização das informações de óbitos nos dias 10 a 14 de Janeiro de 2023 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [15.01.23]

Não houve atualização informações de casos e óbitos em 15 de Janeiro de 2023, e de óbitos entre 10 e 14 de Janeiro de 2023, em virtude de problemas nos sistemas de dados da Covid-19.

#### [16.01.23]

Não houve atualização das informações de óbitos nos dias 10 a 16 de Janeiro de 2023 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [17.01.23]

Não houve atualização das informações de óbitos nos dias 10 a 17 de Janeiro de 2023 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [18.01.23]

Não houve atualização das informações de óbitos nos dias 10 a 18 de Janeiro de 2023 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [21.01.23]

Não houve atualização das informações de casos e óbitos no dia 21 de Janeiro de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [22.01.23]

Não houve atualização das informações de casos e óbitos nos dias 21 e 22 de Janeiro de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [23.01.23]

Não houve atualização das informações de óbitos nos dias 21 a 23 de Janeiro de 2023 em virtude de problemas no sistema federal de notificação de dados da Covid-19.

#### [28.01.23]

Não houve atualização das informações de casos e óbitos no dia 28 de Janeiro de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [18.02.23]

Não houve atualização das informações de casos e óbitos no dia 18 de Fevereiro de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [19.02.23]

Não houve atualização das informações de casos e óbitos no dia 19 Fevereiro de 2023 em virtude de problemas nos sistemas de dados da Covid-19. As informações de casos e óbitos referentes ao dia 18 de Fevereiro de 2023 foram atualizadas.

#### [20.02.23]

Não houve atualização das informações de casos e óbitos no dia 20 Fevereiro de 2023 em virtude de problemas nos sistemas de dados da Covid-19. As informações de casos e óbitos referentes ao dia 19 de Fevereiro de 2023 foram atualizadas.

#### [21.02.23]

Não houve atualização das informações de casos e óbitos nos dias 20 e 21 de Fevereiro de 2023 em virtude de problemas nos sistemas de dados da Covid-19. 

#### [01.03.23]

A partir de 01.03.23, as atualizações bancos de dados completos de [casos e óbitos por municípios e data](https://repositorio.seade.gov.br/dataset/b4bd5b75-0c6c-44d9-8fc4-9c5d9a480647/resource/d2bad7a1-6c38-4dda-b409-656bff3fa56a/download/dados_covid_sp.csv.zip); [casos, óbitos e doenças pré-existentes](https://repositorio.seade.gov.br/dataset/b4bd5b75-0c6c-44d9-8fc4-9c5d9a480647/resource/5ba14ec6-dd19-4568-9625-b074c0a9c87e/download/casos_obitos_doencas_preexistentes.csv.zip); [casos, óbitos por raça/cor e município](https://repositorio.seade.gov.br/dataset/b4bd5b75-0c6c-44d9-8fc4-9c5d9a480647/resource/a730d5c1-7899-4455-8649-68e7e8cc1753/download/casos_obitos_raca_cor.csv.zip) também serão divulgados no Repositório do SEADE.

**A partir de 08.03.23, as atualizações dos arquivos anteriormente referidos não serão mais disponibilizados via GitHub, e serão disponibilizados somente via Repositório do SEADE**.

A partir de 01.03.23, o [arquivo de casos e óbitos](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv) passa a ser publicado sem as seguintes variáveis: `casos_pc`, `obitos_pc`, `nome_drs`, `cod_drs`.

As colunas excluídas continuarão a ser publicadas no arquivo informado acima: [AQUI link para arquivo no Repositório do SEADE](https://repositorio.seade.gov.br/dataset/b4bd5b75-0c6c-44d9-8fc4-9c5d9a480647/resource/d2bad7a1-6c38-4dda-b409-656bff3fa56a/download/dados_covid_sp.csv.zip).

#### [06.03.23]

Não houve atualização das informações de casos e óbitos no dia 06 de Março de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [10.03.23]

A partir de 11 de março de 2023 os conjuntos de dados não serão atualizados nos finais de semana e feriados. Os dados não publicados serão incluídos no dia útil subsequente.

#### [15.03.23]

Não houve atualização das informações de casos e óbitos no dia 15 de Março de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [27.03.23]

Não houve atualização das informações de casos e óbitos no dia 25 a 27 de Março de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [09.05.23]

Não houve atualização das informações de casos e óbitos no dia 09 de maio de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [07.06.23]

Não houve atualização das informações de casos e óbitos no dia 09 de maio de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [13.06.23]

Não houve atualização das informações de casos e óbitos no dia 09 de maio de 2023 em virtude de problemas nos sistemas de dados da Covid-19.

#### [16.06.23]

Em virtude de problemas nos sistemas de dados da Covid-19, não houve atualização das informações em 16/06/2023.

#### [23.06.23]

Em virtude de problemas nos sistemas de dados da Covid-19, não houve atualização das informações em 23/06/2023.


#### [30.06.23]

Em virtude de problemas nos sistemas de dados da Covid-19, não houve atualização das informações em 23/06/2023.

## Informações adicionais

Atualização: diária, definida pelo horário de recebimento dos dados.

Autoria: [Fundação SEADE](https://www.seade.gov.br/)

Dúvidas, críticas e sugestões sobre os dados de casos e óbitos municipais: [https://www.seade.gov.br/contato/](https://www.seade.gov.br/contato/)

Por favor, pedimos a gentileza para que solicitações de dados não disponibilizados neste repositório sejam enviadas diretamente às fontes primárias.
