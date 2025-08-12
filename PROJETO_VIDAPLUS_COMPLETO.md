# SISTEMA DE GESTÃO HOSPITALAR E DE SERVIÇOS DE SAÚDE (SGHSS)
## VIDAPLUS - PROJETO MULTIDISCIPLINAR

**Aluno:** [antonio francisco barbosa neto]  
**RU:** [ 4491728 ]  
**Curso:** [PAP RECIFE (CENTRO - LAPAD) - PE]  
**Polo:** [SEU POLO AQUI]  
**Disciplina:** Projeto Multidisciplinar  
**Professor:** Winston Sen Lun Fung, Me.  
**Semestre:** 2025A1

---

## SUMÁRIO

1. [Introdução](#introdução)
2. [Análise e Requisitos](#análise-e-requisitos)
3. [Modelagem e Arquitetura](#modelagem-e-arquitetura)
4. [Implementação](#implementação)
5. [Plano de Testes](#plano-de-testes)
6. [Conclusão](#conclusão)
7. [Referências](#referências)
8. [Anexos](#anexos)

---

## 1. INTRODUÇÃO

### 1.1 Contexto do Projeto

A instituição VidaPlus administra uma rede de unidades de saúde que inclui hospitais, clínicas de bairro, laboratórios e equipes de home care. Com o crescimento das operações e a necessidade de modernização dos processos, surgiu a demanda por um Sistema de Gestão Hospitalar e de Serviços de Saúde (SGHSS) integrado e escalável.

### 1.2 Objetivos

**Objetivo Geral:**
Desenvolver um sistema back-end robusto e seguro para centralizar as operações da VidaPlus, atendendo aos requisitos de gestão hospitalar, compliance com LGPD e telemedicina.

**Objetivos Específicos:**
- Implementar APIs RESTful para gestão de pacientes, profissionais e consultas
- Garantir autenticação e autorização seguras
- Desenvolver sistema de agendamento e prontuários eletrônicos
- Implementar compliance com LGPD e auditoria
- Criar infraestrutura para telemedicina

### 1.3 Principais Usuários

- **Pacientes:** Agendam consultas, acessam histórico clínico, realizam teleconsultas
- **Profissionais de Saúde:** Gerenciam agendas, atualizam prontuários, emitem prescrições
- **Administradores:** Controlam cadastros, geram relatórios, gerenciam sistema

### 1.4 Relevância do Sistema

O SGHSS é fundamental para:
- Centralizar informações médicas com segurança
- Otimizar processos hospitalares
- Facilitar atendimento remoto (telemedicina)
- Garantir compliance regulatório
- Melhorar experiência de pacientes e profissionais

---

## 2. ANÁLISE E REQUISITOS

### 2.1 Requisitos Funcionais

| ID | Descrição | Prioridade | Implementado |
|---|---|---|---|
| RF001 | Cadastrar dados de pacientes (nome, CPF, email, etc.) | Alta | ✅ |
| RF002 | Agendar consultas presenciais e online | Alta | ✅ |
| RF003 | Gerenciar prontuários eletrônicos | Alta | ✅ |
| RF004 | Emitir prescrições digitais | Alta | ✅ |
| RF005 | Controle de acesso por perfis (Admin, Profissional, Paciente) | Alta | ✅ |
| RF006 | Gerenciar profissionais de saúde (médicos, enfermeiros) | Alta | ✅ |
| RF007 | Controlar internações e leitos | Média | ✅ |
| RF008 | Sistema de telemedicina com links seguros | Média | ✅ |
| RF009 | Gerenciar unidades hospitalares | Alta | ✅ |
| RF010 | Sistema de logs e auditoria | Alta | ✅ |

### 2.2 Requisitos Não Funcionais

| ID | Descrição | Critério de Aceitação |
|---|---|---|
| RNF001 | Segurança - Criptografia de senhas | Uso de bcrypt para hash |
| RNF002 | Autenticação JWT | Token válido por 24h |
| RNF003 | Conformidade LGPD | Controle de acesso a dados sensíveis |
| RNF004 | Performance | Resposta < 2s em consultas |
| RNF005 | Escalabilidade | Suporte a múltiplas unidades |
| RNF006 | Disponibilidade | Sistema 24/7 |
| RNF007 | Auditoria | Logs de todas as operações |
| RNF008 | Validação de Dados | Validação rigorosa com Zod |

### 2.3 Casos de Uso Principais

**UC001 - Autenticação de Usuário**
- **Ator:** Administrador, Profissional
- **Fluxo:** Login → Validação → Geração de Token JWT
- **Pós-condição:** Usuário autenticado com token válido

**UC002 - Cadastro de Paciente**
- **Ator:** Administrador, Profissional
- **Pré-condição:** Usuário autenticado
- **Fluxo:** Validar dados → Verificar duplicata → Criar registro
- **Pós-condição:** Paciente cadastrado no sistema

**UC003 - Agendamento de Consulta**
- **Ator:** Administrador, Profissional
- **Pré-condição:** Paciente e Profissional cadastrados
- **Fluxo:** Definir data/hora → Verificar disponibilidade → Confirmar agendamento
- **Pós-condição:** Consulta agendada

---

## 3. MODELAGEM E ARQUITETURA

### 3.1 Arquitetura do Sistema

O sistema utiliza **arquitetura em camadas (MVC)** com as seguintes responsabilidades:

```
┌─────────────────┐
│   Controllers   │ ← Recebe requisições HTTP, valida entrada
├─────────────────┤
│    Services     │ ← Lógica de negócio e regras
├─────────────────┤
│   Repositories  │ ← Acesso a dados (Prisma ORM)
├─────────────────┤
│    Database     │ ← PostgreSQL
└─────────────────┘
```

### 3.2 Modelo de Dados

#### 3.2.1 Entidades Principais

**Paciente:**
- id (UUID, PK)
- nome, cpf, email, telefone
- dataNascimento, genero
- unidadeId (FK)

**Profissional:**
- id (UUID, PK)
- nome, crm, coren, cargo
- especialidade, unidadeId (FK)

**Consulta:**
- id (UUID, PK)
- pacienteId, profissionalId (FK)
- data, tipo, status, observacoes

**Prontuário:**
- id (UUID, PK)
- consultaId, pacienteId, profissionalId (FK)
- descricao, prescricoes[]

### 3.2.2 Relacionamentos
- Paciente 1:N Consultas
- Profissional 1:N Consultas  
- Consulta 1:1 Prontuário
- Unidade 1:N Pacientes/Profissionais

### 3.3 Tecnologias Escolhidas

**Backend:**
- **Node.js + TypeScript:** Tipagem estática e performance
- **Express.js:** Framework web minimalista e flexível
- **Prisma ORM:** Type-safe database access
- **PostgreSQL:** Banco relacional robusto

**Segurança:**
- **JWT:** Autenticação stateless
- **bcrypt:** Hash seguro de senhas
- **Zod:** Validação de schemas

**Infraestrutura:**
- **Docker:** Containerização do banco
- **Winston:** Sistema de logs estruturados

---

## 4. IMPLEMENTAÇÃO

### 4.1 Estrutura de Pastas

```
src/
├── controllers/     # Controladores HTTP
├── services/       # Lógica de negócio  
├── routes/         # Definição de rotas
├── middlewares/    # Auth e error handling
├── schemas/        # Validação Zod
├── utils/          # Funções auxiliares
├── lib/           # Prisma client e logger
└── constants/     # Constantes e configs
```

### 4.2 Principais Endpoints Implementados

#### 4.2.1 Autenticação
```http
POST /admin/register
Content-Type: application/json

{
  "nome": "Admin Sistema",
  "email": "admin@vidaplus.com",
  "senha": "senha123",
  "confirmaSenha": "senha123",
  "perfil": "Administrador"
}
```

**Resposta Sucesso (201):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### 4.2.2 Cadastro de Paciente
```http
POST /pacientes
Authorization: Bearer [token]
Content-Type: application/json

{
  "nome": "Maria Silva",
  "cpf": "12345678900", 
  "email": "maria@exemplo.com",
  "telefone": "11999999999",
  "dataNascimento": "1988-07-01T00:00:00.000Z",
  "genero": "Feminino",
  "unidadeId": "uuid-da-unidade"
}
```

#### 4.2.3 Agendamento de Consulta
```http
POST /consulta
Authorization: Bearer [token]
Content-Type: application/json

{
  "pacienteId": "uuid-do-paciente",
  "profissionalId": "uuid-do-profissional", 
  "unidadeId": "uuid-da-unidade",
  "data": "2025-06-10T10:00:00.000Z",
  "tipo": "Consulta",
  "status": "Agendado"
}
```

### 4.3 Implementação de Segurança

#### 4.3.1 Middleware de Autenticação
```typescript
export const checkingAuth = (cargo: string[]) => {
    return (req: Request, res: Response, next: NextFunction) => {
        const validator = new TokenService();
        const authHeader = req.headers.authorization;
        const token = authHeader?.split(' ')[1];

        if (!token) {
            return res.status(401).json({ msg: 'Token inválido' });
        }

        const payload = validator.validateToken(token);
        if (!payload || !cargo.includes(payload.cargo)) {
            return res.status(401).json({ msg: 'Não autorizado' });
        }
        
        next();
    };
};
```

#### 4.3.2 Hash de Senhas
```typescript
import bcrypt from 'bcrypt';

export const hashPassword = async (password: string): Promise<string> => {
    const saltRounds = 12;
    return await bcrypt.hash(password, saltRounds);
};
```

### 4.4 Validação de Dados
```typescript
// Schema para cadastro de paciente
export const PacienteSchema = z.object({
    nome: z.string().min(1).max(255),
    cpf: z.string().length(11),
    email: z.string().email(),
    telefone: z.string().min(10).max(15),
    dataNascimento: z.string().datetime(),
    genero: z.string(),
    unidadeId: z.string().uuid()
});
```

### 4.5 Sistema de Logs
```typescript
import winston from 'winston';

const logger = winston.createLogger({
    level: 'info',
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.json()
    ),
    transports: [
        new winston.transports.File({ filename: 'error.log', level: 'error' }),
        new winston.transports.File({ filename: 'combined.log' }),
        new winston.transports.Console()
    ]
});
```

---

## 5. PLANO DE TESTES

### 5.1 Estratégia de Testes

O plano de testes foi desenvolvido para garantir a qualidade e segurança do sistema, cobrindo testes funcionais, de segurança e de performance.

### 5.2 Testes Funcionais

#### 5.2.1 Casos de Teste - Autenticação

| Caso | Descrição | Entrada | Resultado Esperado |
|------|-----------|---------|-------------------|
| CT001 | Login com credenciais válidas | email/senha corretos | Token JWT válido (200) |
| CT002 | Login com senha inválida | senha incorreta | Erro "Invalid email or password" (400) |
| CT003 | Login com email inexistente | email não cadastrado | Erro "Invalid email or password" (404) |
| CT004 | Registro com emails duplicados | email já existe | Erro "E-mail is already in use" (400) |

#### 5.2.2 Casos de Teste - Cadastro de Paciente

| Caso | Descrição | Entrada | Resultado Esperado |
|------|-----------|---------|-------------------|
| CT005 | Cadastrar paciente com dados válidos | Todos os campos preenchidos corretamente | Paciente criado (201) |
| CT006 | Cadastrar com CPF duplicado | CPF já existente | Erro "CPF is already registered" (400) |
| CT007 | Cadastrar sem token de autenticação | Sem Authorization header | Erro "Token não fornecido" (401) |
| CT008 | Cadastrar com unidade inexistente | unidadeId inválido | Erro "Hospital unit not found" (404) |

#### 5.2.3 Casos de Teste - Agendamento

| Caso | Descrição | Entrada | Resultado Esperado |
|------|-----------|---------|-------------------|
| CT009 | Agendar consulta válida | Dados corretos | Consulta agendada (201) |
| CT010 | Agendar com profissional inexistente | profissionalId inválido | Erro "Professional not found" (404) |
| CT011 | Agendar consulta no passado | Data anterior à atual | Erro de validação (400) |

### 5.3 Testes de Segurança

#### 5.3.1 Autenticação e Autorização
- **Teste de Token Expirado:** Verificar rejeição de tokens vencidos
- **Teste de Token Inválido:** Verificar rejeição de tokens malformados  
- **Teste de Autorização:** Verificar que usuários só acessam recursos permitidos
- **Teste de Força Bruta:** Limitar tentativas de login

#### 5.3.2 Proteção de Dados
- **Hash de Senhas:** Verificar que senhas nunca são armazenadas em texto plano
- **Sanitização:** Validar entrada para prevenir SQL Injection
- **LGPD Compliance:** Verificar controle de acesso a dados pessoais

### 5.4 Testes de API com Postman

#### 5.4.1 Coleção de Testes
Foi criada uma collection no Postman (`mock/VidaPlus.postman_collection.json`) contendo:

- **Autenticação:** Login e registro de administradores
- **CRUD Pacientes:** Criar, listar, atualizar e deletar pacientes
- **CRUD Profissionais:** Gestão de profissionais de saúde
- **Agendamentos:** Criar e gerenciar consultas
- **Prescrições:** Emitir e atualizar prescrições médicas

#### 5.4.2 Exemplo de Teste Automatizado
```javascript
// Teste de login bem-sucedido
pm.test("Login successful", function () {
    pm.response.to.have.status(200);
    pm.expect(pm.response.json()).to.have.property('token');
    
    // Salvar token para próximas requisições
    pm.environment.set("authToken", pm.response.json().token);
});

// Teste de validação de campos obrigatórios
pm.test("Required fields validation", function () {
    pm.response.to.have.status(400);
    pm.expect(pm.response.json()).to.have.property('errors');
});
```

### 5.5 Testes de Performance

#### 5.5.1 Critérios de Performance
- **Tempo de Resposta:** < 2 segundos para consultas normais
- **Throughput:** Suportar 100 requisições/segundo
- **Disponibilidade:** 99.5% de uptime

#### 5.5.2 Ferramentas Sugeridas
- **JMeter:** Para testes de carga e stress
- **Artillery:** Para testes de performance de API
- **k6:** Para testes automatizados de performance

### 5.6 Testes de Integração

#### 5.6.1 Integração com Banco de Dados
- Testar conexões com PostgreSQL
- Verificar transações e rollbacks
- Testar migrations do Prisma

#### 5.6.2 Integração entre Módulos
- Fluxo completo: Cadastro → Agendamento → Consulta → Prontuário
- Validação de relacionamentos entre entidades
- Testes de integridade referencial

---

## 6. CONCLUSÃO

### 6.1 Objetivos Alcançados

O desenvolvimento do Sistema de Gestão Hospitalar VidaPlus atendeu com sucesso aos principais objetivos propostos:

✅ **Sistema Backend Completo:** Implementação de API RESTful robusta com Node.js/TypeScript  
✅ **Segurança LGPD:** Autenticação JWT, hash de senhas, controle de acesso por perfis  
✅ **Funcionalidades Core:** CRUD completo para pacientes, profissionais, consultas e prontuários  
✅ **Arquitetura Escalável:** Estrutura em camadas preparada para crescimento  
✅ **Qualidade de Código:** Validação rigorosa, tratamento de erros, logs estruturados  

### 6.2 Principais Lições Aprendidas

#### 6.2.1 Aspectos Técnicos
- **TypeScript:** A tipagem estática preveniu muitos bugs em tempo de desenvolvimento
- **Prisma ORM:** Facilitou o acesso ao banco e garantiu type-safety nas consultas
- **Middlewares:** Centralizaram autenticação e tratamento de erros de forma elegante
- **Zod:** Validação de schemas proporcionou maior segurança na entrada de dados

#### 6.2.2 Aspectos de Segurança
- **JWT:** Implementação de autenticação stateless permitiu escalabilidade
- **bcrypt:** Hash seguro de senhas seguindo boas práticas da indústria
- **Controle de Acesso:** Sistema de roles protegeu recursos sensíveis adequadamente

#### 6.2.3 Aspectos de Arquitetura
- **Separação de Responsabilidades:** Controllers, Services e Repositories mantiveram código organizado
- **Docker:** Containerização facilitou setup do ambiente de desenvolvimento
- **Logs Estruturados:** Winston permitiu auditoria e debugging eficientes

### 6.3 Desafios Enfrentados

#### 6.3.1 Complexidade do Domínio
- Modelagem de relacionamentos complexos entre entidades médicas
- Implementação de regras de negócio específicas da área de saúde
- Garantia de integridade dos dados clínicos

#### 6.3.2 Requisitos de Segurança
- Implementação de controles rigorosos para dados sensíveis (LGPD)
- Balanceamento entre segurança e usabilidade
- Auditoria completa de operações críticas

#### 6.3.3 Aspectos Técnicos
- Configuração inicial do ambiente com Docker e Prisma
- Implementação de validações robustas com Zod
- Estruturação de middleware de autenticação flexível

### 6.4 Melhorias Futuras

#### 6.4.1 Funcionalidades Adicionais
- **Frontend Web:** Interface React para administração
- **Mobile App:** Aplicativo para pacientes e profissionais
- **Telemedicina Completa:** Integração com plataformas de videochamada
- **Relatórios Avançados:** Dashboard com métricas e indicadores

#### 6.4.2 Melhorias Técnicas
- **Cache:** Redis para melhorar performance de consultas
- **Microserviços:** Separação em serviços independentes
- **CI/CD:** Pipeline automatizado de deploy
- **Monitoramento:** APM para observabilidade em produção

#### 6.4.3 Integrações
- **Sistemas Externos:** Integração com laboratórios e planos de saúde
- **Pagamentos:** Gateway para cobrança de consultas
- **Notificações:** Sistema de alertas via SMS/WhatsApp/Email

### 6.5 Contribuição para Formação Profissional

Este projeto proporcionou experiência prática valiosa em:

- **Desenvolvimento Full-Stack:** Construção de APIs robustas e escaláveis
- **Segurança de Aplicações:** Implementação de controles de segurança críticos
- **Arquitetura de Software:** Design de sistemas bem estruturados
- **Metodologia de Projeto:** Seguimento de boas práticas de engenharia de software
- **Área de Saúde:** Compreensão de requisitos específicos do domínio médico

### 6.6 Considerações Finais

O Sistema VidaPlus representa uma solução sólida para gestão hospitalar, demonstrando a aplicação prática de conceitos avançados de desenvolvimento de software. A implementação seguiu rigorosamente as melhores práticas da indústria, resultando em um sistema seguro, escalável e de alta qualidade.

O projeto evidencia a capacidade de análise, design e implementação de sistemas complexos, preparando para desafios reais do mercado de tecnologia na área de saúde.

---

## 7. REFERÊNCIAS

1. **Node.js Documentation.** Disponível em: https://nodejs.org/docs/. Acesso em: 2025.

2. **Express.js Guide.** Disponível em: https://expressjs.com/. Acesso em: 2025.

3. **Prisma Documentation.** Disponível em: https://www.prisma.io/docs/. Acesso em: 2025.

4. **TypeScript Handbook.** Disponível em: https://www.typescriptlang.org/docs/. Acesso em: 2025.

5. **JSON Web Tokens Introduction.** Disponível em: https://jwt.io/introduction/. Acesso em: 2025.

6. **Zod Documentation.** Disponível em: https://zod.dev/. Acesso em: 2025.

7. **Winston Logger.** Disponível em: https://github.com/winstonjs/winston. Acesso em: 2025.

8. **LGPD - Lei Geral de Proteção de Dados.** Disponível em: http://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm. Acesso em: 2025.

9. **PostgreSQL Documentation.** Disponível em: https://www.postgresql.org/docs/. Acesso em: 2025.

10. **Docker Documentation.** Disponível em: https://docs.docker.com/. Acesso em: 2025.

11. **RESTful API Design Best Practices.** Disponível em: https://restfulapi.net/. Acesso em: 2025.

12. **bcrypt - Secure Hash Algorithm.** Disponível em: https://www.npmjs.com/package/bcrypt. Acesso em: 2025.

---

## 8. ANEXOS

### Anexo A - Diagrama de Entidade-Relacionamento
*[Incluir diagrama visual do banco de dados]*

### Anexo B - Diagramas UML
*[Incluir diagramas de caso de uso, classes e sequência]*

### Anexo C - Screenshots da Collection Postman
*[Incluir prints dos testes de API]*

### Anexo D - Código-fonte Relevante
*[Trechos de código mais importantes já incluídos no corpo do documento]*

### Anexo E - Scripts de Deploy
*[Incluir docker-compose.yml e scripts de instalação]*

### Anexo F - Logs de Teste
*[Incluir exemplos de logs gerados pelo sistema]*

---

**Links do Projeto:**
- **Repositório GitHub:** [https://github.com/[seu-usuario]/VidaPlus](https://github.com/)
- **Collection Postman:** Arquivo `mock/VidaPlus.postman_collection.json`
- **Documentação API:** Disponível no README.md do repositório

---

*Documento gerado para o Projeto Multidisciplinar - VidaPlus SGHSS*  
*Universidade Virtual do Estado de São Paulo - UNIVESP*  
*2025*
