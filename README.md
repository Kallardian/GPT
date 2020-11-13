# BAIXE O APK DO GEPETO:

<a href="https://github.com/Kallardian/GPT/raw/master/frontend/mobile/GEPETO.apk">BAIXE AQUI</a>




INSTITUTO TÉCNICO DE BARUERI
BRASÍLIO FLORES DE AZEVEDO
CURSO TÉCNICO EM INFORMÁTICA





Jullia Souza Avelar – 64223
Luís Felipe Santana de Almeida e Silva – 64125
Maria Isabela da Silva Matos Bento – 64225
Paulo Victor Bertanha – 64244





GEPETO
 - Gerenciador de Projetos de TCC- 








                                                            BARUERI
DEZEMBRO / 2020
JULLIA SOUZA AVELAR/ LUÍS FELIPE SANTANA DE ALMEIDA E SILVA/ MARIA ISABELA DA SILVA MATOS BENTO/ PAULO VICTOR BERTANHA
64223/ 64125/ 64225/ 64244 – INF3BM
2020

 







 






GEPETO
 - Gerenciador de Projetos de TCC-






Trabalho de conclusão de curso apresentado ao Instituto Técnico de Barueri “Brasílio Flores de Azevedo” para a conclusão do curso Técnico em Informática.

Orientadores: Professores Técnicos 3ª série



Barueri
2020
JULLIA SOUZA AVELAR/ LUÍS FELIPE SANTANA DE ALMEIDA E SILVA/ MARIA ISABELA DA SILVA MATOS BENTO/ PAULO VICTOR BERTANHA
64223/ 64125/ 64225/ 64244 – INF3BM - 2020



GEPETO: GERENCIADOR DE PROJETOS DE TCC



Trabalho de Conclusão de Curso apresentado ao Instituto Técnico de Barueri Brasílio Flores de Azevedo para a conclusão do Curso Técnico em Informática em 2020
   


Para a conclusão do Trabalho de Conclusão de Curso, os alunos participaram de um Projeto Interdisciplinar onde desenvolveram suas habilidades, competências e potencialidades individuais, propiciando o surgimento de profissionais empreendedores, capazes de implantar novas técnicas de gestão, métodos e processos inovadores.
O aluno acima qualificado realizou no período letivo o projeto descrito neste documento, cumprindo assim todas as etapas para sua aprovação. 


Aprovado em ___/___/______



COORDENAÇÃO CURSO DE INFORMÁTICA


________________________________________________________
Prof. Marcelo Lallo.
ITB Brasílio Flores de Azevedo

 





Dedicamos este trabalho a cada um dos integrantes da equipe, aos professores, família, amigos e aos nossos pets.
AGRADECIMENTOS

	Agradecemos às nossas famílias por estarem sempre ao nosso lado, aos nossos amigos pelo apoio, aos nossos companheiros de equipe pela confiança e dedicação e a todos os professores que nos guiaram ao longo dessa trajetória.
“A computer would deserve to be called intelligent if it could deceive a human into believing that it was human.”
TURING, Alan.

RESUMO


Consiste na apresentação dos pontos relevantes do TCC. O resumo deve dar uma visão rápida e clara do trabalho; constitui-se em uma sequência de frases concisas e objetivas e não de uma simples enumeração de tópicos. Apresenta os objetivos do estudo, o problema, a metodologia, resultados alcançados e conclusão. Deve ser digitado em espaço simples e sem parágrafos, não ultrapassando a 500 palavras.


Palavras-chave: São palavras representativas do conteúdo do trabalho, separadas entre si por ponto e vírgula.
















ABSTRACT


Consiste na tradução do resumo para a língua Inglesa.


Word-Key: São palavras representativas do conteúdo do trabalho, separadas entre si por ponto e vírgula.

LISTA DE FIGURAS OU IMAGENS


