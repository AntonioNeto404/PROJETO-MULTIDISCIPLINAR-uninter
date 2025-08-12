-- CreateTable
CREATE TABLE "paciente" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "telefone" TEXT NOT NULL,
    "dataNascimento" DATETIME NOT NULL,
    "genero" TEXT NOT NULL,
    "unidadeId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "paciente_unidadeId_fkey" FOREIGN KEY ("unidadeId") REFERENCES "unidade" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "profissional" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "crm" TEXT,
    "coren" TEXT,
    "cargo" TEXT NOT NULL,
    "especialidade" TEXT,
    "unidadeId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "profissional_unidadeId_fkey" FOREIGN KEY ("unidadeId") REFERENCES "unidade" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "agenda" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "dataHora" DATETIME NOT NULL,
    "tipo" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "pacienteId" TEXT NOT NULL,
    "profissionalId" TEXT NOT NULL,
    CONSTRAINT "agenda_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES "paciente" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "agenda_profissionalId_fkey" FOREIGN KEY ("profissionalId") REFERENCES "profissional" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "consulta" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "pacienteId" TEXT NOT NULL,
    "profissionalId" TEXT NOT NULL,
    "unidadeId" TEXT NOT NULL,
    "data" DATETIME NOT NULL,
    "tipo" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "observacoes" TEXT,
    CONSTRAINT "consulta_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES "paciente" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "consulta_profissionalId_fkey" FOREIGN KEY ("profissionalId") REFERENCES "profissional" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "consulta_unidadeId_fkey" FOREIGN KEY ("unidadeId") REFERENCES "unidade" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "telemedicina" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "consultaId" TEXT NOT NULL,
    "linkVideo" TEXT NOT NULL,
    "tokenAcesso" TEXT NOT NULL,
    CONSTRAINT "telemedicina_consultaId_fkey" FOREIGN KEY ("consultaId") REFERENCES "consulta" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "prontuario" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "consultaId" TEXT NOT NULL,
    "pacienteId" TEXT NOT NULL,
    "profissionalId" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    CONSTRAINT "prontuario_consultaId_fkey" FOREIGN KEY ("consultaId") REFERENCES "consulta" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "prontuario_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES "paciente" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "prontuario_profissionalId_fkey" FOREIGN KEY ("profissionalId") REFERENCES "profissional" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "prescricao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "prontuarioId" TEXT NOT NULL,
    "medicamento" TEXT NOT NULL,
    "dosagem" TEXT NOT NULL,
    "observacoes" TEXT,
    CONSTRAINT "prescricao_prontuarioId_fkey" FOREIGN KEY ("prontuarioId") REFERENCES "prontuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "unidade" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "endereco" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "internacao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "pacienteId" TEXT NOT NULL,
    "unidadeId" TEXT NOT NULL,
    "leito" TEXT NOT NULL,
    "dataEntrada" DATETIME NOT NULL,
    "dataSaida" DATETIME,
    "status" TEXT NOT NULL,
    CONSTRAINT "internacao_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES "paciente" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "internacao_unidadeId_fkey" FOREIGN KEY ("unidadeId") REFERENCES "unidade" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "usuario_admin" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "perfil" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "paciente_cpf_key" ON "paciente"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "paciente_email_key" ON "paciente"("email");

-- CreateIndex
CREATE UNIQUE INDEX "profissional_crm_key" ON "profissional"("crm");

-- CreateIndex
CREATE UNIQUE INDEX "profissional_coren_key" ON "profissional"("coren");

-- CreateIndex
CREATE UNIQUE INDEX "telemedicina_consultaId_key" ON "telemedicina"("consultaId");

-- CreateIndex
CREATE UNIQUE INDEX "prontuario_consultaId_key" ON "prontuario"("consultaId");

-- CreateIndex
CREATE UNIQUE INDEX "unidade_nome_key" ON "unidade"("nome");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_admin_email_key" ON "usuario_admin"("email");
