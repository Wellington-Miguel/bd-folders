CREATE DATABASE IF NOT EXISTS gestao_pesquisas;
USE gestao_pesquisas;

-- FINANCIADOR
CREATE TABLE TB_FINANCIADOR (
    ID_FINANCIADOR INT PRIMARY KEY AUTO_INCREMENT,
    VL_INVESTIMENTO DECIMAL(10,2) NOT NULL,
    NM_FINANCIADOR VARCHAR(60) NOT NULL,
    ST_REGISTRO_ATIVO CHAR(1) NOT NULL, -- S/N
    TP_FINANCIADOR VARCHAR(20) NOT NULL
);

-- LABORATORIO
CREATE TABLE TB_LABORATORIO (
    ID_LABORATORIO INT PRIMARY KEY AUTO_INCREMENT,
    NM_LABORATORIO VARCHAR(60) NOT NULL,
    DS_LOCALIZACAO VARCHAR(100),
    DS_AREA_ATUACAO VARCHAR(50) NOT NULL,
    ST_REGISTRO_ATIVO CHAR(1) NOT NULL
);

-- PESQUISADOR
CREATE TABLE TB_PESQUISADOR (
    ID_PESQUISADOR INT PRIMARY KEY AUTO_INCREMENT,
    NM_PESQUISADOR VARCHAR(60) NOT NULL,
    ST_REGISTRO_ATIVO CHAR(1) NOT NULL,
    DS_EMAIL VARCHAR(80) NOT NULL,
    ID_LABORATORIO INT,
    DS_TITULO_ACADEMICO VARCHAR(30) NOT NULL
);

-- EQUIPAMENTO
CREATE TABLE TB_EQUIPAMENTO (
    ID_EQUIPAMENTO INT PRIMARY KEY AUTO_INCREMENT,
    ID_LABORATORIO INT,
    ST_DISPONIBILIDADE VARCHAR(15) NOT NULL,
    NM_EQUIPAMENTO VARCHAR(60) NOT NULL,
    ST_REGISTRO_ATIVO CHAR(1) NOT NULL
);

-- EVENTO
CREATE TABLE TB_EVENTO (
    ID_EVENTO INT PRIMARY KEY AUTO_INCREMENT,
    NM_EVENTO VARCHAR(60) NOT NULL,
    TP_EVENTO VARCHAR(30) NOT NULL,
    DS_LOCAL VARCHAR(60) NOT NULL,
    DT_EVENTO DATE NOT NULL,
    QT_DURACAO_HORAS INT NOT NULL
);

-- PROJETO
CREATE TABLE TB_PROJETO (
    ID_PROJETO INT PRIMARY KEY AUTO_INCREMENT,
    NM_PROJETO VARCHAR(80) NOT NULL,
    DT_INICIO DATE NOT NULL,
    DT_FINAL DATE NOT NULL,
    ST_REGISTRO_ATIVO CHAR(1) NOT NULL,
    VL_ORCAMENTO DECIMAL(10,2) NOT NULL
);

-- BOLSA
CREATE TABLE TB_BOLSA (
    ID_BOLSA INT PRIMARY KEY AUTO_INCREMENT,
    NM_BOLSA VARCHAR(50) NOT NULL,
    VL_BOLSA DECIMAL(10,2) NOT NULL,
    TP_BOLSA VARCHAR(20) NOT NULL,
    ST_REGISTRO_ATIVO CHAR(1) NOT NULL
);

-- AVALIACAO
CREATE TABLE TB_AVALIACAO (
    ID_AVALIACAO INT PRIMARY KEY AUTO_INCREMENT,
    VL_NOTA INT NOT NULL,
    DS_FEEDBACK TEXT,
    DT_AVALIACAO DATE NOT NULL,
    NM_AUTOR VARCHAR(60) NOT NULL,
    ID_PESQUISADOR INT
);

-- CONTRATO (corrigido: inclui ID_PROJETO)
CREATE TABLE TB_CONTRATO (
    ID_CONTRATO INT PRIMARY KEY AUTO_INCREMENT,
    VL_CONTRATO DECIMAL(10,2) NOT NULL,
    DT_INICIAL DATE NOT NULL,
    DT_FINAL DATE NOT NULL,
    ST_REGISTRO_ATIVO CHAR(1) NOT NULL,
    TP_CONTRATO VARCHAR(30),
    ID_PESQUISADOR INT NOT NULL,
    ID_PROJETO INT NOT NULL
);

-- RELATORIO
CREATE TABLE TB_RELATORIO (
    ID_RELATORIO INT PRIMARY KEY AUTO_INCREMENT,
    DT_RELATORIO DATE NOT NULL,
    DS_DESCRITIVO TEXT,
    VL_NOTA INT NOT NULL,
    ID_PESQUISADOR INT NOT NULL
);

-- PUBLICACAO
CREATE TABLE TB_PUBLICACAO (
    ID_PUBLICACAO INT PRIMARY KEY AUTO_INCREMENT,
    NM_TITULO VARCHAR(80) NOT NULL,
    DT_PUBLICACAO DATE NOT NULL,
    NM_EDITORA VARCHAR(50) NOT NULL,
    DS_AREA_CONHECIMENTO VARCHAR(50) NOT NULL
);