Figura 1 – Classe Nomedaclasse	14
Figura 2 – Ícones	17
Figura 3 – Classe Nomedaclasse	21
Figura 4 – Tela de abertura	23
Figura 5 – Tela Cadastramento	23
Figura 6 – Tela de navegação	23
Figura 7 – Tela de abertura	26
Figura 8 – Tela Cadastramento	26
Figura 9 – Tela de navegação	26





LISTA DE TABELAS
Tabela 1 – Dicionário de dados	13
Tabela 2 – Funções dos participantes	18
Tabela 3 – Dicionário de dados	20
Tabela 4 – Dicionário de dados	25
Tabela 5 – Funções dos participantes novos	26
Y


LISTA DE SIGLAS
ABNT – Associação Brasileira de Normas Técnicas
PMB – Prefeitura Municipal de Barueri


SUMÁRI
1	INTRODUÇÃO	12
2	SISTEMA WEB DINÂMICO (ASP.Net)	13
2.1	Gerenciamento de Projeto	13
2.1.1	Termo de Abertura do Projeto (TAP)	13
2.1.2	Cronograma	13
2.2	Escopo	13
2.2.1	Objetivo do Documento	13
2.3	Descrição do Ambiente	14
2.3.1	Descrição do Processo / Problema	14
2.3.2	Descrição do Ambiente / Infraestrutura	14
2.3.3	Metas e Objetivos do Sistema	14
2.3.4	Sistemas atualmente em uso.	14
2.3.5	Escopo do Sistema	14
2.3.6	Funções do Sistema	14
2.3.7	DFD – Diagrama de Fluxo de Dados	14
2.3.8	DFD Nível 0 - Diagrama de Contexto	15
2.3.9	DFD Nível 1	15
2.4	Dados do Sistema	16
2.4.1	Dados Armazenados	16
2.4.2	Dicionário de Termo de Dados	16
2.4.3	Diagrama de Entidade e Relacionamento (DER)	16
2.4.4	Script de criação do Banco de Dados (SQL)	16
2.5	UML	17
2.5.1	Diagrama de Caso de Uso	17
2.5.2	Caso de Uso	17
2.5.3	Diagrama de Classes	17
2.5.4	Representação das Classes	17
2.6	Interface	19
2.6.1	Telas e Navegação	19
3	SISTEMA PARA DISPOSITIVOS MÓVEIS (Android)	20
3.1	Escopo Geral do Sistema	20

3.1.2	Funções do Sistema	20
3.2	Dados do Sistema	21
3.2.1	Dados Armazenados	21
3.3	Telas	22
3.3.1	Navegação das Telas	22
4	CONCLUSÃO	23
Y
    1 INTRODUÇÃO

Nosso gerenciador de projetos tem como objetivo assistir o armazenamento de dados armazenando-os em um banco digital, tornando assim mais ágil a atribuição e processamento das notas e facilitando a identificação de grupos.
 
    2 SISTEMA WEB DINÂMICO (ASP.Net)

Neste espaço do corpo do relatório, deverá constar o desenvolvimento do estudo da modalidade e do tema de seu trabalho ou projeto. 
Exemplo de inserção de tabela.
Nome
Função
Jullia Souza Avelar
Programador
Luís Felipe Santana de Almeida e Silva
Programador
Maria Isabela da Silva Matos Bento
Programador
Paulo Victor Bertanha
DBA

Tabela 1 – Funções dos participantes

        2.1 Gerenciamento de Projeto
            2.1.1 Termo de Abertura do Projeto (TAP)



TERMO DE ABERTURA

DO PROJETO



Projetos I

Edineia Almeida

INF3BM


    • GEPETO
    • Gerenciador de Projetos TCC























Barueri, 2020

