/* E-NUTRI-LOGICO: */

CREATE TABLE Profissao (
    CodProfissao Integer PRIMARY KEY,
    Nome Varchar(15) NOT NULL,
    UNIQUE (CodProfissao, Nome)
);

CREATE TABLE GeneroBio (
    CodGenero Integer PRIMARY KEY,
    Nome Varchar(15) NOT NULL,
    UNIQUE (Nome, CodGenero)
);

CREATE TABLE EstadoCivil (
    CodEstadoCivil Integer PRIMARY KEY,
    Nome Varchar(15) NOT NULL,
    UNIQUE (CodEstadoCivil, Nome)
);

CREATE TABLE Celular (
    CodCelular Integer PRIMARY KEY,
    DDD Numeric(2) NOT NULL,
    Numero Numeric(9) NOT NULL,
    UNIQUE (CodCelular, Numero, DDD)
);

CREATE TABLE TelRes (
    CodTelRes Integer PRIMARY KEY,
    DDD Numeric(2) NOT NULL,
    Numero Numeric(8) NOT NULL,
    UNIQUE (CodTelRes, Numero, DDD)
);

CREATE TABLE Endereco (
    CodEndereco Integer PRIMARY KEY,
    Numero Numeric(5) NOT NULL,
    FK_Cep_CodCep Integer,
    FK_Bairro_CodBairro Integer,
    FK_Rua_CodRua Integer,
    UNIQUE (CodEndereco, Numero, FK_Cep_CodCep, FK_Bairro_CodBairro, FK_Rua_CodRua)
);

CREATE TABLE Rua (
    CodRua Integer PRIMARY KEY,
    Nome Varchar(100),
    UNIQUE (CodRua, Nome)
);

CREATE TABLE Bairro (
    CodBairro Integer PRIMARY KEY,
    Nome Varchar(100),
    UNIQUE (CodBairro, Nome)
);

CREATE TABLE UF (
    CodUf Integer PRIMARY KEY,
    Nome Varchar(50) NOT NULL,
    Sigla Varchar(2) NOT NULL,
    UNIQUE (CodUf, Nome, Sigla)
);

CREATE TABLE Cidade (
    CodCidade Integer PRIMARY KEY,
    Campo Varchar(50),
    FK_UF_CodUf Integer,
    UNIQUE (CodCidade, FK_UF_CodUf)
);

CREATE TABLE Cep (
    CodCep Integer PRIMARY KEY,
    Numero Numeric(8) NOT NULL,
    FK_Cidade_CodCidade Integer,
    UNIQUE (CodCep, Numero, FK_Cidade_CodCidade)
);

CREATE TABLE Paciente (
    CodPaciente Integer PRIMARY KEY,
    Nome Varchar(100) NOT NULL,
    DataNasc Date NOT NULL,
    Email Varchar(50) NOT NULL,
    FK_Profissao_CodProfissao Integer,
    FK_Genero_CodGenero Integer,
    FK_EstadoCivil_CodEC Integer,
    UNIQUE (CodPaciente, FK_Profissao_CodProfissao, FK_Genero_CodGenero, FK_EstadoCivil_CodEC)
);

CREATE TABLE PacienteTesRes (
    FK_Paciente_CodPaciente Integer,
    FK_TelRes_CodTelRes Integer,
    PRIMARY KEY (FK_Paciente_CodPaciente, FK_TelRes_CodTelRes),
    UNIQUE (FK_Paciente_CodPaciente, FK_TelRes_CodTelRes)
);

CREATE TABLE PacienteCelular (
    FK_Paciente_CodPaciente Integer,
    FK_Celular_CodCelular Integer,
    PRIMARY KEY (FK_Paciente_CodPaciente, FK_Celular_CodCelular),
    UNIQUE (FK_Paciente_CodPaciente, FK_Celular_CodCelular)
);

CREATE TABLE Questionario (
    CodQuestionario Integer PRIMARY KEY,
    QtdPessoas Numeric(4) NOT NULL,
    Rotina Varchar(255) NOT NULL,
    DescricaoDifi Varchar(255) NOT NULL,
    CirurgiaRec RespostaGenerica,
    FK_Paciente_CodPaciente Integer,
    FK_Anamnese_CodAnamnese Integer,
    UNIQUE (CodQuestionario, FK_Paciente_CodPaciente, QtdPessoas, FK_Anamnese_CodAnamnese)
);

CREATE TABLE Objetivo (
    CodObjetivo Integer PRIMARY KEY,
    Descricao Varchar(50)  NOT NULL,
    FK_Questionario_CodQuestionario Integer,
    UNIQUE (CodObjetivo, Descricao, FK_Questionario_CodQuestionario)
);

CREATE TABLE TipoCirurgia (
    CodTipoCirur Integer PRIMARY KEY,
    Nome Varchar(50) NOT NULL UNIQUE,
    fk_Questionario_FK_Paciente_CodPaciente Integer
);

CREATE TABLE DietaEmagrecer (
    CodEmagrecer Integer PRIMARY KEY,
    Resposta Boolean  NOT NULL,
    FK_Objetivo_CodObjetivo Integer,
    UNIQUE (CodEmagrecer, FK_Objetivo_CodObjetivo)
);

CREATE TABLE IdadeD1 (
    CodIdadeD1 Serial PRIMARY KEY,
    Idade Numeric(3) NOT NULL,
    TipoDieta Varchar(50) NOT NULL,
    FK_DietaEmagrecer_CodEmagrecer Integer,
    UNIQUE (TipoDieta, Idade, FK_DietaEmagrecer_CodEmagrecer)
);

CREATE TABLE ConsegEmagrecer (
    CodConsEmag Integer PRIMARY KEY,
    Resposta Boolean  NOT NULL,
    FK_IdadeD1_CodIdadeD1 Serial,
    UNIQUE (CodConsEmag, Resposta, FK_IdadeD1_CodIdadeD1)
);

CREATE TABLE KgEmag (
    CodKgEmag Integer PRIMARY KEY,
    Kg Decimal(3,2)  NOT NULL,
    FK_ConsegEmagrecer_CodConsegEmagrecer Integer,
    UNIQUE (CodKgEmag, Kg, FK_ConsegEmagrecer_CodConsegEmagrecer)
);

