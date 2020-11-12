USE master
GO
USE GEPETO

/*-------------SP_INSERTS-------------*/
GO
-- USER --
EXEC SP_INSERT_USER '854950', 'SAIU ESCOLA', 'SENHA123', 4;
EXEC SP_INSERT_USER '000000', 'COORDENAÇÃO', '000000x', 1;
EXEC SP_INSERT_USER '123456', 'MARCELLO LALLO', 'SENHA123', 2;
EXEC SP_INSERT_USER '654321', 'GUSMÃO', '654321x', 3;
EXEC SP_INSERT_USER '123321', 'LEANDRO CRUZ', '123321x', 4;
EXEC SP_INSERT_USER '222222', 'RODRIGO LUIZ MENEZES', '222222x', 4;
EXEC SP_INSERT_USER '333333', 'SANDRA MULLOCK DA SILVA', '333333x', 4;
EXEC SP_INSERT_USER '444444', 'EDNÉIA TORRES DE AZEVEDO', '444444x', 4;
EXEC SP_INSERT_USER '555555', 'JACK CIANO', '555555x', 4;
EXEC SP_INSERT_USER '666666', 'ADRIANO P. MÓVEL', '666666x', 4;
EXEC SP_INSERT_USER '777777', 'ELIANA ALMEIDA SILVA', '777777x', 4;