Com o objetivo de facilitar o desenvolvimento do Trabalho de Conclusão de Curso (TCC) no que se refere às normas de formatação e ao direcionamento do TCC, o grupo de professores junto com a coordenação do curso disponibiliza neste documento algumas informações sobre o desenvolvimento e acompanhamento do projeto.
Todos os alunos do curso Técnico de Informática contemplam os componentes relacionados ao Trabalho de Conclusão de Curso (TCC) como uma atividade que permite ao aluno articular os componentes curriculares, a partir das experiências vivenciadas nos estudos teóricos e práticos, tanto na escola técnica quanto em suas experiências cotidianas e nas organizações.
Na seção V do Regimento Escolar Comum faz uma abordagem da prática profissional onde temos:
96 – A prática profissional é uma exigência para a conclusão de Educação Profissional Técnico de Nível Médio, sendo obrigatório à realização do Trabalho de Conclusão de Curso – TCC.
97º, § 1º do Regimento escolar comum da FIEB o Trabalho de Conclusão de Curso – TCC, em todas as habilitações obrigatoriamente o TCC compreende em projeto de pesquisa que, com foco num determinado problema e objeto de análise, visam à elaboração, execução e produção individual de uma monografia.
98 – Caso o aluno não conclua o trabalho de conclusão de curso – TCC, será considerado retido.
1 - Entregáveis para 2ª séries

Para cada etapa do processo será avaliado conforme o cronograma definido previamente junto com a turma, porém deve seguir o seguinte roteiro:
1.1- Primeiro Trimestre
Deve ser entregue a definição dos grupos de TCC, os temas e as regras de negócio fechando assim o ciclo de preparação do TCC.
1.2 - Segundo Trimestre 
Dever ser entregue a modelagem, os scripts do banco do banco de dados e os diagramas do sistema.
1.3 - Terceiro Trimestre 
Dever ser entregue, um protótipo do sistema web com critérios definidos pelos professores especialistas. 


    • Introdução
	
O sistema escolhido foi um gerenciador de projetos TCC, o GEPETO. Serão realizadas uma aplicação mobile e uma aplicação web. O projeto será separado e realizado em etapas, mantendo sempre o contato entre si.

    • 
    • Responsáveis pelo projeto

Nome do Sistema
Nome de Referência do Sistema
Turma 
INF3BM
Nº
RM
Nome
Função/Papel
   15
64223
Jullia Souza de Avelar
Web Dev.
   24
64125
Luís Felipe Santana de Almeida e Silva
Mobile Dev.
   25
64225
Maria Isabela da Silva Matos Bento
Web Dev.
   29
64244
Paulo Victor Bertanha
GP/ DBA


    • Justificativa do Projeto

          O tema foi escolhido devido a uma demanda dos professores das matérias técnicas de informática, para que haja um sistema que avalie e mantenha registros da avaliação do TCC. O trabalho está sendo desenvolvido por obrigatoriedade de TCC, exigido para conclusão de curso por todos os nossos professores.

    • Cenário Atual
    •           Atualmente, a avaliação é feita de forma individual por cada professor de forma não formal, o que não permite a geração de um documento oficial. Isso acarreta em problemas quando um aluno é reprovado pelo TCC e entra com recurso, pois não há um documento demonstrando os motivos pelo qual o projeto não foi aprovado pela banca. 
    • Descrição dos problemas

O problema
Perda de informações/anexos
Afeta
Avaliação/Reavaliação caso necessário
Cujo impacto é
Possível perda de nota
Uma boa solução seria
Armazenar os dados em um banco digital, gerando um tipo de histórico para cada grupo

O problema
Demora no processamento de notas
Afeta
O tempo para gerar as notas
Cujo impacto é
Possibilidade de atraso para gerar informações importantes
Uma boa solução seria
O projeto tornaria a atribuição e o processamento de notas mais ágil 

O problema
Confusão com grupos
Afeta
Troca de informações
Cujo impacto é
Atraso/erro no desenvolvimento do projeto
Uma boa solução seria
Aplicação deixaria as equipes visivelmente mais fáceis de identificar


    • Escopo do Projeto
MOBILE:
    •   O aplicativo mobile terá a função da avaliação propriamente dita. Será possível escolher a sala e o grupo em questão, tendo diferentes critérios para a atribuição de nota e uma área dedicada para observações do professor. Esses critérios serão escolhidos previamente na aplicação web.
  Ao abrir determinada sala e grupo, aparecerão informações, como: Tema, integrantes, descrição dos projetos e descrição do cliente.
  Será necessário um login e senha para a identificação do professor.