CREATE TABLE Recuperou (
    CodRec Integer PRIMARY KEY,
    Resposta Boolean  NOT NULL,
    FK_KgEmag_CodKgEmag Integer,
    UNIQUE (CodRec, Resposta, FK_KgEmag_CodKgEmag)
);

CREATE TABLE KgRec (
    CodKgRec Serial PRIMARY KEY,
    Kg Decimal(2,1)  NOT NULL,
    FK_Recuperou_CodRecuperou Integer,
    UNIQUE (CodKgRec, Kg, FK_Recuperou_CodRecuperou)
);

CREATE TABLE QuestAntecedenteP (
    FK_Questionario_CodQuestionario Integer,
    FK_Antecedente_CodAntecedente Integer,
    PRIMARY KEY (FK_Questionario_CodQuestionario, FK_Antecedente_CodAntecedente),
    UNIQUE (FK_Antecedente_CodAntecedente, FK_Questionario_CodQuestionario)
);

CREATE TABLE QuestAntecedenteF (
    FK_Questionario_CodQuestionario Integer,
    FK_Antecedente_CodAntecedente Integer,
    FK_TipoFamilia_CodTipoFamilia Integer,
    PRIMARY KEY (FK_Questionario_CodQuestionario, FK_Antecedente_CodAntecedente, FK_TipoFamilia_CodTipoFamilia),
    UNIQUE (FK_Questionario_CodQuestionario, FK_Antecedente_CodAntecedente, FK_TipoFamilia_CodTipoFamilia)
);

CREATE TABLE Antecedente (
    CodAntecedente Integer Serial PRIMARY KEY,
    Nome Varchar(50) NOT NULL,
    UNIQUE (CodAntecedente, Nome)
);

CREATE TABLE TipoFamilia (
    CodTipoFamilia Integer PRIMARY KEY,
    Nome Varchar(50) NOT NULL,
    UNIQUE (CodTipoFamilia, Nome)
);

CREATE TABLE Anamnese (
    CodAnamnese Integer PRIMARY KEY,
    DescricaoTrat Varchar(100)  NOT NULL,
    FK_HabitoUrinario_CodHabUri Integer,
    DispFisica Varchar(80) NOT NULL,
    Sono Varchar(80) NOT NULL,
    ObsSono Varchar(255),
    UNIQUE (CodAnamnese, FK_HabitoUrinario_CodHabUri)
);

CREATE TABLE AnamneseMedSupAn (
    FK_Anamnese_CodAnamnese Integer,
    FK_MedSup_CodMedSup Integer,
    PRIMARY KEY (FK_Anamnese_CodAnamnese, FK_MedSup_CodMedSup),
    UNIQUE (FK_Anamnese_CodAnamnese, FK_MedSup_CodMedSup)
);

CREATE TABLE MedSup (
    CodMedSup Integer PRIMARY KEY,
    Tipo Varchar(20)  NOT NULL,
    Descricao Varchar(255) ,
    UNIQUE (CodMedSup, Tipo)
);

CREATE TABLE TGI (
    CodTGI Integer PRIMARY KEY,
    Nome Varchar(80) NOT NULL,
    Descricao Varchar (255),
    UNIQUE (CodTGI, Nome)
);

CREATE TABLE AnamneseTGI (
    FK_Anamnese_CodAnamnese Integer,
    FK_TGI_CodTGI Integer,
    PRIMARY KEY (FK_Anamnese_CodAnamnese, FK_TGI_CodTGI),
    UNIQUE (FK_Anamnese_CodAnamnese, FK_TGI_CodTGI)
);

CREATE TABLE HabitoIntestinal (
    CodHabitoIntest Integer PRIMARY KEY,
    FK_Anamnese_CodAnamnese Integer,
    FK_Bristol_CodBristol Integer,
    FK_TiposHI_CodTipo Integer,
    FK_Frequencia_CodFrequencia Integer,
    FK_Retorno_CodRetorno Integer,
    UNIQUE (CodHabitoIntest, FK_Anamnese_CodAnamnese, FK_Bristol_CodBristol, FK_TiposHI_CodTipo, FK_Frequencia_CodFrequencia, FK_Retorno_CodRetorno)
);

CREATE TABLE TiposHI (
    CodTipo Integer PRIMARY KEY,
    Tipo Varchar(80) NOT NULL,
    UNIQUE (CodTipo, Tipo)
);

CREATE TABLE Frequencia (
    CodFrequencia Integer PRIMARY KEY,
    Tipo Varchar(80) NOT NULL Varchar(80) NOT NULL,
    Quantidade Numeric(2),
    UNIQUE (CodFrequencia, Tipo)
);

CREATE TABLE Bristol (
    CodBristol Integer PRIMARY KEY,
    Foto Blob,
    Numero Numeric(1),
    UNIQUE (CodBristol, Foto, Numero)
);

CREATE TABLE HabitoUrinario (
    CodHabUri Integer PRIMARY KEY,
    Tipo Varchar(80)  NOT NULL,
    Foto Blob,
    UNIQUE (CodHabUri, Tipo, Foto)
);

CREATE TABLE Fumo (
    CodFumo Integer PRIMARY KEY,
    Resposta Varchar(50) NOT NULL,
    FK_Anamnese_CodAnamnese Integer,
    UNIQUE (CodFumo, FK_Anamnese_CodAnamnese)
);

CREATE TABLE QtdCigarros (
    CodQtdCigarro Serial PRIMARY KEY,
    Campo Numeric(3)  NOT NULL,
    FK_Fumo_CodFumo Integer,
    UNIQUE (CodQtdCigarro, FK_Fumo_CodFumo)
);

CREATE TABLE TempoCigarro (
    CodTempoCigarro Serial PRIMARY KEY,
    Tempo Numeric(4),
    TipoTempo Varchar(15)  NOT NULL,
    FK_Fumo_CodFumo Integer,
    UNIQUE (CodTempoCigarro, FK_Fumo_CodFumo)
);

