# 🧪 ROTEIRO COMPLETO DE TESTES POSTMAN

## CONFIGURAÇÃO INICIAL
- **Base URL**: http://localhost:3333
- **Server Status**: ✅ Rodando na porta 3333

---

## 📋 TESTES PARA SCREENSHOTS

### 1️⃣ **TESTE 1: Status da API**
```
Method: GET
URL: http://localhost:3333/
Headers: (nenhum)
Body: (nenhum)

RESULTADO ESPERADO:
{
    "apiStatus": "OK", 
    "prisma": "Connected"
}
Status: 200 OK

📸 SCREENSHOT: Salvar como "01-status-api.png"
```

### 2️⃣ **TESTE 2: Registro de Admin**
```
Method: POST
URL: http://localhost:3333/admin/register
Headers: 
- Content-Type: application/json

Body (JSON):
{
    "nome": "Administrador Sistema",
    "email": "admin@vidaplus.com", 
    "senha": "senha123",
    "confirmaSenha": "senha123",
    "perfil": "Administrador"
}

RESULTADO ESPERADO:
{
    "token": "eyJhbGciOiJIUzI1NiIsInR..."
}
Status: 201 Created

📸 SCREENSHOT: Salvar como "02-registro-admin.png"
⚠️ IMPORTANTE: Copie o token para usar nos próximos testes!
```

### 3️⃣ **TESTE 3: Login de Admin**
```
Method: POST
URL: http://localhost:3333/admin/login
Headers:
- Content-Type: application/json

Body (JSON):
{
    "email": "admin@vidaplus.com",
    "senha": "senha123"
}

RESULTADO ESPERADO:
{
    "msg": "Admin logged in successfully",
    "token": "eyJhbGciOiJIUzI1NiIsInR..."
}
Status: 200 OK

📸 SCREENSHOT: Salvar como "03-login-admin.png"
```

### 4️⃣ **TESTE 4: Cadastro de Unidade Hospitalar**
```
Method: POST
URL: http://localhost:3333/hospital/register
Headers:
- Content-Type: application/json
- Authorization: Bearer [COLE_O_TOKEN_AQUI]

Body (JSON):
{
    "nome": "Hospital Central VidaPlus",
    "endereco": "Avenida das Flores, 1234, Centro",
    "telefone": "(11) 3333-4444",
    "capacidade": 200,
    "tipo": "Hospital"
}

RESULTADO ESPERADO:
{
    "id": "uuid-da-unidade",
    "nome": "Hospital Central VidaPlus",
    ...
}
Status: 201 Created

📸 SCREENSHOT: Salvar como "04-cadastro-hospital.png"
⚠️ IMPORTANTE: Copie o "id" da unidade para usar no próximo teste!
```

### 5️⃣ **TESTE 5: Cadastro de Paciente**
```
Method: POST
URL: http://localhost:3333/pacientes/register
Headers:
- Content-Type: application/json
- Authorization: Bearer [COLE_O_TOKEN_AQUI]

Body (JSON):
{
    "nome": "João Silva Santos",
    "cpf": "12345678901",
    "email": "joao.silva@email.com",
    "telefone": "(11) 99999-8888",
    "dataNascimento": "1990-05-15T00:00:00.000Z",
    "genero": "Masculino",
    "unidadeId": "[COLE_O_ID_DA_UNIDADE_AQUI]"
}

RESULTADO ESPERADO:
{
    "id": "uuid-do-paciente",
    "nome": "João Silva Santos",
    ...
}
Status: 201 Created

📸 SCREENSHOT: Salvar como "05-cadastro-paciente.png"
```

### 6️⃣ **TESTE 6: Lista de Pacientes**
```
Method: GET
URL: http://localhost:3333/pacientes
Headers:
- Authorization: Bearer [COLE_O_TOKEN_AQUI]

RESULTADO ESPERADO:
[
    {
        "id": "uuid",
        "nome": "João Silva Santos",
        "email": "joao.silva@email.com",
        ...
    }
]
Status: 200 OK

📸 SCREENSHOT: Salvar como "06-lista-pacientes.png"
```

### 7️⃣ **TESTE 7: Erro de Segurança (Sem Token)**
```
Method: GET
URL: http://localhost:3333/pacientes
Headers: (REMOVER o Authorization)

RESULTADO ESPERADO:
{
    "msg": "Token não fornecido"
}
Status: 401 Unauthorized

📸 SCREENSHOT: Salvar como "07-erro-sem-token.png"
```

### 8️⃣ **TESTE 8: Erro de Validação**
```
Method: POST
URL: http://localhost:3333/pacientes/register  
Headers:
- Content-Type: application/json
- Authorization: Bearer [COLE_O_TOKEN_AQUI]

Body (JSON) - COM ERRO PROPOSITAL:
{
    "nome": "",
    "cpf": "123",
    "email": "email-invalido"
}

RESULTADO ESPERADO:
{
    "errors": [
        {
            "code": "too_small",
            "path": "nome", 
            "message": "String must contain at least 1 character(s)"
        },
        ...
    ]
}
Status: 400 Bad Request

📸 SCREENSHOT: Salvar como "08-erro-validacao.png"
```

---

## 📸 COMO TIRAR OS SCREENSHOTS

### **Preparação da Tela:**
1. Maximize o Postman
2. Configure para mostrar:
   - A requisição (URL, Headers, Body)
   - A resposta (Status, Body, Headers)
   - O tempo de resposta

### **Para Cada Teste:**
1. Configure a requisição conforme o roteiro
2. Clique em **"Send"**
3. Aguarde a resposta
4. **Print da tela inteira** (Alt + Print Screen)
5. Cole no Paint/Word e salve com o nome sugerido
6. **OU** use a ferramenta de recorte do Windows (Win + Shift + S)

### **Dicas para Screenshots Profissionais:**
- ✅ Mostra a URL completa
- ✅ Headers visíveis (especialmente Authorization)
- ✅ Body da requisição visível
- ✅ Status code destacado (200, 201, 400, 401)
- ✅ Resposta JSON formatada
- ✅ Tempo de resposta visível

---

## 📁 ORGANIZAÇÃO DOS SCREENSHOTS

Crie uma pasta: **"Screenshots_VidaPlus"** com:
- 01-status-api.png
- 02-registro-admin.png  
- 03-login-admin.png
- 04-cadastro-hospital.png
- 05-cadastro-paciente.png
- 06-lista-pacientes.png
- 07-erro-sem-token.png
- 08-erro-validacao.png

---

## 📝 PARA SEU TRABALHO ACADÊMICO

Inclua no documento:

```markdown
## 5.4 Evidências de Teste

### 5.4.1 Teste de Status da API
![Status da API](screenshots/01-status-api.png)
*Figura X: Teste de conectividade da API VidaPlus*

### 5.4.2 Teste de Autenticação
![Login Admin](screenshots/03-login-admin.png) 
*Figura Y: Teste de autenticação de administrador*

### 5.4.3 Teste de Segurança
![Erro sem token](screenshots/07-erro-sem-token.png)
*Figura Z: Teste de proteção de endpoint sem token*

[Continue para todos os outros testes...]
```

---

## 🎯 RESULTADO FINAL

Com esses screenshots, você terá **evidências visuais** de que:
- ✅ A API está funcionando
- ✅ Autenticação está implementada
- ✅ CRUD está operacional
- ✅ Validações estão funcionando  
- ✅ Segurança está implementada
- ✅ Tratamento de erros funciona