-- BOLSISTA
CREATE TABLE TB_BOLSISTA (
    ID_BOLSISTA INT PRIMARY KEY AUTO_INCREMENT,
    NM_BOLSISTA VARCHAR(60) NOT NULL,
    DS_EMAIL VARCHAR(80) NOT NULL,
    DT_INICIO DATE NOT NULL,
    DT_FINAL DATE NOT NULL,
    ST_REGISTRO_ATIVO CHAR(1) NOT NULL,
    QT_CARGA_HORARIA INT,
    ID_BOLSA INT NOT NULL,
    ID_PROJETO INT NOT NULL
);

-- Tabelas associativas

-- TRABALHA (associativa)
CREATE TABLE TB_TRABALHA (
    ID_PESQUISADOR INT,
    ID_PROJETO INT,
    PRIMARY KEY (ID_PESQUISADOR, ID_PROJETO)
);

-- VINCULO (antes 'TEM') (associativa)
CREATE TABLE TB_VINCULO (
    ID_FINANCIADOR INT,
    ID_BOLSA INT,
    PRIMARY KEY (ID_FINANCIADOR, ID_BOLSA)
);

-- REGIDO (associativa)
CREATE TABLE TB_REGIDO (
    ID_CONTRATO INT,
    ID_FINANCIADOR INT,
    PRIMARY KEY (ID_CONTRATO, ID_FINANCIADOR)
);

-- ASSOCIADA (associativa)
CREATE TABLE TB_ASSOCIADA (
    ID_PESQUISADOR INT,
    ID_PUBLICACAO INT,
    PRIMARY KEY (ID_PESQUISADOR, ID_PUBLICACAO)
);

-- PARTICIPA (associativa)
CREATE TABLE TB_PARTICIPA (
    ID_PESQUISADOR INT,
    ID_EVENTO INT,
    PRIMARY KEY (ID_PESQUISADOR, ID_EVENTO)
);

-- FOREIGN KEYS
ALTER TABLE TB_EQUIPAMENTO ADD FOREIGN KEY (ID_LABORATORIO) REFERENCES TB_LABORATORIO (ID_LABORATORIO);
ALTER TABLE TB_PESQUISADOR ADD FOREIGN KEY (ID_LABORATORIO) REFERENCES TB_LABORATORIO (ID_LABORATORIO);
ALTER TABLE TB_AVALIACAO ADD FOREIGN KEY (ID_PESQUISADOR) REFERENCES TB_PESQUISADOR (ID_PESQUISADOR);
ALTER TABLE TB_CONTRATO ADD FOREIGN KEY (ID_PESQUISADOR) REFERENCES TB_PESQUISADOR (ID_PESQUISADOR);
ALTER TABLE TB_CONTRATO ADD FOREIGN KEY (ID_PROJETO) REFERENCES TB_PROJETO (ID_PROJETO);
ALTER TABLE TB_RELATORIO ADD FOREIGN KEY (ID_PESQUISADOR) REFERENCES TB_PESQUISADOR (ID_PESQUISADOR);
ALTER TABLE TB_BOLSISTA ADD FOREIGN KEY (ID_BOLSA) REFERENCES TB_BOLSA (ID_BOLSA);
ALTER TABLE TB_BOLSISTA ADD FOREIGN KEY (ID_PROJETO) REFERENCES TB_PROJETO (ID_PROJETO);
ALTER TABLE TB_TRABALHA ADD FOREIGN KEY (ID_PESQUISADOR) REFERENCES TB_PESQUISADOR (ID_PESQUISADOR);
ALTER TABLE TB_TRABALHA ADD FOREIGN KEY (ID_PROJETO) REFERENCES TB_PROJETO (ID_PROJETO);
ALTER TABLE TB_VINCULO ADD FOREIGN KEY (ID_FINANCIADOR) REFERENCES TB_FINANCIADOR (ID_FINANCIADOR);
ALTER TABLE TB_VINCULO ADD FOREIGN KEY (ID_BOLSA) REFERENCES TB_BOLSA (ID_BOLSA);
ALTER TABLE TB_REGIDO ADD FOREIGN KEY (ID_CONTRATO) REFERENCES TB_CONTRATO (ID_CONTRATO);
ALTER TABLE TB_REGIDO ADD FOREIGN KEY (ID_FINANCIADOR) REFERENCES TB_FINANCIADOR (ID_FINANCIADOR);
ALTER TABLE TB_ASSOCIADA ADD FOREIGN KEY (ID_PESQUISADOR) REFERENCES TB_PESQUISADOR (ID_PESQUISADOR);
ALTER TABLE TB_ASSOCIADA ADD FOREIGN KEY (ID_PUBLICACAO) REFERENCES TB_PUBLICACAO (ID_PUBLICACAO);
ALTER TABLE TB_PARTICIPA ADD FOREIGN KEY (ID_PESQUISADOR) REFERENCES TB_PESQUISADOR (ID_PESQUISADOR);
ALTER TABLE TB_PARTICIPA ADD FOREIGN KEY (ID_EVENTO) REFERENCES TB_EVENTO (ID_EVENTO);


# Organizar e salvar os dados em um arquivo .sql para fácil utilização