CREATE TABLE CicloMenstrual (
    CodCiclo Integer PRIMARY KEY,
    Duracao Numeric(3)  NOT NULL,
    FK_Anamnese_CodAnamnese Integer,
    Obs Varchar(255),
    Menopausa RespostaGenerica,
    UNIQUE (CodCiclo, FK_Anamnese_CodAnamnese)
);

CREATE TABLE TPM (
    CodTPM Serial PRIMARY KEY,
    Resposta Boolean,
    FK_CicloMenstrual_CodCiclo Integer UNIQUE
);

CREATE TABLE ReposicaoHormonal (
    CodHormonal Serial PRIMARY KEY,
    Resposta Boolean,
    FK_CicloMenstrual_CodCiclo Integer,
    UNIQUE (CodHormonal, FK_CicloMenstrual_CodCiclo)
);

CREATE TABLE Alcool (
    CodAlcool Integer PRIMARY KEY,
    Resposta Boolean,
    FK_Anamnese_CodAnamnese Integer UNIQUE
);

CREATE TABLE TipoAlcool (
    CodTipo Serial PRIMARY KEY,
    Tipo Varchar(50) NOT NULL,
    FK_Alcool_CodAlcool Integer,
    UNIQUE (CodTipo, FK_Alcool_CodAlcool)
);

CREATE TABLE FreqAlcool (
    CodFrequencia Serial PRIMARY KEY,
    Frequencia Numeric(3)  NOT NULL,
    TipoFreq Varchar(50) NOT NULL,
    FK_Alcool_CodAlcool Integer,
    UNIQUE (CodFrequencia, FK_Alcool_CodAlcool)
);

CREATE TABLE AtividadeFisica (
    CodAtividade Integer PRIMARY KEY,
    Resposta Boolean NOT NULL,
    FK_Anamnese_CodAnamnese Integer,
    UNIQUE (CodAtividade, FK_Anamnese_CodAnamnese)
);

CREATE TABLE TipoAtividadeF (
    CodTipo Serial PRIMARY KEY,
    Tipo Varchar(50) NOT NULL,
    FK_AtividadeFisica_CodAtividade Integer,
    UNIQUE (CodTipo, FK_AtividadeFisica_CodAtividade)
);

CREATE TABLE FreqAtividadeF (
    CodFreqAtF Serial PRIMARY KEY,
    Frequencia Numeric(3)  NOT NULL,
    FK_AtividadeFisica_CodAtividade Integer,
    UNIQUE (CodFreqAtF, FK_AtividadeFisica_CodAtividade)
);

CREATE TABLE ExamesLab (
    CodExameLab Serial PRIMARY KEY,
    Anexo Blob,
    FK_Questionario_CodQuestionario Integer,
    UNIQUE (CodExameLab, FK_Questionario_CodQuestionario)
);

CREATE TABLE AvaliaçãoNutricional (
    CodAvNutri Integer PRIMARY KEY,
    fk_Questionario_QtdPessoas Integer,
    Preferencias Varchar(255),
    UNIQUE (CodAvNutri, fk_Questionario_QtdPessoas)
);

CREATE TABLE Aversoes (
    CodAversoes Integer PRIMARY KEY,
    Nome Varchar(50) NOT NULL,
    UNIQUE (CodAversoes, Nome)
);

CREATE TABLE AvNutriAversoes (
    FK_AvNutri_CodAvNutri Integer,
    FK_Aversoes_CodAversoes Integer,
    UNIQUE (FK_AvNutri_CodAvNutri, FK_Aversoes_CodAversoes)
);

CREATE TABLE AlergiaIntolerancia (
    CodAlerInto Integer PRIMARY KEY,
    Nome Varchar(50),
    UNIQUE (CodAlerInto, Nome)
);

CREATE TABLE AvNutriAlerInto (
    FK_AvNutri_CodAvNutri Integer,
    FK_AlerInto_CpdAlerInto Integer,
    UNIQUE (FK_AvNutri_CodAvNutri, FK_AlerInto_CpdAlerInto)
);

CREATE TABLE HorarioFome (
    CodHrFome Serial PRIMARY KEY UNIQUE,
    Horario Varchar(50)
);

CREATE TABLE AvNutriHrFome (
    FK_AvNutri_CodAvNutri Integer,
    FK_HrFome_CodHrFome Serial,
    UNIQUE (FK_HrFome_CodHrFome, FK_AvNutri_CodAvNutri)
);

CREATE TABLE DiaAlimentar (
    CodDiaAlimentar Integer PRIMARY KEY,
    FK_Questionario_CodQuestionario Integer,
    UNIQUE (CodDiaAlimentar, FK_Questionario_CodQuestionario)
);

CREATE TABLE Alimento (
    CodAlimento Integer PRIMARY KEY UNIQUE,
    Nome Varchar(50)
);

CREATE TABLE DiaAlimAlimento (
    FK_DiaAlimentar_CodDiaAlim Integer,
    FK_Alimento_CodAlimento Integer,
    Horario Varchar(50),
    Quantidade Varchar(50),
    UNIQUE (FK_DiaAlimentar_CodDiaAlim, FK_Alimento_CodAlimento)
);

CREATE TABLE AnamneseAlimentar (
    CodAnamAlim Integer PRIMARY KEY,
    FK_Questionario_CodQuestionario Integer,
    FK_ReaRefe_CodReaRefe Integer,
    GostoAlimentos RespostaGenerica,
    EvitaAlimento RespostaGenerica,
    LiquidoRefeicoes RespostaGenerica,
    FK_RelacaoSal_CodRelacaoSal Serial,
    Condimentos RespostaGenerica,
    AcucarAdocante Varchar(50),
    QtdAcuAdoc Varchar(50),
    Gordura Varchar(50),
    QtdGordura Varchar(50),
    MastigaAlimentos RespostaGenerica,
    DistracaoAlim RespostaGenerica,
    UNIQUE (CodAnamAlim, FK_Questionario_CodQuestionario, FK_ReaRefe_CodReaRefe, MastigaAlimentos, DistracaoAlim)
);

CREATE TABLE RealizaRefeicoes (
    CodReaRefe Integer PRIMARY KEY UNIQUE,
    Nome Varchar(50)
);