WEB:
    •   A aplicação terá como objetivo principal facilitar a organização de grupo, além de registrar os critérios de avalição e suas descrições.
  Os grupos serão organizados em ordem hierárquica (salas, grupos, alunos), sendo possível a realização de um objeto de menor escala na hierarquia dentro do objeto imediatamente acima do que está sendo criado.
  Somente o usuário com a atribuição de “Coordenador”, poderá definir quais serão critérios para a avaliação, que são escolhidos por meio de uma reunião ao início do ano com todos os professores, além de ter o controle dos demais usuários no sistema.
   Ao final do ano, a aplicação também facilitará a visualização das notas e do resultado final.



    • Descrição das fases/ Duração estimada

    • Protótipo BD: Paulo (3 semanas) - Concluído


    • Discussão Mobile: Grupo (3 semanas) - Concluído


    • Mobile: Luís (12 semanas) - Em andamento


    • Discussão Web/Desktop: Grupo (2 semanas) - Concluído


    • Telas Web/Desktop: Jullia (12 semanas) - Em andamento


    • Banco de dados: Paulo – Em andamento


    • Desenvolvimento da documentação: Maria (eterno) - Em andamento



    • Restrições
   Falta de comprometimento por parte dos integrantes do grupo, mudanças no calendário escolar, ausência de determinados conhecimentos por parte da equipe, que serão buscados ao longo do desenvolvimento do projeto

    • Riscos
   Poderá ocorrer atraso nas datas estabelecidas pelo grupo para entrega de protótipos do projeto, entrega de material incompleto ou com falhas no funcionamento.

    • Protótipo do Sistema
   Nosso sistema irá informatizar a avaliação de TCC, tendo como objetivo facilitar a atribuição de notas e o armazenamento dos conteúdos de cada grupo. A análise é realizada da mesma maneira a anos, sendo assim, a criação desse projeto vem com o intuito de inovar e facilitar, trazendo mais agilidade e praticidade para o cliente.



            2.1.2 Cronograma

    • Protótipo BD: Paulo (3 semanas) - Concluído


    • Discussão Mobile: Grupo (3 semanas) - Concluído


    • Mobile: Luís (12 semanas) - Em andamento


    • Discussão Web/Desktop: Grupo (2 semanas) - Concluído


    • Telas Web/Desktop: Jullia (12 semanas) - Em andamento


    • Banco de dados: Paulo – Em andamento


    • Desenvolvimento da documentação: Maria (eterno) - Em andamento


        2.2 Escopo
            2.2.1 Objetivo do Documento
                2.2.1.1 Para o Cliente
Manter o cliente informado a respeito das alterações realizadas durante o desenvolvimento do projeto.
                2.2.1.2 Para o Projetista
Sintetizar as informações do projeto em um único documento. 
        2.3 Descrição do Ambiente
            2.3.1 Descrição do Processo / Problema
Os processos vão desde armazenar diferentes arquivos, até gerar relatórios e notas baseados neles e nas apresentações que acontecem. Atualmente, pode-se considerar como problemas o local de armazenamento de arquivos, a quantidade de alunos, grupos e salas que pode gerar confusões no momento da troca de informações entre professores e alunos e atribuição de notas, além da sobrecarga que acontece na rede nas épocas de avaliação.
            2.3.2 Descrição do Ambiente / Infraestrutura
A implementação do sistema acontecerá para mudar a estrutura do ambiente, que atualmente é consideravelmente funcional, mas que conta com a junção de diferentes plataformas para acontecer.  Implementar o sistema, de certa forma, unificaria todas as funções esperadas e necessárias em uma única aplicação.
            2.3.3 Metas e Objetivos do Sistema
O sistema tem como objetivo facilitar o armazenamento de dados referente aos projetos e grupos, assim como a realização do relatório ao final de cada um, além de tornar mais rápida a atribuição e processamento das notas, gerando um resultado final mais rapidamente.
            2.3.4 Sistemas atualmente em uso.