-- TABELA TB_FINANCIADOR
INSERT INTO TB_FINANCIADOR (VL_INVESTIMENTO, NM_FINANCIADOR, ST_REGISTRO_ATIVO, TP_FINANCIADOR)
VALUES
(85000.00, 'CNPq', 'S', 'Governo'),
(72000.00, 'FAPESB', 'S', 'Estadual'),
(15000.00, 'Empresa Alfa', 'S', 'Privado'),
(100000.00, 'Embaixada Canadá', 'N', 'Internacional'),
(60000.00, 'CAPES', 'S', 'Governo'),
(20000.00, 'Fundação Delta', 'S', 'Privado'),
(30000.00, 'FINEP', 'N', 'Governo'),
(40000.00, 'TechInvest', 'S', 'Privado'),
(95000.00, 'FAPESP', 'S', 'Estadual'),
(25000.00, 'Empresa Beta', 'N', 'Privado'),
(70000.00, 'Banco Mundial', 'S', 'Internacional'),
(55000.00, 'UNESCO', 'S', 'Internacional'),
(18000.00, 'Empresa Gama', 'S', 'Privado'),
(35000.00, 'FAPEMIG', 'S', 'Estadual'),
(67000.00, 'CNPq', 'N', 'Governo'),
(41000.00, 'Instituto Solar', 'S', 'Privado'),
(76000.00, 'FAPESB', 'S', 'Estadual'),
(16000.00, 'Empresa Zeta', 'N', 'Privado'),
(82000.00, 'Fundação Einstein', 'S', 'Privado'),
(98000.00, 'Agência Europeia', 'S', 'Internacional');

-- TABELA TB_BOLSA
INSERT INTO TB_BOLSA (NM_BOLSA, VL_BOLSA, TP_BOLSA, ST_REGISTRO_ATIVO)
VALUES
('Iniciação Científica', 800.00, 'IC', 'S'),
('Mestrado', 1500.00, 'PG', 'S'),
('Doutorado', 2200.00, 'PG', 'S'),
('Pós-Doutorado', 4200.00, 'PD', 'S'),
('Extensão Universitária', 600.00, 'EX', 'S'),
('Bolsa Técnica', 1200.00, 'BT', 'S'),
('Apoio Técnico', 1000.00, 'BT', 'N'),
('Iniciação Tecnológica', 850.00, 'IC', 'S'),
('Mestrado Profissional', 1600.00, 'PG', 'S'),
('Doutorado Sanduíche', 2500.00, 'PG', 'N'),
('Treinamento Técnico', 1100.00, 'BT', 'S'),
('Bolsa de Produtividade', 5000.00, 'PD', 'S'),
('Estágio de Pesquisa', 1300.00, 'EX', 'N'),
('Iniciação Júnior', 400.00, 'IC', 'S'),
('Bolsa Internacional', 7000.00, 'PD', 'N'),
('Mobilidade Acadêmica', 1800.00, 'EX', 'S'),
('Apoio à Docência', 950.00, 'BT', 'S'),
('Pesquisa Aplicada', 2100.00, 'PG', 'S'),
('Bolsa Sênior', 6000.00, 'PD', 'S'),
('Iniciação Voluntária', 0.00, 'IC', 'S');

-- TABELA TB_PROJETO
INSERT INTO TB_PROJETO (NM_PROJETO, DT_INICIO, DT_FINAL, ST_REGISTRO_ATIVO, VL_ORCAMENTO)
VALUES
('Projeto AI Saúde', '2024-01-10', '2025-12-31', 'S', 120000.00),
('Projeto Cidades Inteligentes', '2023-03-01', '2024-12-31', 'S', 80000.00),
('Projeto Energia Verde', '2022-05-15', '2024-11-30', 'S', 95000.00),
('Projeto Oceanos Limpos', '2023-07-01', '2025-06-30', 'S', 60000.00),
('Projeto AgroDigital', '2023-02-10', '2024-08-20', 'N', 45000.00),
('Projeto NeuroComp', '2024-03-15', '2026-03-15', 'S', 130000.00),
('Projeto Segurança Digital', '2022-01-01', '2023-12-31', 'N', 70000.00),
('Projeto Mobilidade Urbana', '2023-04-01', '2025-04-01', 'S', 110000.00),
('Projeto BioInovação', '2024-06-01', '2026-05-30', 'S', 92000.00),
('Projeto Educação 5.0', '2023-09-10', '2025-09-10', 'S', 100000.00),
('Projeto Saúde Rural', '2022-10-01', '2024-04-01', 'N', 30000.00),
('Projeto Clima Inteligente', '2023-01-20', '2025-01-20', 'S', 87000.00),
('Projeto Robótica Social', '2024-02-01', '2026-01-31', 'S', 105000.00),
('Projeto SmartAgro', '2023-05-10', '2024-11-15', 'N', 48000.00),
('Projeto Gêmeos Digitais', '2024-04-20', '2026-04-20', 'S', 115000.00),
('Projeto Turismo Sustentável', '2023-03-01', '2024-12-01', 'S', 54000.00),
('Projeto GovTech Brasil', '2024-07-01', '2026-06-30', 'S', 125000.00),
('Projeto Inclusão Digital', '2022-06-15', '2023-12-31', 'N', 40000.00),
('Projeto Blockchain Público', '2023-11-01', '2025-10-31', 'S', 98000.00),
('Projeto Dados Abertos', '2024-01-15', '2025-07-15', 'S', 89000.00);

