create database ClimaAlerta;

use ClimaAlerta;

CREATE TABLE TipoEvento (
    idTipoEvento INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE Localizacao (
    idLocalizacao INT PRIMARY KEY,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    cidade VARCHAR(100),
    estado VARCHAR(2)
);

CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    senhaHash VARCHAR(255) NOT NULL
);

CREATE TABLE Evento (
    idEvento INT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    dataHora DATETIME,
    status VARCHAR(50),
    idTipoEvento INT,
    idLocalizacao INT,
    
    FOREIGN KEY (idTipoEvento) REFERENCES TipoEvento(idTipoEvento),
    FOREIGN KEY (idLocalizacao) REFERENCES Localizacao(idLocalizacao)
);

CREATE TABLE Relato (
    idRelato INT PRIMARY KEY,
    texto TEXT,
    dataHora DATETIME,
    idEvento INT,
    idUsuario INT,
    
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento),
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Alerta (
    idAlerta INT PRIMARY KEY,
    mensagem TEXT,
    dataHora DATETIME,
    nivel VARCHAR(20),
    idEvento INT,
    
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento)
);

CREATE TABLE HistoricoEvento (
    idHistorico INT PRIMARY KEY,
    idEvento INT,
    statusAnterior VARCHAR(50),
    statusNovo VARCHAR(50),
    dataAlteracao DATETIME,
    idUsuario INT,

    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento),
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

INSERT INTO TipoEvento (idTipoEvento, nome, descricao)
VALUES 
(1, 'Queimada', 'Incêndio de grandes proporções em áreas urbanas ou rurais.');

INSERT INTO Localizacao (idLocalizacao, latitude, longitude, cidade, estado)
VALUES 
(5, -23.305000, -45.965000, 'Jacareí', 'SP');

INSERT INTO Usuario (idUsuario, nome, email, senhaHash)
VALUES 
(2, 'Maria Oliveira', 'maria.oliveira@email.com', '2b6c7f64f76b09d0a7b9e...');

INSERT INTO Evento (idEvento, titulo, descricao, dataHora, status, idTipoEvento, idLocalizacao)
VALUES 
(1, 
'Queimada em área de preservação', 
'Fogo se alastrando na mata próxima à represa.', 
'2025-08-15 14:35:00', 
'Ativo', 
1, 
5);

INSERT INTO Relato (idRelato, texto, dataHora, idEvento, idUsuario)
VALUES 
(1, 
'Fumaça intensa e chamas visíveis a partir da rodovia.', 
'2025-08-15 15:10:00', 
1, 
2);

INSERT INTO Alerta (idAlerta, mensagem, dataHora, nivel, idEvento)
VALUES 
(1, 
'Evacuação imediata da área próxima à represa.', 
'2025-08-15 15:20:00', 
'Crítico', 
1);

INSERT INTO HistoricoEvento (idHistorico, idEvento, statusAnterior, statusNovo, dataAlteracao, idUsuario)
VALUES 
(1, 
1, 
'Ativo', 
'Em Monitoramento', 
'2025-08-15 16:00:00', 
2);