O sistema atual, consiste no armazenamento de documentos controlado por professores responsáveis pela avaliação dos trabalhos, e que mais tarde armazenam informações de análises em planilhas além de usar dados armazenados anteriormente para a formação de um documento a respeito do grupo/projeto avaliado.
            2.3.5 Escopo do Sistema
       
         A aplicação terá como objetivo principal facilitar a organização de grupo, além de registrar os critérios de avalição e suas descrições. 
       O aplicativo mobile terá a função da avaliação propriamente dita. Será possível escolher a sala e o grupo em questão, tendo diferentes critérios para a atribuição de nota e uma área dedicada para observações do professor.
            2.3.6 Funções do Sistema
O sistema terá como principal função facilitar o gerenciamento das atividades relacionadas aos TCC’s no decorrer do ano organizando de forma mais dinâmica dados relacionados aos grupos existentes, além de tornar mais evidente as exigências em cada parte do projeto e facilitar a atribuição de notas no final de cada avaliação.
            2.3.7 DFD – Diagrama de Fluxo de Dados
Desenhar o diagrama de fluxo de dados. O DFD que pode ser usado para representar um sistema ou software em qualquer nível de abstração. De fato, os DFDs podem ser divididos em partições de acordo com níveis que representem um crescente detalhamento funcional e do fluxo de informação. O nível 0 do DFD, também chamado modelo fundamental do sistema ou modelo de contexto, representa o elemento software global como uma única bolha e dados de entrada e a saída indicados por setas que chegam e saem, respectivamente.



            2.3.8 DFD Nível 0 - Diagrama de Contexto

            2.3.9 DFD Nível 1


Dados do Sistema

    3 Dados Armazenados
Descrever as informações a serem controladas pelo sistema, numa visão não técnica, ou seja, de maneira que o cliente possa entender e validar.
    4 Dicionário de Termo de Dados















 





Tabela 2 – Dicionário de dados

    5 Diagrama de Entidade e Relacionamento (DER)


    6 Script de criação do Banco de Dados (SQL)
Explicar que está no “Anexo A”.
    7 UML
    8 Diagrama de Caso de Uso
Desenhar o diagrama de caso de uso, com seus respectivos atores e casos de uso. A modelagem de um diagrama use-case(Diagrama de caso de uso) é uma técnica usada para descrever e definir os requisitos funcionais de um sistema. Eles são escritos em termos de atores externos, use-cases e o sistema modelado.  .
    9 Caso de Uso
Descrever o caso de uso. Tem o objetivo de demonstrar qual a ação do ator e qual a resposta que o sistema.
    10 Diagrama de Classes
O diagrama de classes demonstra a estrutura estática das classes de um sistema onde estas representam as “coisas" que são gerenciadas pela aplicação modelada. Um sistema normalmente possui alguns diagramas de classes, já que não são todas as classes que estão inseridas em um único diagrama e uma certa classe pode participar de vários diagramas de classes.
    11 Representação das Classes
Descrever o Nome, Atributos e os Métodos das principais classes. Em UML as classes são representadas por um retângulo dividido em três compartimentos: o compartimento de nome, que conterá apenas o nome da classe modelada, o de atributos, que possuirá a relação de atributos que a classe possui em sua estrutura interna, e o compartimento de operações, que serão os métodos de manipulação de dados e de comunicação de uma classe com outras do sistema











Figura 1 – Classe Nomedaclasse

    12 Interface
    13 Telas e Navegação
Inserir neste ponto as Telas do Sistema, informando a funcionalidade de cada uma delas e como será realizado o link entre as telas (Navegação).



Figura 2 – Tela de abertura



Figura 3 – Tela Cadastramento



Figura 4 – Tela de navegação

    14 SISTEMA PARA DISPOSITIVOS MÓVEIS (Android)

        14.1 Escopo Geral do Sistema

            14.1.1 Escopo do Sistema
Descrever detalhadamente o escopo abrangido pelo sistema.

            14.1.2 Funções do Sistema