-- TABELA TB_LABORATORIO
INSERT INTO TB_LABORATORIO (ID_LABORATORIO, NM_LABORATORIO, DS_LOCALIZACAO, DS_AREA_ATUACAO, ST_REGISTRO_ATIVO)
VALUES
(1, 'LAPESI', 'Prédio 1, Sala 101', 'Inteligência Artificial', 'S'),
(2, 'LAPETEC', 'Prédio 2, Sala 210', 'Tecnologia Assistiva', 'S'),
(3, 'LABDADOS', 'Prédio 3, Sala 305', 'Ciência de Dados', 'S'),
(4, 'LACS', 'Prédio 1, Sala 115', 'Segurança da Informação', 'S'),
(5, 'LABMOB', 'Prédio 2, Sala 202', 'Mobilidade Urbana', 'S'),
(6, 'LABAGRO', 'Anexo Rural, Sala 03', 'Agricultura Digital', 'S'),
(7, 'LARSA', 'Prédio 4, Sala 400', 'Robótica Social', 'S'),
(8, 'LABINOVA', 'Prédio 2, Sala 205', 'Inovação Tecnológica', 'N'),
(9, 'LABSUST', 'Prédio Verde, Sala 10', 'Sustentabilidade', 'S'),
(10, 'LABEDU', 'Bloco C, Sala 201', 'Tecnologias Educacionais', 'S'),
(11, 'LAVID', 'Prédio 5, Sala 505', 'Visão Computacional', 'S'),
(12, 'LABBIO', 'Prédio 6, Sala 102', 'Bioinformática', 'N'),
(13, 'LABSOFT', 'Bloco D, Sala 303', 'Engenharia de Software', 'S'),
(14, 'LABIOTEC', 'Prédio 7, Sala 701', 'Biotecnologia', 'S'),
(15, 'LABRES', 'Prédio 3, Sala 307', 'Recursos Hídricos', 'S'),
(16, 'LACOM', 'Prédio 2, Sala 201', 'Computação Móvel', 'N'),
(17, 'LAPSI', 'Prédio 1, Sala 109', 'Psicologia e Tecnologia', 'S'),
(18, 'LATEC', 'Prédio 4, Sala 420', 'Tecnologia Industrial', 'S'),
(19, 'LABMEC', 'Oficina Central', 'Mecatrônica', 'S'),
(20, 'LABGOV', 'Prédio Administrativo, Sala 12', 'Governança Digital', 'S');



-- TABELA TB_PESQUISADOR
INSERT INTO TB_PESQUISADOR (ID_PESQUISADOR, NM_PESQUISADOR, ST_REGISTRO_ATIVO, DS_EMAIL, ID_LABORATORIO, DS_TITULO_ACADEMICO)
VALUES
(1, 'Dra. Ana Silva', 'S', 'ana@ufba.br', 1, 'Doutorado'),
(2, 'Dr. Carlos Souza', 'S', 'carlos@ufba.br', 2, 'Doutorado'),
(3, 'Maria Lima', 'S', 'maria@ufba.br', 1, 'Mestrado'),
(4, 'Dr. João Oliveira', 'S', 'joao@ufba.br', 3, 'Doutorado'),
(5, 'Dra. Fernanda Rocha', 'S', 'fernanda@ufba.br', 4, 'Doutorado'),
(6, 'Pedro Matos', 'S', 'pedro@ufba.br', 5, 'Mestrado'),
(7, 'Cláudia Nunes', 'N', 'claudia@ufba.br', 6, 'Especialização'),
(8, 'Dr. Rafael Cunha', 'S', 'rafael@ufba.br', 7, 'Doutorado'),
(9, 'Luciana Costa', 'S', 'luciana@ufba.br', 8, 'Mestrado'),
(10, 'Dr. Marcos Vinícius', 'S', 'marcos@ufba.br', 9, 'Doutorado'),
(11, 'Tatiane Freitas', 'S', 'tatiane@ufba.br', 10, 'Mestrado'),
(12, 'Dr. Roberto Dias', 'N', 'roberto@ufba.br', 11, 'Doutorado'),
(13, 'Bruna Melo', 'S', 'bruna@ufba.br', 12, 'Graduação'),
(14, 'Dr. André Barbosa', 'S', 'andre@ufba.br', 13, 'Doutorado'),
(15, 'Camila Torres', 'S', 'camila@ufba.br', 14, 'Mestrado'),
(16, 'Dr. Daniel Rezende', 'S', 'daniel@ufba.br', 15, 'Doutorado'),
(17, 'Juliana Prado', 'S', 'juliana@ufba.br', 16, 'Mestrado'),
(18, 'Dr. Felipe Gomes', 'S', 'felipe@ufba.br', 17, 'Doutorado'),
(19, 'Vanessa Ribeiro', 'N', 'vanessa@ufba.br', 18, 'Graduação'),
(20, 'Dr. Igor Martins', 'S', 'igor@ufba.br', 19, 'Doutorado');



-- TABELA TB_EQUIPAMENTO
	INSERT INTO TB_EQUIPAMENTO (ID_LABORATORIO, ST_DISPONIBILIDADE, NM_EQUIPAMENTO, ST_REGISTRO_ATIVO)
	VALUES
	(1, 'Disponível', 'Servidor GPU NVIDIA', 'S'),
	(2, 'Em uso', 'Impressora 3D', 'S'),
	(3, 'Disponível', 'Cluster de Processamento', 'S'),
	(4, 'Em manutenção', 'Firewall UTM', 'S'),
	(5, 'Disponível', 'Simulador de Trânsito', 'S'),
	(6, 'Em uso', 'Drones Agrícolas', 'S'),
	(7, 'Disponível', 'Robô Interativo NAO', 'S'),
	(8, 'Em manutenção', 'Scanner Corporal 3D', 'S'),
	(9, 'Disponível', 'Painel Solar Experimental', 'S'),
	(10, 'Disponível', 'Lousa Digital Interativa', 'S'),
	(11, 'Em uso', 'Câmeras de Alta Resolução', 'S'),
	(12, 'Em manutenção', 'Microscópio de Fluorescência', 'S'),
	(13, 'Disponível', 'Servidores Dell PowerEdge', 'S'),
	(14, 'Disponível', 'Centrífuga de Bancada', 'S'),
	(15, 'Em uso', 'Sensor de Qualidade da Água', 'S'),
	(16, 'Disponível', 'Notebook para Testes Móveis', 'S'),
	(17, 'Disponível', 'Scanner de Impressões Digitais', 'S'),
	(18, 'Em manutenção', 'Fresadora CNC', 'S'),
	(19, 'Disponível', 'Braço Robótico Industrial', 'S'),
	(20, 'Em uso', 'Totem Interativo para E-gov', 'S');