CREATE TABLE AlimentoGosta (
    CodAlimGos Integer PRIMARY KEY UNIQUE,
    Nome Varchar(50)
);

CREATE TABLE AnamAlimGosta (
    FK_AnamneseAlimentar_CodAnamAlim Integer,
    FK_AlimentoGosta_CodAlimGos Integer,
    UNIQUE (FK_AnamneseAlimentar_CodAnamAlim, FK_AlimentoGosta_CodAlimGos)
);

CREATE TABLE RespostaGenerica (
    CodPergunta RespostaGenerica PRIMARY KEY UNIQUE,
    Nome Varchar(50)
);

CREATE TABLE Motivo (
    CodMotivo Serial PRIMARY KEY,
    Nome Varchar(100),
    FK_AnamneseAlimentar_CodAnamAlim Integer,
    UNIQUE (CodMotivo, FK_AnamneseAlimentar_CodAnamAlim)
);

CREATE TABLE Liquidos (
    CodLiquido Integer PRIMARY KEY,
    Nome Varchar(50),
    Quantidade Varchar(50)
);

CREATE TABLE AnamAlimLiqui (
    FK_AnamneseAlimentar_CodAnamAlim Integer,
    FK_Liquidos_CodLiquidos Integer,
    UNIQUE (FK_AnamneseAlimentar_CodAnamAlim, FK_Liquidos_CodLiquidos)
);

CREATE TABLE RelacaoSal (
    CodRelacaoSal Serial PRIMARY KEY,
    Nome Varchar(50)
);

CREATE TABLE Condimentos (
    CodCondimento Integer PRIMARY KEY,
    Nome Varchar(50)
);

CREATE TABLE QuaisCondimentos (
    FK_AnamneseAlimentar_CodAnamAlim Integer,
    FK_Condimentos_CodCondimentos Integer,
    UNIQUE (FK_Condimentos_CodCondimentos, FK_AnamneseAlimentar_CodAnamAlim)
);

CREATE TABLE TempoRefeicao (
    CodTemRefe Serial PRIMARY KEY,
    Tipo Varchar(50),
    Nome Varchar(50),
    FK_AnamneseAlimentar_CodAnamAlim Integer
);

CREATE TABLE QuaisDistracoes (
    CodDistracoes Serial PRIMARY KEY,
    Nome Varchar(50),
    FK_AnamneseAlimentar_CodAnamAlim Integer UNIQUE
);

CREATE TABLE AvaliacaooAntropometrica (
    CodAvAntro Serial PRIMARY KEY UNIQUE,
    Peso Numeric (10,2) NOT NULL,
    Estatura Numeric (10,2) NOT NULL,
    Punho Numeric (10,2),
    CB Numeric (10,2),
    CA/CC Numeric (10,2),
    CQ Numeric (10,2),
    CCoxa Integer,
    CPanturrilha Numeric (10,2),
    AJ Numeric (10,2),
    PCB Numeric (10,2),
    PCT Numeric (10,2),
    PCSE Numeric (10,2),
    PCSI Numeric (10,2),
    PCTx Numeric (10,2),
    PCAb Numeric (10,2),
    PCAx Numeric (10,2),
    PCPa Numeric (10,2),
    PCCx Numeric (10,2),
    FK_Paciente_CodPaciente Integer
);

CREATE TABLE AvaliacaoDietica (
    fk_Paciente_FK_Genero_CodGenero Integer,
    FK_NeceNutri_CodNeceNutri Serial,
    FK_AvAlim_CodAvAlim Serial,
    FK_Micronutrientes_CodMicronutrientes Serial
);

CREATE TABLE NecessidadeNutricional (
    CodNeceNutri Serial PRIMARY KEY,
    GER Numeric (10,2),
    GET Numeric (10,2),
    Kcal Numeric (10,2),
    Ptn Numeric (10,2),
    Ptn Numeric (10,2),
    Data Date
);

CREATE TABLE AvaliacaoAlimentar (
    CodAvAlim Serial PRIMARY KEY,
    Calorias Numeric (10,2),
    CHO Numeric (10,2),
    PTN Numeric (10,2),
    LIP Numeric (10,2),
    Data Date
);

CREATE TABLE Micronutrientes (
    CodMicronutrientes Serial PRIMARY KEY,
    Nome Varchar(50)
);

CREATE TABLE Retorno (
    CodRetorno Integer PRIMARY KEY,
    Data Date,
    PlanoAlimentar Varchar(255),
    ConsRealizar RespostaGenerica,
    Med/Sup RespostaGenerica,
    AtividadeFisica RespostaGenerica,
    fk_AtividadeFisica_CodAtividade Integer,
    FK_HabitoUrinario_CodHU Integer,
    QueixasNutri RespostaGenerica,
    CondutaNutri Varchar(255),
    FK_Paciente_CodPaciente Integer
);

CREATE TABLE RetortnoMedSup (
    FK_Retorno_CodRetorno Integer,
    FK_MedSup_CodMedSup Integer
);

CREATE TABLE Dificuldades (
    CodDificuldade Serial PRIMARY KEY,
    Nome Varchar(50)
);

CREATE TABLE RetornoDificuldades (
    FK_Retorno_CodRetorno Integer,
    FK_Dificuldades_CodDificuldades Serial
);

CREATE TABLE Dieta (
    CodDieta Integer PRIMARY KEY,
    Dieta Blob,
    FK_Paciente_CodPaciente Integer
);

CREATE TABLE RetornoLiquidos (
    FK_Retorno_CodRetorno Integer,
    FK_Liquidos_CodLiquidos Integer
);

CREATE TABLE Consulta (
    CodConsulta Serial PRIMARY KEY,
    Data Date,
    Hora Varchar(50),
    fk_Paciente_FK_Genero_CodGenero Integer,
    FK_Nutricionista_CodNutri Serial
);

CREATE TABLE Usuario (
    CodUsuario Serial PRIMARY KEY,
    Nome Varchar(50),
    Senha Password,
    FK_Permissao_CodPermissao Serial
);

CREATE TABLE Nutricionista (
    CodNutri Serial PRIMARY KEY,
    Nome Serial,
    Cpf Varchar(50),
    FK_Usuario_Codusuario Serial
);