Descrever quais serão as principais e mais relevantes funções do sistema. 

        14.2 Dados do Sistema

            14.2.1 Dados Armazenados
Descrever detalhadamente o Nome do Banco, ID, Nome e Descrição de cada um deles. Tem a funcionalidade de auxiliar o responsável pelo banco de dados a construir e implementar o mesmo, bem como auxiliar o desenvolvedor a entender quais campos o mesmo deve ou está manipulando.

NOME DO ATRIBUTO	TIPO DO ATRIBUTO	DESCRIÇÃO DO ATRIBUTO	
NOME CAMPO	TIPO, AUTO NUM., PK	Descrição do Campo.
NOME CAMPO	TIPO, FK	Descrição do Campo.
				
Tabela 3 – Dicionário de dados
        14.3 Telas

            14.3.1 Navegação das Telas
Capturar as telas e realizar um diagrama que forneça ao usuário, as telas e opções de navegação do sistema. Seria o equivalente a um “Mapa do Site”, que a maiorias dos web sites contem.


Figura 5 – Tela de abertura



Figura 6 – Tela Cadastramento



Figura 7 – Tela de navegação

Nome
Função
Jose Antonio
Programador
Viviane Lima
Programadora
Tabela 4 – Funções dos participantes novos



    15 CONCLUSÃO

Síntese final do trabalho, a conclusão constitui-se de uma resposta à hipótese enunciada na introdução. O autor manifestará seu ponto de vista sobre os resultados obtidos e sobre o alcance dos mesmos. Não se permite a inclusão de dados novos nesse capítulo


REFERÊNCIAS


OLIVEIRA, Pedro Carlos. Sistemas Financeiros. São Paulo: Alínea, 2000.

CHIAVO, Adalberto. Gestão de Recursos.  São Paulo: Érica, 1999. 

IBGE. Pesquisa Mensal de Emprego. Disponível em http://ibge.gov.br. Acesso em 26 de maio de 2006.



APÊNDICE A
FICHA CADASTRAL



INSTITUTO TÉCNICO DE BARUERI
BRASÍLIO FLORES DE AZEVEDO
CURSO TÉCNICO EM INFORMÁTICA

Trabalho de conclusão de curso realizado no Instituto de Tecnologia do Instituto Técnico de Barueri Brasílio Flores de Azevedo.

FICHA CADASTRAL

Nome:

RM

Turma / ano-semestre

Data Nascimento

Endereço:

Bairro:

Cidade/UF

Telefone:

E-mail:

Profissão:






ANEXO A
MIDIA COM CÓDIGO FONTE
















Colar o envelope aqui
Com o CD ou DVD












INSTITUTO TÉCNICO DE BARUERI
BRASÍLIO FLORES DE AZEVEDO


Biblioteca Digital – Termo de Autorização


Trabalho de Conclusão de Curso
Curso Técnico em Informática


Nome do Aluno: _________________________________________________
RM.: ____________ Rg.: __________________________________________
Turma: ___________________


Título do Trabalho: _______________________________________________


Autorizo a FIEB – Fundação Instituto de Educação de Barueri, Mantenedora do Instituto Técnico de Barueri Brasílio Flores de Azevedo, estabelecido à Av. Grupo Bandeirante, 138, Jd. Belval, na cidade de Barueri, Estado de São Paulo, inscrita no CNPJ nº 65.700.239/0001-10, a disponibilizar para uso educacional e acadêmico, por prazo indeterminado, gratuitamente e sem o pagamento de qualquer contraprestação, o texto integral da obra supramencionada e o código fonte dos programas, scripts de bancos de dados, layouts de telas referentes aos sistemas desenvolvidos, de minha autoria, em sua página eletrônica mantida na Internet, Biblioteca e Intranet localizada em sua rede local, a título de divulgação da produção científica, podendo a obra ser lida e/ou impressa por todos, a partir desta data.
	
Barueri, SP ____ / ____ / ______

       _____________________________ 
                                                               Assinatura do (a) aluno (a)