-- TABELA TB_EVENTO
INSERT INTO TB_EVENTO (NM_EVENTO, TP_EVENTO, DS_LOCAL, DT_EVENTO, QT_DURACAO_HORAS)
VALUES
('Simpósio de IA', 'Simpósio', 'Auditório Central', '2024-08-20', 8),
('Workshop de Dados Abertos', 'Workshop', 'Online', '2024-09-15', 4),
('Congresso de Computação Aplicada', 'Congresso', 'Centro de Convenções', '2025-03-10', 16),
('Feira de Inovação Tecnológica', 'Feira', 'Pavilhão Tecnológico', '2025-04-05', 6),
('Hackathon Cidades Inteligentes', 'Hackathon', 'Prédio 5 - Sala 301', '2024-11-12', 12),
('Seminário de Cibersegurança', 'Seminário', 'Auditório do LACOM', '2025-01-22', 5),
('Workshop de Robótica Educacional', 'Workshop', 'Laboratório de Robótica', '2024-10-03', 3),
('Palestra: Ética em IA', 'Palestra', 'Auditório LAPESI', '2024-06-25', 2),
('Mesa Redonda: GovTechs no Brasil', 'Mesa Redonda', 'Online', '2025-02-17', 3),
('Oficina de Python para Ciência de Dados', 'Oficina', 'Sala 203 - Bloco C', '2024-09-01', 6),
('Seminário de Bioinformática', 'Seminário', 'Bloco E - Sala 110', '2025-03-19', 4),
('Congresso Nacional de Pesquisa', 'Congresso', 'Centro Acadêmico', '2024-10-20', 10),
('Encontro de Bolsistas de Iniciação', 'Encontro', 'Auditório Principal', '2025-05-05', 6),
('Palestra: LGPD e Pesquisa Científica', 'Palestra', 'Online', '2024-08-05', 2),
('Feira de Tecnologia Assistiva', 'Feira', 'Prédio 2 - Hall Principal', '2024-07-18', 7),
('Hackathon AgroTech', 'Hackathon', 'Laboratório LABAGRO', '2025-02-01', 14),
('Oficina: R para Análise de Dados', 'Oficina', 'Sala 210 - Bloco D', '2024-11-05', 5),
('Simpósio de Computação Verde', 'Simpósio', 'Auditório LABSUST', '2024-12-10', 8),
('Encontro de Grupos de Pesquisa', 'Encontro', 'Anfiteatro A', '2024-11-23', 6),
('Mesa Redonda: IA Generativa na Educação', 'Mesa Redonda', 'Sala 102 - Bloco B', '2025-01-10', 3);


-- TABELA TB_CONTRATO
INSERT INTO TB_CONTRATO (VL_CONTRATO, DT_INICIAL, DT_FINAL, ST_REGISTRO_ATIVO, TP_CONTRATO, ID_PESQUISADOR, ID_PROJETO)
VALUES
(30000.00, '2024-01-01', '2024-12-31', 'S', 'CLT', 1, 2),
(20000.00, '2024-03-01', '2025-02-28', 'S', 'Bolsista', 2, 3),
(25000.00, '2024-02-15', '2025-02-14', 'S', 'CLT', 3, 4),
(15000.00, '2024-05-01', '2025-04-30', 'S', 'Bolsista', 4, 5),
(28000.00, '2024-01-10', '2024-12-31', 'S', 'CLT', 5, 6),
(18000.00, '2024-06-01', '2025-05-31', 'S', 'Bolsista', 6, 7),
(27000.00, '2024-04-01', '2025-03-31', 'N', 'CLT', 7, 8),
(19000.00, '2024-07-01', '2025-06-30', 'S', 'Bolsista', 8, 9),
(30000.00, '2024-01-01', '2024-12-31', 'S', 'CLT', 9, 10),
(21000.00, '2024-03-15', '2025-03-14', 'S', 'Bolsista', 10, 11),
(26000.00, '2024-02-01', '2025-01-31', 'S', 'CLT', 11, 12),
(16000.00, '2024-05-20', '2025-05-19', 'N', 'Bolsista', 12, 13),
(28000.00, '2024-01-05', '2024-12-31', 'S', 'CLT', 13, 14),
(17000.00, '2024-06-10', '2025-06-09', 'S', 'Bolsista', 14, 15),
(29000.00, '2024-04-15', '2025-04-14', 'S', 'CLT', 15, 16),
(20000.00, '2024-07-01', '2025-06-30', 'S', 'Bolsista', 16, 17),
(31000.00, '2024-01-01', '2024-12-31', 'S', 'CLT', 17, 18),
(18000.00, '2024-03-01', '2025-02-28', 'S', 'Bolsista', 18, 19),
(27500.00, '2024-02-15', '2025-02-14', 'N', 'CLT', 19, 20),
(19000.00, '2024-05-01', '2025-04-30', 'S', 'Bolsista', 20, 1);