CREATE TABLE Permissao (
    CodPermissao Serial PRIMARY KEY,
    Nome Varchar(50)
);
 
ALTER TABLE Celular ADD CONSTRAINT FK_Celular_3
    FOREIGN KEY (FK_Paciente_CodPaciente, ???)
    REFERENCES PacienteCelular (FK_Paciente_CodPaciente, ???);
 
ALTER TABLE Endereco ADD CONSTRAINT FK_Endereco_3
    FOREIGN KEY (fk_Cep_CodCep???, fk_Bairro_CodBairro???, FK_Bairro_CodBairro)
    REFERENCES Bairro (???, ???, CodBairro);
 
ALTER TABLE Endereco ADD CONSTRAINT FK_Endereco_4
    FOREIGN KEY (FK_Cep_CodCep)
    REFERENCES Cep (CodCep);
 
ALTER TABLE Endereco ADD CONSTRAINT FK_Endereco_5
    FOREIGN KEY (FK_Rua_CodRua)
    REFERENCES Rua (CodRua);
 
ALTER TABLE Cidade ADD CONSTRAINT FK_Cidade_3
    FOREIGN KEY (Campo_1???)
    REFERENCES Cep (???);
 
ALTER TABLE Cidade ADD CONSTRAINT FK_Cidade_4
    FOREIGN KEY (FK_UF_CodUf???)
    REFERENCES UF (???);
 
ALTER TABLE Cep ADD CONSTRAINT FK_Cep_3
    FOREIGN KEY (FK_Cidade_CodCidade, ???)
    REFERENCES Cidade (CodCidade, ???);
 
ALTER TABLE Paciente ADD CONSTRAINT FK_Paciente_3
    FOREIGN KEY (FK_Profissao_CodProfissao)
    REFERENCES Profissao (CodProfissao);
 
ALTER TABLE Paciente ADD CONSTRAINT FK_Paciente_4
    FOREIGN KEY (FK_Genero_CodGenero, ???)
    REFERENCES GeneroBio (CodGenero, ???);
 
ALTER TABLE Paciente ADD CONSTRAINT FK_Paciente_5
    FOREIGN KEY (FK_EstadoCivil_CodEC)
    REFERENCES EstadoCivil (CodEstadoCivil);
 
ALTER TABLE Paciente ADD CONSTRAINT FK_Paciente_6
    FOREIGN KEY (Email, ???)
    REFERENCES PacienteCelular (FK_Paciente_CodPaciente, ???);
 
ALTER TABLE PacienteTesRes ADD CONSTRAINT FK_PacienteTesRes_2
    FOREIGN KEY (FK_Paciente_CodPaciente)
    REFERENCES Paciente (CodPaciente);
 
ALTER TABLE PacienteTesRes ADD CONSTRAINT FK_PacienteTesRes_4
    FOREIGN KEY (FK_TelRes_CodTelRes)
    REFERENCES TelRes (CodTelRes);
 
ALTER TABLE PacienteCelular ADD CONSTRAINT FK_PacienteCelular_2
    FOREIGN KEY (FK_Paciente_CodPaciente)
    REFERENCES Paciente (CodPaciente);
 
ALTER TABLE PacienteCelular ADD CONSTRAINT FK_PacienteCelular_4
    FOREIGN KEY (FK_Celular_CodCelular)
    REFERENCES Celular (CodCelular);
 
ALTER TABLE Questionario ADD CONSTRAINT FK_Questionario_2
    FOREIGN KEY (FK_Paciente_CodPaciente)
    REFERENCES Paciente (CodPaciente);
 
ALTER TABLE Questionario ADD CONSTRAINT FK_Questionario_4
    FOREIGN KEY (FK_Anamnese_CodAnamnese)
    REFERENCES Anamnese (CodAnamnese);
 
ALTER TABLE Questionario ADD CONSTRAINT FK_Questionario_5
    FOREIGN KEY (CirurgiaRec)
    REFERENCES RespostaGenerica (CodPergunta);
 
ALTER TABLE Objetivo ADD CONSTRAINT FK_Objetivo_3
    FOREIGN KEY (FK_Questionario_CodQuestionario)
    REFERENCES Questionario (CodQuestionario);
 
ALTER TABLE TipoCirurgia ADD CONSTRAINT FK_TipoCirurgia_3
    FOREIGN KEY (fk_Questionario_FK_Paciente_CodPaciente)
    REFERENCES Questionario (CodQuestionario);
 
ALTER TABLE DietaEmagrecer ADD CONSTRAINT FK_DietaEmagrecer_3
    FOREIGN KEY (FK_Objetivo_CodObjetivo)
    REFERENCES Objetivo (CodObjetivo);
 
ALTER TABLE IdadeD1 ADD CONSTRAINT FK_IdadeD1_3
    FOREIGN KEY (FK_DietaEmagrecer_CodEmagrecer)
    REFERENCES DietaEmagrecer (CodEmagrecer);
 
ALTER TABLE ConsegEmagrecer ADD CONSTRAINT FK_ConsegEmagrecer_3
    FOREIGN KEY (FK_IdadeD1_CodIdadeD1)
    REFERENCES IdadeD1 (CodIdadeD1);
 
ALTER TABLE KgEmag ADD CONSTRAINT FK_KgEmag_3
    FOREIGN KEY (FK_ConsegEmagrecer_CodConsegEmagrecer)
    REFERENCES ConsegEmagrecer (CodConsEmag);
 
ALTER TABLE Recuperou ADD CONSTRAINT FK_Recuperou_3
    FOREIGN KEY (FK_KgEmag_CodKgEmag)
    REFERENCES KgEmag (CodKgEmag);
 
ALTER TABLE KgRec ADD CONSTRAINT FK_KgRec_3
    FOREIGN KEY (FK_Recuperou_CodRecuperou)
    REFERENCES Recuperou (CodRec);
 
ALTER TABLE QuestAntecedenteP ADD CONSTRAINT FK_QuestAntecedenteP_2
    FOREIGN KEY (FK_Questionario_CodQuestionario)
    REFERENCES Questionario (CodQuestionario);
 