GO
/*---SP_INSERT_CLASSROOM---*/
EXEC SP_INSERT_CLASSROOM 9;
GO
/*-----SP_INSERT_GROUP-----*/
EXEC SP_INSERT_GROUP 'CLÍNICA ODONTOLÓGICA', 'Clínica especializada em extrações', 1, '654321';
EXEC SP_INSERT_GROUP 'BRECHÓ', 'Loja com preço mínimo, somente roupas doadas', 1, '654321';
EXEC SP_INSERT_GROUP 'LOJA DE SUPLEMENTOS', 'Suplementos totalmente importados', 1, '654321';
EXEC SP_INSERT_GROUP 'SECRETARIA DE ESPORTES', 'Trabalha apenas com Futebol e Volei em Barueri', 1, '654321';
EXEC SP_INSERT_GROUP 'GREM SISTEMA INFORMATIVO ENTRE ALUNO E ESCOLA', 'Somente para rede FIEB', 1, '654321';
EXEC SP_INSERT_GROUP 'GEEK', 'Artigos GEEK em geral', 1, '654321';
EXEC SP_INSERT_GROUP 'ACADEMIA', 'Somente treino, sem venda de produtos', 1, '654321';
EXEC SP_INSERT_GROUP 'BILHETERIA de Teatro', 'Venda somente de ingresses para o Teatro', 1, '654321';
GO
EXEC SP_INSERT_GROUP 'GERENCIADOR DE PROJETOS TCC (GPT)', 'Desde adição de salas e grupos, até entrega das notas.', 2, '654321';
EXEC SP_INSERT_GROUP 'LOJA DE LOCAÇÕES DE ROUPAS PARA CERIMONIAIS', 'Somente locação', 2, '654321';
EXEC SP_INSERT_GROUP 'BARBEARIA', 'Somente serviços, sem produtos', 2, '654321';
EXEC SP_INSERT_GROUP 'CHURRASCARIA', 'Encomendas, sem comer no local', 2, '654321';
EXEC SP_INSERT_GROUP 'DISTRIBUIDORA DE GÁS', 'Sem compra de butijão, somente troca', 2, '654321';
EXEC SP_INSERT_GROUP 'ESCOLA DE MÚSICA', 'Aulas de canto e violão apenas', 2, '654321';
EXEC SP_INSERT_GROUP 'ASSISTÊNCIA TÉCNICA DE CELULAR', 'Sem entregas, levar e pegar no local', 2, '654321';
EXEC SP_INSERT_GROUP 'CASA DE SHOW', 'Casa noturna apenas, sistema para controle de entrada e saída', 2, '654321';
GO
EXEC SP_INSERT_GROUP 'AGÊNCIA DE INTERCÂMBIO', 'Especialização em Curso de Idiomas', 3, '654321';
EXEC SP_INSERT_GROUP 'FREELANCER DE TI', 'Sem transação de dinheiro, apenas postagem de trabalhos', 3, '654321';
EXEC SP_INSERT_GROUP 'SISTEMA DE CAFETERIA', 'Somente consumo em loja, sem encomendas. Cafeteria pequena', 3, '654321';
EXEC SP_INSERT_GROUP 'REDE SOCIAL JORNALÍSTICA', 'Intuito de disceminar informação através de uma nova rede social', 3, '654321';
EXEC SP_INSERT_GROUP 'GERENCIADOR E LOCALIZADOR DE ESTACIONAMENTO', 'Estacionamente para os mais diversos tipos de veículos, carros, motos e afins', 2, '654321';
EXEC SP_INSERT_GROUP 'ESCOLA PREPARATÓRIA DE FUTEBOL', 'Sistema gerenciará a entra e saída do clube, assim como pagamentos', 3, '654321';
EXEC SP_INSERT_GROUP 'LOJA DE HARDWARE', 'Venda de peças soltas para computador, sem máquinas montadas', 3, '654321';
GO
EXEC SP_INSERT_GROUP 'OUTLET DE ROUPAS ONLINE', 'Encomendas para São Paulo e região, o sistema irá administrar os pedidos', 4, '654321';
EXEC SP_INSERT_GROUP 'SISTEMA GERENCIADOR DE LIVRARIA', 'O sistema cuidará do pedidos de livros digitais e físicos', 4, '654321';
EXEC SP_INSERT_GROUP 'GERENCIAMENTO DE MARMITEX', 'Gerenciador de pedidos e entregas de marmitex', 4, '654321';
EXEC SP_INSERT_GROUP 'FARMÁCIA', 'O sistema armazenará os pedidos dos clientes', 4, '654321';
EXEC SP_INSERT_GROUP 'HORTIFRUTI ONLINE', 'Venda de frutas e legumes, o sistema administrará encomendas', 4, '654321';
EXEC SP_INSERT_GROUP 'CAFETERIA', 'O sistema tomará conta dos pedidos', 4, '654321';
GO
EXEC SP_INSERT_GROUP 'REDE DE PADARIAS', 'Sistema gerenciador de estoque e caixa de padarias franquiadas', 5, '654321';
EXEC SP_INSERT_GROUP 'FLORICULTURA', 'Sistema portátil para carrinhos de vendas de flores, sementes, vasos e buquês', 5, '654321';
EXEC SP_INSERT_GROUP 'CLUBE DE FÉRIAS', 'Agência de viagens escolares, planeja viagens para alunos do Fundamental 2 e Médio', 5, '654321';
EXEC SP_INSERT_GROUP 'PIZZARIA', 'Pizzaria: Sistema de comunicação do Restaurante, Food Truck e Delivery', 5, '654321';
EXEC SP_INSERT_GROUP 'OFICINA MECÂNICA', 'Sistema comparador de preços de peças de veículos para aquisição', 5, '654321';
EXEC SP_INSERT_GROUP 'SALÃO DE CABELEIREIRO', 'Agenda e controlador de caixa do salão', 5, '654321';
EXEC SP_INSERT_GROUP 'SKATESHOP', 'Sitema gerenciador de Loja de Skates e acessórios ', 5, '654321';
GO
EXEC SP_INSERT_GROUP 'ESCOLA DE CURSOS PROFISSIONALIZANTES', 'Gerenciador de cursos e matrículas de uma escola técnica particular', 6, '654321';
EXEC SP_INSERT_GROUP 'HOTEL PARA CACHORROS', 'Agenda, estoque de ração e controle de vagas', 6, '654321';
EXEC SP_INSERT_GROUP 'STREAMING DE FILMES', 'Serviço de streaming/download de filmes WEOC (Watch Even Out of Connection)', 6, '654321';
EXEC SP_INSERT_GROUP 'LOJA DE JOGOS STAR GAME', 'Sistema gerenciador de estoque e caixa da loja', 6, '654321';
EXEC SP_INSERT_GROUP 'BARBEARIA', 'Agenda e controlador de caixa da barbearia', 6, '654321';
EXEC SP_INSERT_GROUP 'CONCESSIONÁRIA', 'ALECIM', 6, '654321';