-- TABELA TB_RELATORIO
INSERT INTO TB_RELATORIO (DT_RELATORIO, DS_DESCRITIVO, VL_NOTA, ID_PESQUISADOR)
VALUES
('2024-06-01', 'Avanços no reconhecimento facial.', 9, 1),
('2024-07-15', 'Protótipos em acessibilidade digital.', 8, 2),
('2024-06-10', 'Progresso na análise de dados genéticos.', 10, 3),
('2024-06-20', 'Testes com sensores IoT.', 7, 4),
('2024-07-01', 'Estudo sobre algoritmos de otimização.', 9, 5),
('2024-07-05', 'Aplicação de IA em diagnósticos.', 10, 6),
('2024-07-10', 'Relatório de integração com sistema legado.', 8, 7),
('2024-07-15', 'Análise de desempenho de hardware.', 7, 8),
('2024-07-20', 'Desenvolvimento de aplicativo móvel.', 9, 9),
('2024-07-25', 'Progresso com análise preditiva.', 10, 10),
('2024-08-01', 'Estudo de caso em cidades inteligentes.', 8, 11),
('2024-08-05', 'Uso de drones em coleta de dados.', 9, 12),
('2024-08-10', 'Prototipagem rápida de sensores.', 7, 13),
('2024-08-15', 'Benchmark de algoritmos.', 10, 14),
('2024-08-20', 'Relatório de desempenho de redes.', 8, 15),
('2024-08-25', 'Análise estatística de resultados.', 9, 16),
('2024-09-01', 'Progresso na coleta de dados.', 8, 17),
('2024-09-05', 'Treinamento de modelos preditivos.', 9, 18),
('2024-09-10', 'Simulação de ambientes urbanos.', 7, 19),
('2024-09-15', 'Relatório de conclusão do semestre.', 10, 20);

-- TABELA TB_PUBLICACAO
INSERT INTO TB_PUBLICACAO (NM_TITULO, DT_PUBLICACAO, NM_EDITORA, DS_AREA_CONHECIMENTO)
VALUES
('Redes Neurais para Diagnóstico', '2023-11-20', 'Springer', 'IA na Saúde'),
('Acessibilidade Digital', '2024-02-10', 'Elsevier', 'Tecnologia Assistiva'),
('Machine Learning em Bioinformática', '2023-12-05', 'IEEE', 'Bioinformática'),
('Robótica Educacional no Ensino Médio', '2024-01-20', 'UFBA Editora', 'Educação'),
('Big Data em Saúde Pública', '2024-03-15', 'FIOCRUZ', 'Saúde Pública'),
('Computação Ubíqua na Indústria', '2024-04-01', 'ACM', 'Indústria 4.0'),
('Reconhecimento Facial Ético', '2024-05-10', 'Elsevier', 'Ética em IA'),
('Inteligência Computacional Aplicada', '2023-10-20', 'Springer', 'Computação'),
('Acessibilidade Web com WCAG', '2024-02-28', 'UFBA Editora', 'Acessibilidade'),
('Redes de Sensores sem Fio', '2024-03-25', 'IEEE', 'Redes'),
('Deep Learning para Imagens Médicas', '2024-05-05', 'Nature', 'Saúde'),
('Internet das Coisas e Cidades Inteligentes', '2024-06-10', 'Elsevier', 'IoT'),
('Linguagens de Programação para Iniciantes', '2024-06-15', 'PUC Press', 'Educação'),
('Realidade Aumentada na Educação', '2024-07-01', 'Springer', 'Tecnologia Educacional'),
('Privacidade em Sistemas Inteligentes', '2024-07-05', 'Elsevier', 'Segurança da Informação'),
('Simulação de Tráfego Urbano', '2024-07-15', 'IEEE', 'Mobilidade Urbana'),
('Modelos Preditivos para Clima', '2024-07-20', 'Nature', 'Climatologia'),
('Chatbots em Serviços Públicos', '2024-08-01', 'UFBA Editora', 'IA'),
('Análise de Dados com Python', '2024-08-10', 'Reilly', 'Ciência de Dados'),
('Governança de Dados Acadêmicos', '2024-08-15', 'Elsevier', 'Gestão de Dados');