ALTER TABLE QuestAntecedenteP ADD CONSTRAINT FK_QuestAntecedenteP_3
    FOREIGN KEY (FK_Antecedente_CodAntecedente)
    REFERENCES Antecedente (CodAntecedente);
 
ALTER TABLE QuestAntecedenteF ADD CONSTRAINT FK_QuestAntecedenteF_1
    FOREIGN KEY (FK_Questionario_CodQuestionario, ???)
    REFERENCES Questionario (CodQuestionario, ???);
 
ALTER TABLE QuestAntecedenteF ADD CONSTRAINT FK_QuestAntecedenteF_4
    FOREIGN KEY (FK_Antecedente_CodAntecedente)
    REFERENCES Antecedente (CodAntecedente);
 
ALTER TABLE QuestAntecedenteF ADD CONSTRAINT FK_QuestAntecedenteF_5
    FOREIGN KEY (fk_TipoFamilia_Nome???, FK_TipoFamilia_CodTipoFamilia)
    REFERENCES TipoFamilia (???, CodTipoFamilia);
 
ALTER TABLE Anamnese ADD CONSTRAINT FK_Anamnese_3
    FOREIGN KEY (FK_HabitoUrinario_CodHabUri, ???)
    REFERENCES HabitoUrinario (CodHabUri, ???);
 
ALTER TABLE AnamneseMedSupAn ADD CONSTRAINT FK_AnamneseMedSupAn_2
    FOREIGN KEY (FK_Anamnese_CodAnamnese)
    REFERENCES Anamnese (CodAnamnese);
 
ALTER TABLE AnamneseMedSupAn ADD CONSTRAINT FK_AnamneseMedSupAn_4
    FOREIGN KEY (FK_MedSup_CodMedSup)
    REFERENCES MedSup (CodMedSup);
 
ALTER TABLE AnamneseTGI ADD CONSTRAINT FK_AnamneseTGI_2
    FOREIGN KEY (FK_Anamnese_CodAnamnese???)
    REFERENCES Anamnese (???);
 
ALTER TABLE AnamneseTGI ADD CONSTRAINT FK_AnamneseTGI_4
    FOREIGN KEY (FK_TGI_CodTGI)
    REFERENCES TGI (CodTGI);
 
ALTER TABLE HabitoIntestinal ADD CONSTRAINT FK_HabitoIntestinal_3
    FOREIGN KEY (FK_Anamnese_CodAnamnese)
    REFERENCES Anamnese (CodAnamnese);
 
ALTER TABLE HabitoIntestinal ADD CONSTRAINT FK_HabitoIntestinal_4
    FOREIGN KEY (FK_Bristol_CodBristol)
    REFERENCES Bristol (CodBristol);
 
ALTER TABLE HabitoIntestinal ADD CONSTRAINT FK_HabitoIntestinal_5
    FOREIGN KEY (FK_TiposHI_CodTipo)
    REFERENCES TiposHI (CodTipo);
 
ALTER TABLE HabitoIntestinal ADD CONSTRAINT FK_HabitoIntestinal_6
    FOREIGN KEY (FK_Frequencia_CodFrequencia)
    REFERENCES Frequencia (CodFrequencia);
 
ALTER TABLE HabitoIntestinal ADD CONSTRAINT FK_HabitoIntestinal_7
    FOREIGN KEY (FK_Retorno_CodRetorno)
    REFERENCES Retorno (CodRetorno);
 
ALTER TABLE Fumo ADD CONSTRAINT FK_Fumo_3
    FOREIGN KEY (FK_Anamnese_CodAnamnese)
    REFERENCES Anamnese (CodAnamnese);
 
ALTER TABLE QtdCigarros ADD CONSTRAINT FK_QtdCigarros_3
    FOREIGN KEY (FK_Fumo_CodFumo)
    REFERENCES Fumo (CodFumo);
 
ALTER TABLE TempoCigarro ADD CONSTRAINT FK_TempoCigarro_3
    FOREIGN KEY (FK_Fumo_CodFumo)
    REFERENCES Fumo (CodFumo);
 
ALTER TABLE CicloMenstrual ADD CONSTRAINT FK_CicloMenstrual_3
    FOREIGN KEY (FK_Anamnese_CodAnamnese)
    REFERENCES Anamnese (CodAnamnese);
 
ALTER TABLE CicloMenstrual ADD CONSTRAINT FK_CicloMenstrual_4
    FOREIGN KEY (Menopausa)
    REFERENCES RespostaGenerica (CodPergunta);
 
ALTER TABLE TPM ADD CONSTRAINT FK_TPM_2
    FOREIGN KEY (FK_CicloMenstrual_CodCiclo)
    REFERENCES CicloMenstrual (CodCiclo);
 
ALTER TABLE ReposicaoHormonal ADD CONSTRAINT FK_ReposicaoHormonal_3
    FOREIGN KEY (FK_CicloMenstrual_CodCiclo)
    REFERENCES CicloMenstrual (CodCiclo);
 
ALTER TABLE Alcool ADD CONSTRAINT FK_Alcool_2
    FOREIGN KEY (FK_Anamnese_CodAnamnese)
    REFERENCES Anamnese (CodAnamnese);
 
ALTER TABLE TipoAlcool ADD CONSTRAINT FK_TipoAlcool_3
    FOREIGN KEY (FK_Alcool_CodAlcool)
    REFERENCES Alcool (CodAlcool);
 
ALTER TABLE FreqAlcool ADD CONSTRAINT FK_FreqAlcool_3
    FOREIGN KEY (FK_Alcool_CodAlcool)
    REFERENCES Alcool (CodAlcool);
 
ALTER TABLE AtividadeFisica ADD CONSTRAINT FK_AtividadeFisica_3
    FOREIGN KEY (FK_Anamnese_CodAnamnese)
    REFERENCES Anamnese (CodAnamnese);
 
ALTER TABLE TipoAtividadeF ADD CONSTRAINT FK_TipoAtividadeF_3
    FOREIGN KEY (FK_AtividadeFisica_CodAtividade)
    REFERENCES AtividadeFisica (CodAtividade);
 