/*SP_INSERT_BIG_CRITERION*/
EXEC SP_INSERT_BIG_CRITERION
GO
/*SP_INSERT_MEDIUM_CRITERION*/
EXEC SP_INSERT_MEDIUM_CRITERION 1, 'MOBILE', '123456', 'Um aplicativo nativo Android', 2
EXEC SP_INSERT_MEDIUM_CRITERION 1, 'WEB', '123456', 'Desenvolvimento de uma aplicação Web', 4
EXEC SP_INSERT_MEDIUM_CRITERION 1, 'DESKTOP', '123456', 'Desenvolvimento UI Desktop com conexão INTRANET', 4
GO
/*SP_INSERT_MEDIUM_GRADE*/
-- CRUZ ATTEMPT 1
DECLARE 
@groups INT,
@ra CHAR(6),
@medium TINYINT,
@grade TINYINT
SET @groups = 1;
SET @ra = '123321';
WHILE(@GROUPS <= 42)
    BEGIN

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium = 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, @groups, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

   SET @groups += 1;
END

-- RODRIGO ATTEMPT 1
SET @groups = 1;
SET @ra = '222222';
WHILE(@GROUPS <= 42)
    BEGIN

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium = 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, @groups, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

   SET @groups += 1;
END

--SANDRA ATTEMPT 1
SET @groups = 1;
SET @ra = '333333';
WHILE(@GROUPS <= 42)
    BEGIN

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium = 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, @groups, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

   SET @groups += 1;
END


--EDNÉIA TORRES DE AZEVEDO
SET @groups = 1;
SET @ra = '444444';
WHILE(@GROUPS <= 42)
    BEGIN

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium = 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, @groups, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

   SET @groups += 1;
END

-- JACK CIANO
SET @groups = 1;
SET @ra = '555555';
WHILE(@GROUPS <= 42)
    BEGIN

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium = 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, @groups, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

   SET @groups += 1;
END
-- ADRIANO P. MÓVEL
SET @groups = 1;
SET @ra = '666666';
WHILE(@GROUPS <= 42)
    BEGIN

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium = 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, @groups, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

   SET @groups += 1;
END
-- ELIANA ALMEIDA SILVA
SET @groups = 1;
SET @ra = '777777';
WHILE(@GROUPS <= 42)
    BEGIN

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium = 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, @groups, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

    SELECT @grade = round(((11 - 6 -1) * rand() + 6), 0);
    SET @medium += 1;
    EXEC SP_INSERT_MEDIUM_GRADE @medium, @ra, 20, @grade, 1;

   SET @groups += 1;
END
select * from tb_medium_grade
GO
/*-------------SP_UPDATES-------------*/
/*-------SP_UPDATE_USER------*/
EXEC SP_UPDATE_USER '123456', 'MARCELLO LALLO', '123456x', 2
GO
EXEC SP_UPDATE_USER '854950', 'SAIU ESCOLA', 'EU TAMBÉM', 0
GO

SELECT *
FROM TB_USER;
SELECT *
FROM TB_CLASSROOM;
SELECT *
FROM TB_GROUP;
SELECT *
FROM TB_BIG_CRITERION;
SELECT *
FROM TB_MEDIUM_CRITERION;
SELECT *
FROM TB_MEDIUM_GRADE