-- TABELA TB_BOLSISTA
INSERT INTO TB_BOLSISTA (NM_BOLSISTA, DS_EMAIL, DT_INICIO, DT_FINAL, ST_REGISTRO_ATIVO, QT_CARGA_HORARIA, ID_BOLSA, ID_PROJETO)
VALUES
('João Oliveira', 'joao@ufba.br', '2024-02-01', '2024-12-31', 'S', 20, 1, 1),
('Paula Mendes', 'paula@ufba.br', '2024-01-15', '2024-11-30', 'S', 30, 2, 2),
('Lucas Lima', 'lucas@ufba.br', '2024-03-01', '2024-12-31', 'S', 1, 1, 1),
('Fernanda Costa', 'fernanda@ufba.br', '2024-03-10', '2024-12-31', 'S', 20, 2, 1),
('Rafael Nunes', 'rafael@ufba.br', '2024-04-01', '2024-12-31', 'S', 30, 3, 2),
('Carla Dias', 'carla@ufba.br', '2024-04-05', '2024-11-30', 'S', 20, 1, 1),
('Bruno Matos', 'bruno@ufba.br', '2024-04-10', '2024-12-20', 'S', 30, 2, 2),
('Aline Santos', 'aline@ufba.br', '2024-04-15', '2024-11-15', 'S', 20, 1, 1),
('Thiago Rocha', 'thiago@ufba.br', '2024-05-01', '2024-12-31', 'S', 20, 2, 2),
('Camila Almeida', 'camila@ufba.br', '2024-05-05', '2024-12-31', 'S', 30, 3, 2),
('Diego Ribeiro', 'diego@ufba.br', '2024-05-10', '2024-12-31', 'S', 20, 1, 1),
('Isabela Freitas', 'isabela@ufba.br', '2024-05-15', '2024-11-30', 'S', 30, 2, 2),
('Hugo Martins', 'hugo@ufba.br', '2024-05-20', '2024-12-31', 'S', 20, 1, 1),
('Juliana Castro', 'juliana@ufba.br', '2024-06-01', '2024-12-31', 'S', 30, 2, 2),
('Vitor Leal', 'vitor@ufba.br', '2024-06-10', '2024-12-31', 'S', 20, 1, 1),
('Beatriz Gomes', 'beatriz@ufba.br', '2024-06-15', '2024-12-31', 'S', 20, 3, 2),
('Marcelo Pinto', 'marcelo@ufba.br', '2024-06-20', '2024-12-31', 'S', 30, 1, 1),
('Renata Pires', 'renata@ufba.br', '2024-06-25', '2024-12-31', 'S', 20, 2, 2),
('Fábio Costa', 'fabio@ufba.br', '2024-07-01', '2024-12-31', 'S', 30, 3, 2),
('Tatiane Braga', 'tatiane@ufba.br', '2024-07-05', '2024-12-31', 'S', 20, 1, 1);



-- TABELA TB_AVALIACAO
INSERT INTO TB_AVALIACAO (VL_NOTA, DS_FEEDBACK, DT_AVALIACAO, NM_AUTOR, ID_PESQUISADOR)
VALUES
(10, 'Excelente progresso no projeto.', '2024-05-01', 'Prof. João Barreto', 1),
(8, 'Bom desenvolvimento.', '2024-05-10', 'Prof. Maria Freitas', 2),
(9, 'Análise bem conduzida.', '2024-05-15', 'Prof. Lucas Lima', 3),
(7, 'Necessita revisão técnica.', '2024-05-20', 'Prof. Ana Rocha', 4),
(10, 'Ótima apresentação de resultados.', '2024-05-25', 'Prof. Carlos Teixeira', 5),
(9, 'Trabalho consistente.', '2024-05-28', 'Prof. Beatriz Nunes', 6),
(8, 'Avanço satisfatório.', '2024-06-01', 'Prof. Diego Costa', 7),
(7, 'Recomenda-se mais testes.', '2024-06-05', 'Prof. Juliana Dias', 8),
(10, 'Trabalho inovador.', '2024-06-10', 'Prof. Ricardo Lopes', 9),
(8, 'Boa estruturação.', '2024-06-12', 'Prof. Carla Mota', 10),
(9, 'Execução técnica adequada.', '2024-06-15', 'Prof. Tiago Silva', 11),
(8, 'Resultados promissores.', '2024-06-18', 'Prof. Fernanda Lima', 12),
(7, 'Faltam testes de desempenho.', '2024-06-20', 'Prof. Paulo Gomes', 13),
(10, 'Excelente integração de dados.', '2024-06-25', 'Prof. Larissa Tavares', 14),
(9, 'Trabalho bem articulado.', '2024-06-28', 'Prof. Bruno Santos', 15),
(8, 'Cumpriu os objetivos.', '2024-07-01', 'Prof. Mariana Reis', 16),
(7, 'Necessita mais referências.', '2024-07-03', 'Prof. Hugo Fernandes', 17),
(9, 'Aproxima-se da solução esperada.', '2024-07-05', 'Prof. Tânia Cruz', 18),
(8, 'Apresentação clara e objetiva.', '2024-07-10', 'Prof. Rafael Leite', 19),
(10, 'Entrega excelente e dentro do prazo.', '2024-07-15', 'Prof. Letícia Maia', 20);

-- TABELA TB_TRABALHA (Pesquisador x Projeto)
INSERT INTO TB_TRABALHA (ID_PESQUISADOR, ID_PROJETO)
VALUES

(1, 1), (2, 2), (3, 3), (4, 4), (5, 14), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
(11, 11), (12, 12), (13, 13), (14, 15), (15, 15), (16, 16), (17, 17), (18, 18), (19, 19), (20, 20),
(1, 2), (3, 5), (5, 10), (7, 15);

-- TABELA TB_VINCULO (Financiador x Bolsa)
INSERT INTO TB_VINCULO (ID_FINANCIADOR, ID_BOLSA)
VALUES

(1, 1), (1, 2), (5, 1), (5, 5), (9, 4),(3, 6), (8, 11), (16, 6),(11, 15), (12, 15), (20, 15);

-- TABELA TB_REGIDO (Contrato x Financiador)
INSERT INTO TB_REGIDO (ID_CONTRATO, ID_FINANCIADOR)
VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15), (16, 16), (17, 17), (18, 18), (19, 19), (20, 20);