ALTER TABLE FreqAtividadeF ADD CONSTRAINT FK_FreqAtividadeF_3
    FOREIGN KEY (FK_AtividadeFisica_CodAtividade)
    REFERENCES AtividadeFisica (CodAtividade);
 
ALTER TABLE ExamesLab ADD CONSTRAINT FK_ExamesLab_3
    FOREIGN KEY (FK_Questionario_CodQuestionario)
    REFERENCES Questionario (CodQuestionario);
 
ALTER TABLE AvaliaçãoNutricional ADD CONSTRAINT FK_AvaliaçãoNutricional_3
    FOREIGN KEY (fk_Questionario_QtdPessoas)
    REFERENCES Questionario (CodQuestionario);
 
ALTER TABLE AvNutriAversoes ADD CONSTRAINT FK_AvNutriAversoes_2
    FOREIGN KEY (FK_AvNutri_CodAvNutri)
    REFERENCES AvaliaçãoNutricional (CodAvNutri);
 
ALTER TABLE AvNutriAversoes ADD CONSTRAINT FK_AvNutriAversoes_3
    FOREIGN KEY (FK_Aversoes_CodAversoes)
    REFERENCES Aversoes (CodAversoes);
 
ALTER TABLE AvNutriAlerInto ADD CONSTRAINT FK_AvNutriAlerInto_1
    FOREIGN KEY (FK_AvNutri_CodAvNutri)
    REFERENCES AvaliaçãoNutricional (CodAvNutri);
 
ALTER TABLE AvNutriAlerInto ADD CONSTRAINT FK_AvNutriAlerInto_3
    FOREIGN KEY (FK_AlerInto_CpdAlerInto)
    REFERENCES AlergiaIntolerancia (CodAlerInto);
 
ALTER TABLE AvNutriHrFome ADD CONSTRAINT FK_AvNutriHrFome_1
    FOREIGN KEY (FK_AvNutri_CodAvNutri)
    REFERENCES AvaliaçãoNutricional (CodAvNutri);
 
ALTER TABLE AvNutriHrFome ADD CONSTRAINT FK_AvNutriHrFome_3
    FOREIGN KEY (fk_HorarioFome_CodHrFome)
    REFERENCES HorarioFome (CodHrFome);
 
ALTER TABLE AvNutriHrFome ADD CONSTRAINT FK_AvNutriHrFome_4
    FOREIGN KEY (FK_HrFome_CodHrFome)
    REFERENCES HorarioFome (CodHrFome);
 
ALTER TABLE DiaAlimentar ADD CONSTRAINT FK_DiaAlimentar_3
    FOREIGN KEY (FK_Questionario_CodQuestionario)
    REFERENCES Questionario (CodQuestionario);
 
ALTER TABLE DiaAlimAlimento ADD CONSTRAINT FK_DiaAlimAlimento_1
    FOREIGN KEY (FK_DiaAlimentar_CodDiaAlim)
    REFERENCES DiaAlimentar (CodDiaAlimentar);
 
ALTER TABLE DiaAlimAlimento ADD CONSTRAINT FK_DiaAlimAlimento_3
    FOREIGN KEY (FK_Alimento_CodAlimento)
    REFERENCES Alimento (CodAlimento);
 
ALTER TABLE AnamneseAlimentar ADD CONSTRAINT FK_AnamneseAlimentar_3
    FOREIGN KEY (FK_Questionario_CodQuestionario)
    REFERENCES Questionario (CodQuestionario);
 
ALTER TABLE AnamneseAlimentar ADD CONSTRAINT FK_AnamneseAlimentar_4
    FOREIGN KEY (FK_ReaRefe_CodReaRefe)
    REFERENCES RealizaRefeicoes (CodReaRefe);
 
ALTER TABLE AnamneseAlimentar ADD CONSTRAINT FK_AnamneseAlimentar_5
    FOREIGN KEY (GostoAlimentos)
    REFERENCES RespostaGenerica (CodPergunta);
 
ALTER TABLE AnamneseAlimentar ADD CONSTRAINT FK_AnamneseAlimentar_6
    FOREIGN KEY (EvitaAlimento)
    REFERENCES RespostaGenerica (CodPergunta);
 
ALTER TABLE AnamneseAlimentar ADD CONSTRAINT FK_AnamneseAlimentar_7
    FOREIGN KEY (LiquidoRefeicoes)
    REFERENCES RespostaGenerica (CodPergunta);
 
ALTER TABLE AnamneseAlimentar ADD CONSTRAINT FK_AnamneseAlimentar_8
    FOREIGN KEY (FK_RelacaoSal_CodRelacaoSal)
    REFERENCES RelacaoSal (CodRelacaoSal);
 
ALTER TABLE AnamneseAlimentar ADD CONSTRAINT FK_AnamneseAlimentar_9
    FOREIGN KEY (Condimentos)
    REFERENCES RespostaGenerica (CodPergunta);
 
ALTER TABLE AnamneseAlimentar ADD CONSTRAINT FK_AnamneseAlimentar_10
    FOREIGN KEY (MastigaAlimentos)
    REFERENCES RespostaGenerica (CodPergunta);
 
ALTER TABLE AnamneseAlimentar ADD CONSTRAINT FK_AnamneseAlimentar_11
    FOREIGN KEY (DistracaoAlim)
    REFERENCES RespostaGenerica (CodPergunta);
 
ALTER TABLE AnamAlimGosta ADD CONSTRAINT FK_AnamAlimGosta_1
    FOREIGN KEY (FK_AlimentoGosta_CodAlimGos)
    REFERENCES AlimentoGosta (CodAlimGos);
 
ALTER TABLE AnamAlimGosta ADD CONSTRAINT FK_AnamAlimGosta_3
    FOREIGN KEY (FK_AnamneseAlimentar_CodAnamAlim)
    REFERENCES AnamneseAlimentar (CodAnamAlim);
 
ALTER TABLE Motivo ADD CONSTRAINT FK_Motivo_3
    FOREIGN KEY (FK_AnamneseAlimentar_CodAnamAlim)
    REFERENCES AnamneseAlimentar (CodAnamAlim);
 