-- TABELA TB_ASSOCIADA (Pesquisador x Publicação)
INSERT INTO TB_ASSOCIADA (ID_PESQUISADOR, ID_PUBLICACAO)
VALUES

(1, 1), (3, 1), (1, 7),(2, 2), (2, 9),(4, 3), (14, 3),(11, 13), (17, 13),(20, 18);

-- TABELA TB_PARTICIPA (Pesquisador x Evento)
INSERT INTO TB_PARTICIPA (ID_PESQUISADOR, ID_EVENTO)
VALUES

(1, 1), (1, 8), (1, 20),(3, 2), (3, 10),(8, 7), (8, 12),(20, 9), (20, 20);


-- QUERIES INTERMEDIÁRIAS (3 tabelas, 2 funções)

-- 1. Gestão de Equipamentos (RE1, RE2)
SELECT 
    E.NM_EQUIPAMENTO, 
    L.NM_LABORATORIO,
    COUNT(E.ID_EQUIPAMENTO) OVER (PARTITION BY L.ID_LABORATORIO) AS TOTAL_EQUIPAMENTOS
FROM 
    TB_EQUIPAMENTO E
JOIN 
    TB_LABORATORIO L ON E.ID_LABORATORIO = L.ID_LABORATORIO
WHERE 
    E.ST_DISPONIBILIDADE = 'Disponível'
GROUP BY 
    E.ID_EQUIPAMENTO, L.ID_LABORATORIO;

-- 2. Eventos Científicos (RE3, RE4)
SELECT 
    P.NM_PESQUISADOR,
    COUNT(DISTINCT A.ID_PUBLICACAO) AS TOTAL_PUBLICACOES,
    COUNT(DISTINCT PA.ID_EVENTO) AS TOTAL_EVENTOS,
    RANK() OVER (ORDER BY COUNT(DISTINCT A.ID_PUBLICACAO) DESC) AS RANK_PUBLICACOES
FROM 
    TB_PESQUISADOR P
JOIN 
    TB_ASSOCIADA A ON P.ID_PESQUISADOR = A.ID_PESQUISADOR
JOIN 
    TB_PARTICIPA PA ON P.ID_PESQUISADOR = PA.ID_PESQUISADOR
GROUP BY 
    P.ID_PESQUISADOR;

-- 3. Avaliação de Pesquisadores (RE5, RE6)
SELECT 
    P.NM_PESQUISADOR,
    AVG(A.VL_NOTA) AS MEDIA_NOTA,
    GROUP_CONCAT(A.DS_FEEDBACK SEPARATOR '; ') AS FEEDBACKS  
FROM 
    TB_PESQUISADOR P
JOIN 
    TB_AVALIACAO A ON P.ID_PESQUISADOR = A.ID_PESQUISADOR
GROUP BY 
    P.ID_PESQUISADOR;

-- QUERIES AVANÇADAS (3 tabelas, 3 funções)

-- 4. Gestão de Equipamentos (RE1, RE2)
SELECT 
    E.NM_EQUIPAMENTO,
    L.NM_LABORATORIO,
    PR.NM_PROJETO,
    (SELECT COUNT(*) FROM TB_EQUIPAMENTO WHERE ID_LABORATORIO = L.ID_LABORATORIO) AS TOTAL_EQUIPAMENTOS_LAB
FROM 
    TB_EQUIPAMENTO E
JOIN 
    TB_LABORATORIO L ON E.ID_LABORATORIO = L.ID_LABORATORIO
JOIN 
    TB_TRABALHA T ON T.ID_PROJETO = (SELECT ID_PROJETO FROM TB_PROJETO WHERE ID_PROJETO = T.ID_PROJETO)
JOIN 
    TB_PROJETO PR ON T.ID_PROJETO = PR.ID_PROJETO
WHERE 
    E.ST_DISPONIBILIDADE = 'Em uso';

-- 5. Eventos Científicos (RE3, RE4)
SELECT 
    P.NM_PESQUISADOR,
    COUNT(A.ID_PUBLICACAO) AS PUBLICAÇÕES,
    (SELECT COUNT(ID_EVENTO) FROM TB_PARTICIPA WHERE ID_PESQUISADOR = P.ID_PESQUISADOR) AS EVENTOS,
    RANK() OVER (ORDER BY COUNT(A.ID_PUBLICACAO) DESC) AS RANK_GERAL
FROM 
    TB_PESQUISADOR P
JOIN 
    TB_ASSOCIADA A ON P.ID_PESQUISADOR = A.ID_PESQUISADOR
JOIN 
    TB_PUBLICACAO PB ON A.ID_PUBLICACAO = PB.ID_PUBLICACAO
GROUP BY 
    P.ID_PESQUISADOR;

-- 6. Avaliação de Pesquisadores (RE5, RE6)
SELECT 
    P.NM_PESQUISADOR,
    AVG(A.VL_NOTA) AS NOTA_INDIVIDUAL,
    (SELECT AVG(VL_NOTA) FROM TB_AVALIACAO) AS MEDIA_GERAL,
    CASE 
        WHEN AVG(A.VL_NOTA) > (SELECT AVG(VL_NOTA) FROM TB_AVALIACAO) THEN 'Acima da Média'
        ELSE 'Abaixo da Média'
    END AS STATUS
FROM 
    TB_PESQUISADOR P
JOIN 
    TB_AVALIACAO A ON P.ID_PESQUISADOR = A.ID_PESQUISADOR
GROUP BY 
    P.ID_PESQUISADOR;