ALTER TABLE AnamAlimLiqui ADD CONSTRAINT FK_AnamAlimLiqui_1
    FOREIGN KEY (FK_AnamneseAlimentar_CodAnamAlim)
    REFERENCES AnamneseAlimentar (CodAnamAlim);
 
ALTER TABLE AnamAlimLiqui ADD CONSTRAINT FK_AnamAlimLiqui_3
    FOREIGN KEY (FK_Liquidos_CodLiquidos)
    REFERENCES Liquidos (CodLiquido);
 
ALTER TABLE QuaisCondimentos ADD CONSTRAINT FK_QuaisCondimentos_1
    FOREIGN KEY (FK_AnamneseAlimentar_CodAnamAlim)
    REFERENCES AnamneseAlimentar (CodAnamAlim);
 
ALTER TABLE QuaisCondimentos ADD CONSTRAINT FK_QuaisCondimentos_2
    FOREIGN KEY (FK_Condimentos_CodCondimentos)
    REFERENCES Condimentos (CodCondimento);
 
ALTER TABLE TempoRefeicao ADD CONSTRAINT FK_TempoRefeicao_2
    FOREIGN KEY (FK_AnamneseAlimentar_CodAnamAlim)
    REFERENCES AnamneseAlimentar (CodAnamAlim);
 
ALTER TABLE QuaisDistracoes ADD CONSTRAINT FK_QuaisDistracoes_2
    FOREIGN KEY (FK_AnamneseAlimentar_CodAnamAlim)
    REFERENCES AnamneseAlimentar (CodAnamAlim);
 
ALTER TABLE AvaliacaooAntropometrica ADD CONSTRAINT FK_AvaliacaooAntropometrica_3
    FOREIGN KEY (FK_Paciente_CodPaciente)
    REFERENCES Paciente (CodPaciente);
 
ALTER TABLE AvaliacaoDietica ADD CONSTRAINT FK_AvaliacaoDietica_1
    FOREIGN KEY (fk_Paciente_FK_Genero_CodGenero)
    REFERENCES Paciente (CodPaciente);
 
ALTER TABLE AvaliacaoDietica ADD CONSTRAINT FK_AvaliacaoDietica_2
    FOREIGN KEY (FK_NeceNutri_CodNeceNutri)
    REFERENCES NecessidadeNutricional (CodNeceNutri);
 
ALTER TABLE AvaliacaoDietica ADD CONSTRAINT FK_AvaliacaoDietica_3
    FOREIGN KEY (FK_AvAlim_CodAvAlim)
    REFERENCES AvaliacaoAlimentar (CodAvAlim);
 
ALTER TABLE AvaliacaoDietica ADD CONSTRAINT FK_AvaliacaoDietica_4
    FOREIGN KEY (FK_Micronutrientes_CodMicronutrientes)
    REFERENCES Micronutrientes (CodMicronutrientes);
 
ALTER TABLE Retorno ADD CONSTRAINT FK_Retorno_2
    FOREIGN KEY (fk_AtividadeFisica_CodAtividade)
    REFERENCES AtividadeFisica (CodAtividade);
 
ALTER TABLE Retorno ADD CONSTRAINT FK_Retorno_3
    FOREIGN KEY (FK_HabitoUrinario_CodHU)
    REFERENCES HabitoUrinario (CodHabUri);
 
ALTER TABLE Retorno ADD CONSTRAINT FK_Retorno_4
    FOREIGN KEY (ConsRealizar, Med/Sup, AtividadeFisica, QueixasNutri)
    REFERENCES RespostaGenerica (CodPergunta, CodPergunta, CodPergunta, CodPergunta);
 
ALTER TABLE Retorno ADD CONSTRAINT FK_Retorno_5
    FOREIGN KEY (FK_Paciente_CodPaciente)
    REFERENCES Paciente (CodPaciente);
 
ALTER TABLE RetortnoMedSup ADD CONSTRAINT FK_RetortnoMedSup_1
    FOREIGN KEY (FK_Retorno_CodRetorno)
    REFERENCES Retorno (CodRetorno);
 
ALTER TABLE RetortnoMedSup ADD CONSTRAINT FK_RetortnoMedSup_2
    FOREIGN KEY (FK_MedSup_CodMedSup)
    REFERENCES MedSup (CodMedSup);
 
ALTER TABLE RetornoDificuldades ADD CONSTRAINT FK_RetornoDificuldades_1
    FOREIGN KEY (FK_Retorno_CodRetorno)
    REFERENCES Retorno (CodRetorno);
 
ALTER TABLE RetornoDificuldades ADD CONSTRAINT FK_RetornoDificuldades_2
    FOREIGN KEY (FK_Dificuldades_CodDificuldades)
    REFERENCES Dificuldades (CodDificuldade);
 
ALTER TABLE Dieta ADD CONSTRAINT FK_Dieta_2
    FOREIGN KEY (FK_Paciente_CodPaciente)
    REFERENCES Paciente (CodPaciente);
 
ALTER TABLE RetornoLiquidos ADD CONSTRAINT FK_RetornoLiquidos_1
    FOREIGN KEY (FK_Retorno_CodRetorno)
    REFERENCES Retorno (CodRetorno);
 
ALTER TABLE RetornoLiquidos ADD CONSTRAINT FK_RetornoLiquidos_2
    FOREIGN KEY (FK_Liquidos_CodLiquidos)
    REFERENCES Liquidos (CodLiquido);
 
ALTER TABLE Consulta ADD CONSTRAINT FK_Consulta_2
    FOREIGN KEY (fk_Paciente_FK_Genero_CodGenero)
    REFERENCES Paciente (CodPaciente);
 
ALTER TABLE Consulta ADD CONSTRAINT FK_Consulta_3
    FOREIGN KEY (FK_Nutricionista_CodNutri)
    REFERENCES Nutricionista (CodNutri);
 
ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_2
    FOREIGN KEY (FK_Permissao_CodPermissao)
    REFERENCES Permissao (CodPermissao);
 
ALTER TABLE Nutricionista ADD CONSTRAINT FK_Nutricionista_2
    FOREIGN KEY (FK_Usuario_Codusuario)
    REFERENCES Usuario (CodUsuario);